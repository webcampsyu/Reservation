class AddAddressSelectToReservation < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :address_select, :boolean, default: true, null: false
  end
end
