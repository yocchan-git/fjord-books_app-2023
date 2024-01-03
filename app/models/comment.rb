# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :content, presence: true, length: { maximum: 400 }

  def create_user_name_or_email
    if user.name.empty?
      user.email
    else
      user.name
    end
  end
end
