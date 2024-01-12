# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    title { 'チェリー本３章まで読んだよ' }
    content { 'Rubyの基礎とテストについて学んだ!まだまだ先は長そう...' }
    association :user
  end
end
