module ReservationsHelper
  
  def times
    times = ["9:00",
             "9:30",
             "10:00",
             "10:30",
             "11:00",
             "11:30",
             "13:00",
             "13:30",
             "14:00",
             "15:00",
             "15:30",
             "16:00",
             "16:30",
             "17:00",
             "17:30",
             "18:00",
             "19:00",
             "19:30",
             "20:00"
            ]
  end
  
  def check_reservation(reservations, day, time) #指定された日付と時間に対する予約の存在を確認
    result = false
    reservations_count = reservations.count #渡された予約データの要素数を代入
    if reservations_count > 1
      reservations.each do |reservation|
        result = reservation[:start_time] <= Time.zone.parse(day + " " + time + " " + "JST") && Time.zone.parse(day + " " + time + " " + "JST") <= reservation[:end_time] #時間の範囲をチェックする。論理演算子<=や&&を使用して、予約開始時刻よりも大きくかつ予約の終了時刻よりも小さい場合resultにtrueが代入される。それ以外はfalseが代入される
        return result if result
      end
    elsif reservations_count == 1
      result = reservations[0][:day].eql?(day.strftime("%Y-%m-%d")) && reservations[0][:time].eql?(time)
      return result if result
    end
    return result
  end
  
end
