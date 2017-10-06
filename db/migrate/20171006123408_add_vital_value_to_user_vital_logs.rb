class AddVitalValueToUserVitalLogs < ActiveRecord::Migration[5.1]
  def change
    add_column :user_vital_logs, :vital_value, :integer
  end
end
