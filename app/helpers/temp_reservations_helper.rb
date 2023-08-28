module TempReservationsHelper
  
  def address_each(temp_reservation)
    @user = User.find(temp_reservation.user_id)
    @teacher = Teacher.find(temp_reservation.teacher_id)
    if temp_reservation.address_select
      @teacher.teacher_address
    else 
      @user.user_address
    end 
  end 
  
end
