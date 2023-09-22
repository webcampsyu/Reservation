class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  has_many :reservations, dependent: :destroy
  has_many :temp_reservations, dependent: :destroy
  
  validates :email, :user_name, :curriculum, :user_address, presence: true
  validates :email, uniqueness: true
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  def self.guest
    find_or_create_by!(email: 'guest@example.com', user_name: 'ゲスト', user_address: '東京', curriculum: 'ボディメイク') do |user|
      user.password = SecureRandom.urlsafe_base64
    end 
  end 
  
end
