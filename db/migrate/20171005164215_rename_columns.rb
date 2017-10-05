class RenameColumns < ActiveRecord::Migration[5.1]
  def change
    rename_column :medicines, :type, :medicine_type
  end
end
