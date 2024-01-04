# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :content, presence: true, length: { maximum: 400 }

  def create_user_name_or_email
    user.name.presence || user.email
  end
end
