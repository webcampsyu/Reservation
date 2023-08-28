module TeachersHelper
  
  #引数として与えられた予約オブジェクトから関連するユーザーを検索し、ユーザー名を返す処理
  def check_user(reservation)
    user = User.find(reservation.user_id)
    return user.user_name
  end 
  
  #特定の予約オブジェクトを引数として渡し、その予約に対応するUserの住所情報を返す処理
  def user_address(reservation)
    user = User.find(reservation.user_id)
    return user.user_address
  end 
  
end
