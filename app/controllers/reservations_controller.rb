class ReservationsController < ApplicationController
  
  before_action :authenticate_user!, except: [:teacher_index, :teacher_new, :teacher_create]
  
  def index
    @reservations = Reservation.all.where("start_time >= ?", Date.current).where("start_time < ?", Date.current >> 3).where(teacher_id: params[:teacher_id]).order(start_time: :desc)
    @teacher = Teacher.find(params[:teacher_id])
  end 
  
  def teacher_index
    @reservations = Reservation.all.where("day >= ?", Date.current).where("day < ?", Date.current >> 3).where(teacher_id: current_teacher.id).order(day: :desc)
    @teacher = Teacher.find(current_teacher.id)
  end
    
  def choice
    @teachers = Teacher.all
  end
  
  def new
    @user = current_user
    @teacher = Teacher.find(params[:teacher_id])
    @reservation = Reservation.new
    @teacher_id = params[:teacher_id]
    @start_time = Time.zone.parse(params[:day] + " " + params[:time] + " " + "JST") # @dayと@timeを結合して、JST（日本標準時）として日時を作成
    @end_time = @start_time + 90.minutes
  end 
  
  def teacher_new
    @teacher = current_teacher
    @reservation = Reservation.new
    @day = params[:day]
    @time = params[:time]
    @start_time = Time.zone.parse(@day + " " + @time + " " + "JST")
    @end_time = @start_time + 90.minutes
  end
  
  
  def show
    @reservation = Reservation.find(params[:id])
  end 
  
  def teacher_create
  end 
  
  
  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      redirect_to reservation_path @reservation.id
    else
      render :new
    end 
  end 
  
  private
  def reservation_params
    params.require(:reservation).permit(:user_id, :start_time, :end_time)
  end 
  
end
