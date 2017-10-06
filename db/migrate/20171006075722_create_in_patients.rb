class CreateInPatients < ActiveRecord::Migration[5.1]
  def change
    create_table :in_patients do |t|
      t.references :user, foreign_key: true
      t.references :doctor, foreign_key: true
      t.datetime :visting_since
      t.text :notes
      t.string :status
      t.string :for_practice

      t.timestamps
    end
  end
end
