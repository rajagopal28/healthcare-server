class CreateDoctorNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :doctor_notifications do |t|
      t.string :title
      t.references :user, foreign_key: true
      t.references :doctor, foreign_key: true
      t.datetime :notified_on
      t.text :notes
      t.string :severity

      t.timestamps
    end
  end
end
