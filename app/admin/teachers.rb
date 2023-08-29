ActiveAdmin.register Teacher do

  permit_params :email, :password, :password_confirmation, :teacher_name, :teacher_area, :teacher_img, :teacher_address

  form do |f|
    f.inputs  do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :teacher_name
      f.input :teacher_area
      f.input :teacher_img, :as => :file
      f.input :teacher_address
    end
    f.actions
  end
end
  
