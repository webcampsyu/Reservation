class TempReservation < ApplicationRecord
  
  belongs_to :user, optional: true #optional: trueはbelongs_toの外部キーのnilを許可する
  belongs_to :teacher
  
  def self.check_reservation_day(start_time)
    if self_time < Date.current #Date.currentはapplication.rbのタイムゾーンを使って、現在の日付を取得する
      return "過去の日付を選択できません。正しい日付を選択してください。"
    elsif start_time < (Date.curretn + 1)
      return "当日は選択できません。正しい日付を選択してください。"
    elsif (Date.current >> 3) < start_time
      return "３ヶ月以降の日付は選択できません。正しい日付を選択してください。"
    end 
  end 
  
end
