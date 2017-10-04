class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :city
      t.string :username
      t.string :password
      t.text :address

      t.timestamps
    end
  end
end
