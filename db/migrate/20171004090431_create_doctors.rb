class CreateDoctors < ActiveRecord::Migration[5.1]
  def change
    create_table :doctors do |t|
      t.string :first_name
      t.string :last_name
      t.string :city
      t.string :username
      t.string :password
      t.text :address
      t.string :primary_practice
      t.string :secondary_practice

      t.timestamps
    end
  end
end
