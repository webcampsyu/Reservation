ActiveAdmin.register User do

  permit_params :email, :password, :password_confirmation, :user_name, :user_area, :curriculum, :curriculum_num, :video_available, :user_address

  form do |f|
    f.inputs  do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :user_name
      f.input :user_area
      f.input :curriculum
      f.input :curriculum_num
      f.input :user_address
    end
    f.actions
  end
  
end
