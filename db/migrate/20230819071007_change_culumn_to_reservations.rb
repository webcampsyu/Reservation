class ChangeCulumnToReservations < ActiveRecord::Migration[6.1]
  def change
    change_column_null :reservations, :user_id, true
  end
end
