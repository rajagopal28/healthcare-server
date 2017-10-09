require 'test_helper'

class UserVitalSummaryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_vital_summary_index_url
    assert_response :success
  end

  test "should get show" do
    get user_vital_summary_show_url
    assert_response :success
  end

end
