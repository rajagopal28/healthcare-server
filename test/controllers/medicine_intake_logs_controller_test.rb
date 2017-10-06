require 'test_helper'

class MedicineIntakeLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @medicine_intake_log = medicine_intake_logs(:one)
  end

  test "should get index" do
    get medicine_intake_logs_url
    assert_response :success
  end

  test "should get new" do
    get new_medicine_intake_log_url
    assert_response :success
  end

  test "should create medicine_intake_log" do
    assert_difference('MedicineIntakeLog.count') do
      post medicine_intake_logs_url, params: { medicine_intake_log: { logged_on: @medicine_intake_log.logged_on, notes: @medicine_intake_log.notes, part_of_day: @medicine_intake_log.part_of_day, prescribed_medicine_id: @medicine_intake_log.prescribed_medicine_id, user_id: @medicine_intake_log.user_id } }
    end

    assert_redirected_to medicine_intake_log_url(MedicineIntakeLog.last)
  end

  test "should show medicine_intake_log" do
    get medicine_intake_log_url(@medicine_intake_log)
    assert_response :success
  end

  test "should get edit" do
    get edit_medicine_intake_log_url(@medicine_intake_log)
    assert_response :success
  end

  test "should update medicine_intake_log" do
    patch medicine_intake_log_url(@medicine_intake_log), params: { medicine_intake_log: { logged_on: @medicine_intake_log.logged_on, notes: @medicine_intake_log.notes, part_of_day: @medicine_intake_log.part_of_day, prescribed_medicine_id: @medicine_intake_log.prescribed_medicine_id, user_id: @medicine_intake_log.user_id } }
    assert_redirected_to medicine_intake_log_url(@medicine_intake_log)
  end

  test "should destroy medicine_intake_log" do
    assert_difference('MedicineIntakeLog.count', -1) do
      delete medicine_intake_log_url(@medicine_intake_log)
    end

    assert_redirected_to medicine_intake_logs_url
  end
end
