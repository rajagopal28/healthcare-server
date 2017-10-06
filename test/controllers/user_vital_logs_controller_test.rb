require 'test_helper'

class UserVitalLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_vital_log = user_vital_logs(:one)
  end

  test "should get index" do
    get user_vital_logs_url
    assert_response :success
  end

  test "should get new" do
    get new_user_vital_log_url
    assert_response :success
  end

  test "should create user_vital_log" do
    assert_difference('UserVitalLog.count') do
      post user_vital_logs_url, params: { user_vital_log: { logged_on: @user_vital_log.logged_on, notes: @user_vital_log.notes, user_id: @user_vital_log.user_id, vital_name: @user_vital_log.vital_name } }
    end

    assert_redirected_to user_vital_log_url(UserVitalLog.last)
  end

  test "should show user_vital_log" do
    get user_vital_log_url(@user_vital_log)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_vital_log_url(@user_vital_log)
    assert_response :success
  end

  test "should update user_vital_log" do
    patch user_vital_log_url(@user_vital_log), params: { user_vital_log: { logged_on: @user_vital_log.logged_on, notes: @user_vital_log.notes, user_id: @user_vital_log.user_id, vital_name: @user_vital_log.vital_name } }
    assert_redirected_to user_vital_log_url(@user_vital_log)
  end

  test "should destroy user_vital_log" do
    assert_difference('UserVitalLog.count', -1) do
      delete user_vital_log_url(@user_vital_log)
    end

    assert_redirected_to user_vital_logs_url
  end
end
