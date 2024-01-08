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

    ActiveRecord::Base.transaction do
      @report.save_with_mentions!(report_params)
    end

    redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
  rescue ActiveRecord::RecordInvalid
    render :new, status: :unprocessable_entity
  end

  def update
    ActiveRecord::Base.transaction do
      @report.save_with_mentions!(report_params)
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

  def set_report
    @report = current_user.reports.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content)
  end
end
