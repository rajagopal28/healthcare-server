class CreateDoctorAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :doctor_appointments do |t|
      t.text :description
      t.datetime :from
      t.datetime :to
      t.references :doctor
      t.references :user

      t.timestamps
    end
  end
end
