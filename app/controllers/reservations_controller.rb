class ReservationsController < ApplicationController
  
  before_action :authenticate_user!, except: [:teacher_index, :teacher_new, :teacher_create, :teacher_show, :teacher_destroy, :all_day_new]
  
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
  
  def all_day_new
    @reservation = Reservation.new
    @start_time = Time.zone.parse(params[:start_time])
    @end_time = Time.zone.parse(params[:end_time])
    message = Reservation.check_reservation_day(@start_time)
    if !!message
      redirect_to teacher_reservations_index_path(current_teacher.id), flash: { alert: message }
    end 
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
      flash[:success]= "講師の予定を登録しました。"
      redirect_to teacher_reservations_index_path(current_teacher.id)
    else
      flash.now[:alert] = "予約が登録できませんでした。"
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
      redirect_to user_teacher_reservation_path(@reservation.user_id, @reservation.teacher_id, @reservation.id)
    else
      flash.now[:alert] = "予約が登録できません。"
      render :new
    end 
  end 
  
  def destroy
    @reservation = Reservation.find(params[:id])
    @user = User.find(@reservation.user_id)
    @teacher = Teacher.find(@reservation.teacher_id)
    @start_time = @reservation.start_time
    if @reservation.destroy
      UserMailer.with(user: @user, teacher: @teacher, start_time: @start_time).reservation_delete_email.deliver_later #withメソッドでアクションメーラーのメソッドに必要な情報を渡す。
      flash[:success] = "予約を削除しました。"
      redirect_to user_path(current_user.id)
    else 
      flash.now[:alert] = "予約が削除できませんでした。"
      render "users/show"
    end 
  end 
  
  def teacher_destroy
    @reservation = Reservation.find(params[:id])
    if @reservation.destroy
      flash[:success] = "講師の予定を削除しました。"
      redirect_to teacher_reservations_index_path(current_teacher.id)
    else 
      flash.now[:alert] = "講師の予定が削除できませんでした。"
      render teacher_index_path
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
