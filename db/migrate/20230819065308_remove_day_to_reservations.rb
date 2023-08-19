class RemoveDayToReservations < ActiveRecord::Migration[6.1]
  def change
    remove_column :reservations, :day, :date
  end
end
