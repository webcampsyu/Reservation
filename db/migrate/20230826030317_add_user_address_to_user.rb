class AddUserAddressToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :user_address, :string, null: false
  end
end
