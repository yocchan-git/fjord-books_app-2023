# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '名前がないユーザはメールアドレスを返す' do
    yocchan = build(:user, email: 'yocchan@example.com', name: '')
    assert_equal 'yocchan@example.com', yocchan.name_or_email
  end

  test '名前があるユーザは名前を返す' do
    takeru = build(:user, email: 'takeru@example.com', name: 'たける')
    assert_equal 'たける', takeru.name_or_email
  end
end
