class ReservationsController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
    @reservations = Reservation.all.where("day >= ?", Date.current).where("day < ?", Date.current >> 3).order(day: :desc)
  end
  
  def new
    @reservation = Reservation.new
    @day = params[:day] #受け取ったパラメータ（day）の値を代入
    @time = params[:time]
    @start_time = DateTime.parse(@day +""+ @time +""+ "JST") # @dayと@timeを結合して、JST（日本標準時）として日時を作成
  end 
  
  def show
    @reservation = Reservation.find(params[:id])
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
    params.require(:reservation).permit(:day, :time, :user_id, :start_time)
  end 
  
end
