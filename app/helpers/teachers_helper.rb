module TeachersHelper
  
  #引数として与えられた予約オブジェクトから関連するユーザーを検索し、ユーザー名を返す処理
  def check_user(reservation)
    user = User.find(reservation.user_id)
    return user.user_name
  end 
  
end
