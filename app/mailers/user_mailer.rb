class UserMailer < ApplicationMailer
  default from: '"事務局" <no-reply@spaschool.jp>'

  def reservation_email
    @reservation = params[:reservation]
    @user = User.find(@reservation.user_id)
    @teacher = Teacher.find(@reservation.teacher_id)
    mail(to: @user.email, subject: '予約が確定しました。')
  end
  
  def temp_reservation_delete_email
    @user = params[:user]
    @teacher = params[:teacher]
    @start_time = params[:start_time]
    mail(to: @user.email, subject: '仮予約が削除されました。')
  end 
  
end
