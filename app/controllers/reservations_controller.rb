class ReservationsController < ApplicationController
  
  before_action :authenticate_user!, only: [:index, :choice, :destroy]
  before_action :authenticate_teacher!, only: [:teacher_index, :teacher_new, :all_day_new, :create, :teacher_create, :teacher_destroy]
  
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
    @user = User.find(params[:id])
    @teacher = Teacher.find(params[:teacher_id])
    @reservation = Reservation.new
    @temp_reservation = TempReservation.find(params[:temp_reservation_id])
    @start_time = Time.zone.parse(params[:start_time])
    @end_time = Time.zone.parse(params[:end_time])
    @address_select = params[:address_select]
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
      @temp_reservation = TempReservation.find(@reservation.temp_reservation_id)
      @temp_reservation.destroy
      UserMailer.with(reservation: @reservation).reservation_email.deliver_later #メール痩身をするための処理
                                                                                 #UserMailerはメール送信用のメーラークラス
                                                                                 #reservation: @reservationはreservationというパラメータ名で@reservationインスタンス変数をメール送信メソッドに渡す。
                                                                                 #.reservation_emailはメール送信のメソッド。UserMailerクラス内で定義されたメソッド
                                                                                 #.deliver_laterはメールを非同期で送信するためのメソッド　
      redirect_to teacher_path(@reservation.teacher_id)
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
    message = Reservation.check_delete(@start_time)
    if !!message
      redirect_to user_path(current_user.id), flash: { alert: message } and return #and returnはリダイレクトと同時にメソッドの実行を終了
    end 
    if @reservation.destroy
      TeacherMailer.with(user: @user, teacher: @teacher, start_time: @start_time).reservation_delete_email.deliver_later #withメソッドでアクションメーラーのメソッドに必要な情報を渡す。
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
    params.require(:reservation).permit(:user_id, :teacher_id, :temp_reservation_id, :start_time, :end_time, :address_select)
  end 
  
  def reservation_teacher_params
    params.require(:reservation).permit(:teacher_id, :start_time, :end_time)
  end 
  
  
end
