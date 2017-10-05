class CreatePrescribedMedicines < ActiveRecord::Migration[5.1]
  def change
    create_table :prescribed_medicines do |t|
      t.references :medicine, foreign_key: true
      t.references :prescription, foreign_key: true
      t.text :notes
      t.boolean :before_breakfast
      t.boolean :after_breakfast
      t.boolean :before_lunch
      t.boolean :after_lunch
      t.boolean :before_dinner
      t.boolean :after_dinner

      t.timestamps
    end
  end
end
