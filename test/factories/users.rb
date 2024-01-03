# frozen_string_literal: true

FactoryBot.define do
  factory :yocchan, class: User do
    sequence(:email) { |n| "yocchan#{n}@example.com" }
    password { 'password' }
  end

  factory :takeru, class: User do
    sequence(:email) { |n| "takeru#{n}@example.com" }
    password { 'password' }
    name { 'たける' }
  end
end
