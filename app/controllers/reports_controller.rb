# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_current_user_report, only: %i[edit update destroy]

  def index
    @reports = Report.order(:id).page(params[:page])
  end

  def show
    @report = Report.find(params[:id])
  end

  def new
    @report = Report.new
  end

  def create
    @report = current_user.reports.build(report_params)
    if @report.save
      redirect_to reports_path, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @report.update(report_params)
      redirect_to report_path(@report), notice: t('controllers.common.notice_update', name: Report.model_name.human)
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @report.destroy!
    redirect_to reports_path, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def set_current_user_report
    @report = current_user.reports.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content)
  end
end
