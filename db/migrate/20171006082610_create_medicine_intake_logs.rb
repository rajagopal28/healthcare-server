class CreateMedicineIntakeLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :medicine_intake_logs do |t|
      t.references :prescribed_medicine, foreign_key: true
      t.references :user, foreign_key: true
      t.datetime :logged_on
      t.text :notes
      t.string :part_of_day

      t.timestamps
    end
  end
end
