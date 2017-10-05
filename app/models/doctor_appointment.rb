class DoctorAppointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :user
end
