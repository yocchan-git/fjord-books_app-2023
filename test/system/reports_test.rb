# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = create(:report)

    visit new_user_session_path
    fill_in 'Eメール', with: @report.user.email
    fill_in 'パスワード', with: @report.user.password
    click_button 'ログイン'
  end

  test '日報の新規作成をする' do
    visit reports_url
    click_on '日報の新規作成'

    fill_in 'タイトル', with: @report.content
    fill_in '内容', with: @report.title
    click_button '登録する'

    assert_text '日報が作成されました。'
  end

  test '日報の更新をする' do
    visit report_url(@report)
    click_on 'この日報を編集'

    fill_in 'タイトル', with: @report.content
    fill_in '内容', with: @report.title
    click_button '更新する'

    assert_text '日報が更新されました。'
  end

  test '日報を削除する' do
    visit report_url(@report)
    click_button 'この日報を削除'

    assert_text '日報が削除されました。'
  end
end
