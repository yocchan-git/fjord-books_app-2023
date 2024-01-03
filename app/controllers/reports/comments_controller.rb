# frozen_string_literal: true

class Reports::CommentsController < ApplicationController
  before_action :set_commentable

  def create
    comment = @commentable.comments.build(comment_params)
    comment.user = current_user

    if comment.save
      redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      @report = @commentable
      render 'reports/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_commentable
    @commentable = Report.find(params[:report_id])
  end
end
