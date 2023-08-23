class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = current_user
    #特定のユーザーに関する予約データを取得
    @user_reservations = @user.reservations.where("start_time >= ?", DateTime.current).order(:start_time) 
  end 
  
end
