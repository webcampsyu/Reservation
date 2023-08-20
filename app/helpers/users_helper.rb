module UsersHelper
  
  def check_teacher(reservation)
    teacher = Teacher.find(reservation.teacher_id)
    return teacher.teacher_name
  end 
  
end
