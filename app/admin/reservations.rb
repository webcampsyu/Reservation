ActiveAdmin.register Reservation do
  permit_params :user_id, :teacher_id, :temp_reservation_id, :start_time, :end_time, :address_select

  form do |f|
    f.inputs  do
      f.input :user_id
      f.input :teacher_id
      f.input :temp_reservation_id
      f.input :start_time
      f.input :end_time
      f.input :address_select, :as => :check_boxes
    end
    f.actions
  end  
end