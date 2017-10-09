class AddGcmidToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :gmdid, :string
    add_column :doctors, :gmdid, :string
  end
end
