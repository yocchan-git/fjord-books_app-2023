# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase

  def setup
    @yocchan = create(:user)
    @takeru = create(:user)
    @report = create(:report, user: @yocchan)
  end

  test '編集できるユーザの場合' do
    assert @report.editable?(@yocchan)
  end

  test '編集できないユーザの場合' do
    assert_not @report.editable?(@takeru)
  end

  test '時間を表示する' do
    assert_equal Time.current.to_date, @report.created_on
  end

  test 'メンションする日報を取得する' do
    other_report = create(:report, user: @takeru, content: "http://localhost:3000/reports/#{@report.id}, よっちゃんの記事")
    other_report.save!
    assert_equal @report, other_report.mentioning_reports.first
  end
end
