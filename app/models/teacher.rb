class Teacher < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  mount_uploader :teacher_img, ProfileUploader #carrierwaveを使用して、アプリケーション内で画像をアップロードするための設定
  has_many :reservations, dependent: :destroy
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
