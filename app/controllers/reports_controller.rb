# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit]
  before_action :corrent_user, only: %i[update destroy]

  def index
    @reports = Report.order(:id).page(params[:page])
  end

  def show; end

  def new
    @report = Report.new
  end

  def create
    @report = current_user.reports.build(report_params)
    if @report.save
      redirect_to reports_path, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      redirect_to new_report_path, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    @report.update(report_params)
    redirect_to report_path(@report), notice: t('controllers.common.notice_update', name: Report.model_name.human)
  end

  def destroy
    @report.destroy
    redirect_to reports_path, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content)
  end

  def corrent_user
    @report = current_user.reports.find_by(id: params[:id])
    redirect_to root_url, status: :see_other if @report.nil?
  end
end
