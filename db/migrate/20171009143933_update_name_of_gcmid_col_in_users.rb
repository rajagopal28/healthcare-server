class UpdateNameOfGcmidColInUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :gmdid, :gcmid
    rename_column :doctors, :gmdid, :gcmid
  end
end
