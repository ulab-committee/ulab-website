# frozen_string_literal: true

require 'test_helper'

class PagesHelperTest < ActionView::TestCase
  test 'the truth' do
    assert true
  end

  test 'should return most recent conference' do
    assert_kind_of Spina::Conferences::Conference, latest_conference
  end
end
