# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @yocchan = create(:user, email: 'yocchan@example.com')
    @report = create(:report, user: @yocchan)

    visit new_user_session_path
    fill_in 'Eメール', with: 'yocchan@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test '日報の新規作成をする' do
    visit reports_url
    click_on '日報の新規作成'

    fill_in 'タイトル', with: @report.title
    fill_in '内容', with: @report.content
    click_button '登録する'

    assert_text '日報が作成されました。'

    assert_text @report.title
    assert_text @report.content
  end

  test '日報の更新をする' do
    visit report_url(@report)
    click_on 'この日報を編集'

    fill_in 'タイトル', with: @report.title + 'タイトルを更新'
    fill_in '内容', with: @report.content + '内容を更新'
    click_button '更新する'

    assert_text '日報が更新されました。'

    assert_text @report.title + 'タイトルを更新'
    assert_text @report.content + '内容を更新'
  end

  test '日報を削除する' do
    visit report_url(@report)

    assert_text @report.title
    assert_text @report.content

    click_button 'この日報を削除'

    assert_no_text @report.title
    assert_no_text @report.content

    assert_text '日報が削除されました。'
  end
end
