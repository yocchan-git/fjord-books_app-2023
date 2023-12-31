# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[edit update destroy]

  def index
    @reports = Report.includes(:user).order(id: :desc).page(params[:page])
  end

  def show
    @report = Report.find(params[:id])
  end

  # GET /reports/new
  def new
    @report = current_user.reports.new
  end

  def edit; end

  def create
    @report = current_user.reports.new(report_params)
    mentioned_reports = create_mention(@report)

    ActiveRecord::Base.transaction do
      @report.save!
      mentioned_reports.each do |mentioned_report|
        MentionReport.create!(mentioning: @report, mentioned: mentioned_report)
      end
    end

    redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
  rescue ActiveRecord::RecordInvalid
    render :new, status: :unprocessable_entity
  end

  def update
    ActiveRecord::Base.transaction do
      @report.update!(report_params)
      @report.mentionings.each(&:destroy!)
      mentioned_reports = create_mention(@report)
      mentioned_reports.each do |mentioned_report|
        MentionReport.create!(mentioning: @report, mentioned: mentioned_report)
      end
    end

    redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)
  rescue ActiveRecord::RecordInvalid
    render :edit, status: :unprocessable_entity
  end

  def destroy
    @report.destroy

    redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def create_mention(report)
    report_content = report.content
    report_ids = report_content.scan(%r{http://localhost:3000/reports/(\d+)}).flatten
    Report.where(id: report_ids)
  end

  def set_report
    @report = current_user.reports.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content)
  end
end
