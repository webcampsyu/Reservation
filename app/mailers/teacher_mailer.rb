# rails g mailer Teacherでファイルを生成

class TeacherMailer < ApplicationMailer
  
  default from: '"事務局" <no-reply@spaschool.jp>'
  
  def reservation_delete_email
    @user = params[:user]
    @teacher = params[:teacher]
    @start_time = params[:start_time]
    mail(to: @teacher.email, subject: '予約が削除されました')
  end 
  
  def temp_reservation_email
    @temp_reservation = params[:temp_reservation]
    @user = User.find(@temp_reservation.user_id)
    @teacher = Teacher.find(@temp_reservation.teacher_id)
    mail(to: @teacher.email, subject: '仮予約が登録されました')
  end 
  
  def 
  
end
