# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :mentionings, foreign_key: :mentioning_id, class_name: 'MentionReport', dependent: :destroy
  has_many :mentioneds, foreign_key: :mentioned_id, class_name: 'MentionReport', dependent: :destroy
  has_many :mentioning_reports, through: :mentionings, source: :mentioned
  has_many :mentioned_reports, through: :mentioneds, source: :mentioning

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end
end
