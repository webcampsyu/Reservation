class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  has_many :reservations, dependent: :destroy
  has_many :temp_reservations, dependent: :destroy
  
  validates :email, :user_name, :user_area, :curriculum, :curriculum_num, :video_available, :user_address, presence: true
  validates :email, uniqueness: true
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.user_name = "ゲストユーザー"
      user.curriculum = "ダイエット"
      user.user_address = "宮城県富谷市成田"
    end 
  end 
  
end
