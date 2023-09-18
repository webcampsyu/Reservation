class RemoveVideoAvailableFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :video_available, :boolean
  end
end
