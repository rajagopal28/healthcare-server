require 'test_helper'

class DoctorAppointmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @doctor_appointment = doctor_appointments(:one)
  end

  test "should get index" do
    get doctor_appointments_url
    assert_response :success
  end

  test "should get new" do
    get new_doctor_appointment_url
    assert_response :success
  end

  test "should create doctor_appointment" do
    assert_difference('DoctorAppointment.count') do
      post doctor_appointments_url, params: { doctor_appointment: { description: @doctor_appointment.description, doctor: @doctor_appointment.doctor, from: @doctor_appointment.from, to: @doctor_appointment.to, user: @doctor_appointment.user } }
    end

    assert_redirected_to doctor_appointment_url(DoctorAppointment.last)
  end

  test "should show doctor_appointment" do
    get doctor_appointment_url(@doctor_appointment)
    assert_response :success
  end

  test "should get edit" do
    get edit_doctor_appointment_url(@doctor_appointment)
    assert_response :success
  end

  test "should update doctor_appointment" do
    patch doctor_appointment_url(@doctor_appointment), params: { doctor_appointment: { description: @doctor_appointment.description, doctor: @doctor_appointment.doctor, from: @doctor_appointment.from, to: @doctor_appointment.to, user: @doctor_appointment.user } }
    assert_redirected_to doctor_appointment_url(@doctor_appointment)
  end

  test "should destroy doctor_appointment" do
    assert_difference('DoctorAppointment.count', -1) do
      delete doctor_appointment_url(@doctor_appointment)
    end

    assert_redirected_to doctor_appointments_url
  end
end
