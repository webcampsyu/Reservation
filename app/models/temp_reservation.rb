class TempReservation < ApplicationRecord
  
  belongs_to :user, optional: true #optional: trueはbelongs_toの外部キーのnilを許可する
  belongs_to :teacher
  has_one :reservation
  
  def self.check_reservation_day(user_id, start_time)
    same_user_temp_reservation = TempReservation.where(user_id: user_id)
    same_user_reservation = Reservation.where(user_id: user_id)
    temp_start = same_user_temp_reservation.map(&:start_time) # .mapメソッドはコレクション内の各要素に対して指定したブロック（またはメソッド）を適用し、新しい配列を生成する
                                                              # start_time属性を抽出して、新しい配列temp_startに格納
    start = same_user_reservation.map(&:start_time)
    
    temp_start.each do |i|
      if start_time < (i + 8.days)
        return "仮予約との間隔が１週間以内のため予約できません"
      end 
    end 
    
    start.each do |i|
      if start_time < (i + 8.days)
        return "予約との間隔が１週間以内のため予約できません"
      end 
    end 
    
    
    if self_time < Date.current #Date.currentはapplication.rbのタイムゾーンを使って、現在の日付を取得する
      return "過去の日付を選択できません。正しい日付を選択してください。"
    elsif start_time < (Date.curretn + 1)
      return "当日は選択できません。正しい日付を選択してください。"
    elsif (Date.current >> 3) < start_time
      return "３ヶ月以降の日付は選択できません。正しい日付を選択してください。"
    end 
  end 
  
end
