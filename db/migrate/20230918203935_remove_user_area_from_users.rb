class RemoveUserAreaFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :user_area, :string
  end
end
