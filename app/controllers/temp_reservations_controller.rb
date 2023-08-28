class TempReservationsController < ApplicationController
  
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
      UserMailer.with(temp_reservation: @temp_reservation).reservation_email.deliver_later
      redirect_to user_temp_reservation_path(@temp_reservation.user_id, @temp_reservation.teacher_id, @temp_reservation.id)
    else 
      flash.now[:alert] = "予約が登録できませんでした。"
      render :new
    end 
  end 
  
  private
  def temp_reservation_params
    params.require(:temp_reservation).permit(:user_id, :teacher_id, :start_time, :end_time, :address_select)
  end 
  
end
