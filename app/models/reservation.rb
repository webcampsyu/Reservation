class Reservation < ApplicationRecord
  
  belongs_to :teacher
  belongs_to :user, optional: true
  validates :user, presence: true, if: :user_id?
  
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
  
end
