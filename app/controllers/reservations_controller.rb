class ReservationsController < ApplicationController
  
  before_action :authenticate_user!, except: [:teacher_index, :teacher_new, :teacher_create, :teacher_show]
  
  def index
    @reservations = Reservation.all.where("start_time >= ?", Date.current).where("start_time < ?", Date.current >> 3).where(teacher_id: params[:teacher_id]).order(start_time: :desc)
    @teacher = Teacher.find(params[:teacher_id])
  end 
  
  def teacher_index
    @reservation = Reservation.new
    @reservations = Reservation.all.where("start_time >= ?", Date.current).where("start_time < ?", Date.current >> 3).where(teacher_id: current_teacher.id).order(start_time: :desc)
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
    message = Reservation.check_reservation_day(@start_time) #予約データのチェック
    if !!message #messageが真の場合、条件成立
      redirect_to user_teacher_reservations_path(@user.id, @teacher.id), flash: { alert: message }
    end
  end 
  
  def teacher_new
    @reservation = Reservation.new(reservation_teacher_params)
  end
  
  
  def show
    @reservation = Reservation.find(params[:id])
  end 
  
  def teacher_show
    @reservation = Reservation.find(params[:id])
  end 
  
  
  def teacher_create
    @reservation = Reservation.new(reservation_teacher_params)
    if @reservation.save
      redirect_to "/teachers/#{@reservation.teacher_id}/reservations/#{@reservation.id}"
    else
      render :teacher_new
    end
  end 
  
  
  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      UserMailer.with(reservation: @reservation).reservation_email.deliver_later #メール痩身をするための処理
                                                                                 #UserMailerはメール送信用のメーラークラス
                                                                                 #reservation: @reservationはreservationというパラメータ名で@reservationインスタンス変数をメール送信メソッドに渡す。
                                                                                 #.reservation_emailはメール送信のメソッド。UserMailerクラス内で定義されたメソッド
                                                                                 #.deliver_laterはメールを非同期で送信するためのメソッド　
      redirect_to reservation_path @reservation.id
    else
      render :new
    end 
  end 
  
  def destroy
    @reservation = Reservation.find(params[:id])
    if @reservation.destroy
      flash[:success] = "予約を削除しました。"
      redirect_to user_path(current_user.id)
    else 
      render "users/show"
    end 
  end 
  
  
  private
  def reservation_params
    params.require(:reservation).permit(:user_id, :start_time, :end_time)
  end 
  
  def reservation_teacher_params
    params.require(:reservation).permit(:teacher_id, :start_time, :end_time)
  end 
  
  
end
