# frozen_string_literal: true

class MentionReport < ApplicationRecord
  belongs_to :mentioning, class_name: 'Report'
  belongs_to :mentioned, class_name: 'Report'

  validates :mentioning_id, presence: true, uniqueness: { scope: :mentioned_id }
  validates :mentioned_id, presence: true, uniqueness: { scope: :mentioning_id }
end
