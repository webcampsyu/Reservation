class RemoveTimeToReservations < ActiveRecord::Migration[6.1]
  def change
    remove_column :reservations, :time, :string
  end
end
