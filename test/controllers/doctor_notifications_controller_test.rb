require 'test_helper'

class DoctorNotificationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @doctor_notification = doctor_notifications(:one)
  end

  test "should get index" do
    get doctor_notifications_url
    assert_response :success
  end

  test "should get new" do
    get new_doctor_notification_url
    assert_response :success
  end

  test "should create doctor_notification" do
    assert_difference('DoctorNotification.count') do
      post doctor_notifications_url, params: { doctor_notification: { doctor_id: @doctor_notification.doctor_id, notes: @doctor_notification.notes, notified_on: @doctor_notification.notified_on, severity: @doctor_notification.severity, title: @doctor_notification.title, user_id: @doctor_notification.user_id } }
    end

    assert_redirected_to doctor_notification_url(DoctorNotification.last)
  end

  test "should show doctor_notification" do
    get doctor_notification_url(@doctor_notification)
    assert_response :success
  end

  test "should get edit" do
    get edit_doctor_notification_url(@doctor_notification)
    assert_response :success
  end

  test "should update doctor_notification" do
    patch doctor_notification_url(@doctor_notification), params: { doctor_notification: { doctor_id: @doctor_notification.doctor_id, notes: @doctor_notification.notes, notified_on: @doctor_notification.notified_on, severity: @doctor_notification.severity, title: @doctor_notification.title, user_id: @doctor_notification.user_id } }
    assert_redirected_to doctor_notification_url(@doctor_notification)
  end

  test "should destroy doctor_notification" do
    assert_difference('DoctorNotification.count', -1) do
      delete doctor_notification_url(@doctor_notification)
    end

    assert_redirected_to doctor_notifications_url
  end
end
