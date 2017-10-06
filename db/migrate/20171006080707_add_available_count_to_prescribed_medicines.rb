class AddAvailableCountToPrescribedMedicines < ActiveRecord::Migration[5.1]
  def change
    add_column :prescribed_medicines, :available_count, :integer
  end
end
