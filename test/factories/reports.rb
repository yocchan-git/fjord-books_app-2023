# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    title { 'よっちゃんの日報' }
    content { 'よっちゃんの日報の内容' }
    association :user, factory: :yocchan
  end
end
