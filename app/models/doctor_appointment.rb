class DoctorAppointment < ApplicationRecord
  has_one :doctor
  has_one :user
end
