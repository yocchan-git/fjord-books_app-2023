# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  def create_user_name_or_email
    unless user.name.empty?
      user.name
    else
      user.email
    end
  end
end
