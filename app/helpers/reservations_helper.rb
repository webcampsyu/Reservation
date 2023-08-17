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
    # 取得した予約データにdayとtimeが一致する場合はtrue,一致しない場合はfalseを返します
    if reservations_count > 1
      reservations.each do |reservation|
        result = reservation[:day].eql?(day.strftime("%Y-%m-%d")) && reservation[:time].eql?(time) #予約の日付と時間が引数と渡された日付と時間が一致するか確認し、代入
        return result if result
      end
    elsif reservations_count == 1
      result = reservations[0][:day].eql?(day.strftime("%Y-%m-%d")) && reservations[0][:time].eql?(time)
      return result if result
    end
    return result
  end
  
end
