class FixColumnNamesInVitas < ActiveRecord::Migration[5.1]
  def change
    remove_column :user_vital_logs, :vital_name
    add_column :user_vital_logs, :sugar, :decimal
    add_column :user_vital_logs, :temperature, :decimal
    rename_column :user_vital_logs, :vital_value, :pulse
    add_column :user_vital_logs, :pressure, :decimal
  end
end
