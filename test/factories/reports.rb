# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    title { '日報のタイトル' }
    content { '日報の内容' }
    association :user
  end
end
