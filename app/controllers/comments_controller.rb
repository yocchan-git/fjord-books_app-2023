# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    commentable = set_commentable
    comment = commentable.comments.build(comment_params)
    comment.user = current_user

    if comment.save
      redirect_to commentable, notice: 'コメントを作成しました'
    else
      redirect_to commentable, alert: 'コメントの作成に失敗しました'
    end
  end

  def destroy
    @comment = current_user.comments.find_by(id: params[:comment_id])
    redirect_to @comment.commentable, alert: '他の人のコメントは削除できません' if @comment.nil?

    @comment.destroy!
    redirect_to @comment.commentable, notice: 'コメントを削除しました'
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :commentable_type)
  end

  def set_commentable
    case comment_params[:commentable_type]
    when 'report'
      Report.find(params[:report_id])
    when 'book'
      Book.find(params[:book_id])
    end
  end
end
