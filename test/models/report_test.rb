# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  FIRST_REPORT = 0

  def setup
    @yocchan = create(:yocchan)
    @takeru = create(:takeru)
    @report = Report.create(user: @yocchan, title: 'よっちゃんの記事', content: 'よっちゃんの記事だよ', created_at: 'Wed, 03 Jan 2024 20:00:00.000000000 JST +09:00')
  end

  test '編集できるユーザの場合' do
    assert @report.editable?(@yocchan)
  end

  test '編集できないユーザの場合' do
    assert_not @report.editable?(@takeru)
  end

  test '時間を表示する' do
    assert_equal 'Wed, 03 Jan 2024'.to_date, @report.created_on
  end

  test 'メンションする日報を取得する' do
    include_url_report = Report.new(user: @takeru, title: 'URLを含む日報', content: "http://localhost:3000/reports/#{@report.id}, よっちゃんの記事")
    include_url_report.save
    assert_equal @report, include_url_report.mentioning_reports[FIRST_REPORT]
  end
end
