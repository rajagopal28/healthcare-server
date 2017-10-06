class CreateUserVitalLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :user_vital_logs do |t|
      t.references :user, foreign_key: true
      t.datetime :logged_on
      t.text :notes
      t.string :vital_name

      t.timestamps
    end
  end
end
