class Prescription < ApplicationRecord
  belongs_to :user
  belongs_to :doctor
  has_many :prescribed_medicines
end
