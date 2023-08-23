class TeachersController < ApplicationController
  before_action :authenticate_teacher!
  
  def show
    @teacher = current_teacher
    #予約データの取得
    @teacher_reservations = @teacher.reservations.where("user_id IS NOT NULL").where("start_time" >= ?", DateTime.current).order(:start_time) # where("user_id IS NOT NULL")はuser_idカラムがNULLではないもの（つまりユーザーが予約した）データを選択
  end
end
