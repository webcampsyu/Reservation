class Teacher < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  mount_uploader :teacher_img, ProfileUploader #carrierwaveを使用して、アプリケーション内で画像をアップロードするための設定
  has_many :reservations, dependent: :destroy
  has_many :temp_reservations, dependent: :destroy
  
  validates :email, :teacher_name, :teacher_area, :teacher_img, :teacher_address, presence: true
  validates :email, uniqueness: true
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
