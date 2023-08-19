class UserMailer < ApplicationMailer
  default from: 'no-reply@spaschool.jp'

  def reservation_email
    @reservation = params[:reservation]
    @user = User.find(@reservation.user_id)
    @teacher = Teacher.find(@reservation.teacher_id)
    mail(to: @teacher.email, subject: '新規予約が登録されました')
  end
  
end
