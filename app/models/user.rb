class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  has_many :reservations, dependent: :destroy
  has_many :temp_reservations, dependent: :destroy
  
  validates :email, :user_name, :user_area, :curriculum, :curriculum_num, :video_availabel, :user_address, presence: true
  validates :email, uniqueness: true
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
