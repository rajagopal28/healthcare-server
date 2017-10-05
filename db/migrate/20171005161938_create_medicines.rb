class CreateMedicines < ActiveRecord::Migration[5.1]
  def change
    create_table :medicines do |t|
      t.string :name
      t.text :description
      t.string :type
      t.boolean :is_acidic
      t.boolean :infant_safe

      t.timestamps
    end
  end
end
