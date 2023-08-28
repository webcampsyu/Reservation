class Reservation < ApplicationRecord
  
  belongs_to :teacher
  belongs_to :user, optional: true
  belongs_to :temp_reservation, optional: true
  
  def self.reservations_after_three_month
    # 今日から3ヶ月先までのデータを取得
    reservations = Reservation.all.where("start_time >= ?", Date.current).where("start_time < ?", Date.current >> 3).order(start_time: :desc)
    # 配列を作成し、データを格納
    # DBアクセスを減らすために必要なデータを配列にデータを入れる
    reservation_data = []
    reservations.each do |reservation|
      reservations_hash = {}
      reservations_hash.merge!(start_time: reservation.start_time, end_time: reservation.end_time)
    end
    reservation_data
  end
  
  def self.check_reservation_day(start_time)
    if start_time < Date.current
      return "過去の日付は選択できません。正しい日付を選択してください。"
    elsif start_time < (Date.current + 1)
      return "当日は選択できません。正しい日付を選択してください。"
    elsif (Date.current >> 3) < start_time
      return "3ヶ月以降の日付は選択できません。正しい日付を選択してください。"
    end
  end
  
  def self.check_delete(start_time)
    day_before = (start_time - 1.days).to_date
    deadline = Time.zone.parse('day_before.strftime("%Y-%m-%d") 18:00:00')
    if deadline <= Time.zone.now
      return "受講前日の18時以降の予約取り消しはキャンセル料が発生致します。恐れ入りますが、事務局までキャンセルのご連絡をお願い致します。"
    end 
  end 
  
  
end
