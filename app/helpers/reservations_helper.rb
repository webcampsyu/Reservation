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
    start_time = Time.zone.parse(day.to_s + " " + "9:00" + " " + "JST")
  end

  def all_day_end_time(day)
    end_time = Time.zone.parse(day.to_s + " " + "20:30" + " " + "JST")
  end

  def check_reservation(reservations, day, time)
    result = false
    reservations_count = reservations.count
    select_time = Time.zone.parse(day.to_s + " " + time + " " + "JST")
    later_time = select_time + 89.minutes
    if reservations_count > 1
      reservations.each do |reservation|
        result = reservation[:start_time] <= select_time && select_time < reservation[:end_time]
        return result if result
      end
    elsif reservations_count == 1
      result = reservations[0][:start_time] <= select_time && select_time < reservations[0][:end_time]
      return result if result
    end

    if reservations_count > 1
      reservations.each do |reservation|
        result = reservation[:start_time] <= later_time && later_time < reservation[:end_time]
        return result if result
      end
    elsif reservations_count == 1
      result = reservations[0][:start_time] <= later_time && later_time < reservations[0][:end_time]
      return result if result
    end

    return result
  end

  def check_teacher_reservation(reservations, day, time)
    result = false
    reservations_count = reservations.count
    select_time = Time.zone.parse(day.to_s + " " + time + " " + "JST")
    if reservations_count > 1
      reservations.each do |reservation|
        result = reservation[:start_time] <= select_time && select_time < reservation[:end_time]
        return result if result
      end
    elsif reservations_count == 1
      result = reservations[0][:start_time] <= select_time && select_time < reservations[0][:end_time]
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
