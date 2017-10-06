class MedicineIntakeLog < ApplicationRecord
  belongs_to :prescribed_medicine
  belongs_to :user
end
