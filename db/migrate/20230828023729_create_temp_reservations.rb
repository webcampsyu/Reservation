class CreateTempReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :temp_reservations do |t|
      t.bigint :user_id
      t.bigint :teacher_id, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.boolean :address_select, default: true, null: false

      t.timestamps
    end
  end
end
