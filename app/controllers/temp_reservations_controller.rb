class TempReservationsController < ApplicationController
  
  before_action :authenticate_teacher!, only: [:teacher_destroy]
  before_action :authenticate_user!, only: [:teacher_destroy]
  
  def new
    @user = current_user
    @teacher = Teacher.find(params[:teacher_id])
    @temp_reservation = TempReservation.new
    @teacher_id = params[:teacher_id]
    @start_time = Time.zone.parse(params[:day] + "" + params[:time] + "" + "JST")
    @end_time = @start_time + 90.minutes
    message = TempReservation.check_reservation_day(@start_time)
    if !!message
      redirect_to user_teacher_reservations_path(@user.id, @teacher.id), flash: { alert: message }
    end 
  end 
  
  def show
    @temp_reservation = TempReservation.find(params[:id])
  end 
  
  def create
    @temp_reservation = TempReservation.new(temp_reservation_params)
    if @temp_reservation.save
      TeacherMailer.with(temp_reservation: @temp_reservation).temp_reservation_email.deliver_later
      redirect_to user_temp_reservation_path(@temp_reservation.user_id, @temp_reservation.teacher_id, @temp_reservation.id)
    else 
      flash.now[:alert] = "予約が登録できませんでした。"
      render :new
    end 
  end 
  
  def destroy
    @temp_reservation = TempReservation.find(params[:id])
    @user = User.find(@temp_reservation.user_id)
    @teacher = Teacher.find(@temp_reservation.teacher_id)
    @start_time = @temp_reservation.start_time
    if @temp_reservation.destroy
      TeacherMailer.with(user: @user, teacher: @teacher, start_time: @start_time).temp_reservation_delete_email.deliver_later
      flash[:success] = "仮予約を削除しました。"
      redirect_to user_path(@user.id)
    else 
      flash.now[:alert] = "仮予約が削除できませんでした。"
      render "users/show"
    end 
  end 
  
  def teacher_destroy
    @temp_reservation = TempReservation.find(params[:id])
    @user = User.find(@temp_reservation.user_id)
    @teacher = Teacher.find(@temp_reservation.teacher_id)
    @start_time = @temp_reservation.start_time
    if @temp_reservation.destroy
      UserMialer.with(user: @user, teacher: @teacher, start_time: @start_time).temp_reservation_delete_email.deliver_later
      flash[:success] = "仮予約を削除しました。"
      redirect_to teacher_path(@teacher.id)
    else 
      flash.now[:alert] = "仮予約が削除できませんでした。"
      render "teacher/show"
    end 
  end 
  
  
  private
  def temp_reservation_params
    params.require(:temp_reservation).permit(:user_id, :teacher_id, :start_time, :end_time, :address_select)
  end 
  
end
