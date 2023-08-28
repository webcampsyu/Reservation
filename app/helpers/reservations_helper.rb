module ReservationsHelper
  
  def times
    times = ["9:00",
             "9:30",
             "10:00",
             "10:30",
             "11:00",
             "11:30",
             "12:00",
             "12:30",
             "13:00",
             "13:30",
             "14:00",
             "14:30",
             "15:00",
             "15:30",
             "16:00",
             "16:30",
             "17:00",
             "17:30",
             "18:00",
             "18:30",
             "19:00",
             "19:30",
             "20:00"
            ]
  end
  
  def all_day_start_time(day)
    start_time = Time.zone.parse(day.to_s + "" + "9:00" + "" + "JST")
  end 
  
  def all_day_end_time(day)
    end_time = Time.zone.parse(day.to_s + "" + "20:30" + "" + "JST")
  end 
  
  def check_reservation(reservations, day, time) #指定された日付と時間に対する予約の存在を確認
    result = false
    reservations_count = reservations.count #渡された予約データの要素数を代入
    if reservations_count > 1
      reservations.each do |reservation|
        result = reservation[:start_time] <= Time.zone.parse(day.to_s + " " + time + " " + "JST") && Time.zone.parse(day.to_s + " " + time + " " + "JST") < reservation[:end_time] #時間の範囲をチェックする。論理演算子<=や&&を使用して、予約開始時刻よりも大きくかつ予約の終了時刻よりも小さい場合resultにtrueが代入される。それ以外はfalseが代入される
        return result if result
      end
    elsif reservations_count == 1
      result = reservations[0][:start_time] <= Time.zone.parse(day.to_s + " " + time + " " + "JST") && Time.zone.parse(day.to_s + " " + time + " " + "JST") < reservations[0][:end_time]
      return result if result
    end
    return result
  end
  
  def address(address_select)
    if address_select
      @teacher.teacher_address
    else 
      @user.user_address
    end 
  end 
  
  
end
