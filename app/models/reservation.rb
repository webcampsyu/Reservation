class Reservation < ApplicationRecord
  
  def self.reservations_after_three_month
    # 今日から3ヶ月先までのデータを取得
    reservations = Reservation.all.where("day >= ?", Date.current).where("day < ?", Date.current >> 3).order(day: :desc)
    # 配列を作成し、データを格納
    # DBアクセスを減らすために必要なデータを配列にデータを入れる
    reservation_data = []
    reservations.each do |reservation|
      reservations_hash = {}
      reservations_hash.merge!(day: reservation.day.strftime("%Y-%m-%d"), time: reservation.time, start_time: reservation.start_time, end_time: reservation.end_time)
    end
    reservation_data
  end
  
end
