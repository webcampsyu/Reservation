class UserMailer < ApplicationMailer
  default from: 'no-reply@spaschool.jp'

  def reservation_email
    @reservation = params[:reservation]
    @user = User.find(@reservation.user_id)
    @teacher = Teacher.find(@reservation.teacher_id)
    mail(to: @user.email, subject: '予約が確定しました。')
  end
  
end
