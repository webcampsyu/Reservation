module UsersHelper
  
  def check_teacher(reservation)
    teacher = Teacher.find(reservation.teacher_id)
    return teacher.teacher_name
  end 
  
  def teacher_address(reservation)
    teacher = Teacher.find(reservation.teacher_id)
    return teacher.teacher_address
  end 
  
  
end
