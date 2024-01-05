# frozen_string_literal: true

class Books::CommentsController < ApplicationController
  def create
    commentable = Book.find(params[:book_id])
    comment = commentable.comments.build(comment_params)
    comment.user = current_user

    if comment.save
      redirect_to commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      @book = commentable
      render 'books/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
