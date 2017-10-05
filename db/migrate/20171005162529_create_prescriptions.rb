class CreatePrescriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :prescriptions do |t|
      t.references :user, foreign_key: true
      t.references :doctor, foreign_key: true
      t.text :notes
      t.datetime :prescribed_on
      t.datetime :valid_till

      t.timestamps
    end
  end
end
