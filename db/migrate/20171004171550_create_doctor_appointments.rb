class CreateDoctorAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :doctor_appointments do |t|
      t.text :description
      t.datetime :from
      t.datetime :to
      t.has_one :doctor, index: true
      t.has_one :user, index: true
      t.timestamps
    end
  end
end
