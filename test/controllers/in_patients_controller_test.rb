require 'test_helper'

class InPatientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @in_patient = in_patients(:one)
  end

  test "should get index" do
    get in_patients_url
    assert_response :success
  end

  test "should get new" do
    get new_in_patient_url
    assert_response :success
  end

  test "should create in_patient" do
    assert_difference('InPatient.count') do
      post in_patients_url, params: { in_patient: { doctor_id: @in_patient.doctor_id, for_practice: @in_patient.for_practice, notes: @in_patient.notes, status: @in_patient.status, user_id: @in_patient.user_id, visting_since: @in_patient.visting_since } }
    end

    assert_redirected_to in_patient_url(InPatient.last)
  end

  test "should show in_patient" do
    get in_patient_url(@in_patient)
    assert_response :success
  end

  test "should get edit" do
    get edit_in_patient_url(@in_patient)
    assert_response :success
  end

  test "should update in_patient" do
    patch in_patient_url(@in_patient), params: { in_patient: { doctor_id: @in_patient.doctor_id, for_practice: @in_patient.for_practice, notes: @in_patient.notes, status: @in_patient.status, user_id: @in_patient.user_id, visting_since: @in_patient.visting_since } }
    assert_redirected_to in_patient_url(@in_patient)
  end

  test "should destroy in_patient" do
    assert_difference('InPatient.count', -1) do
      delete in_patient_url(@in_patient)
    end

    assert_redirected_to in_patients_url
  end
end
