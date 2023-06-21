class User < ApplicationRecord
  has_many :rooms
  has_many :bookings
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable
  mount_uploader :image, ImageUploader
  validates :name, presence: true
  validates :introduction, length: { maximum: 300 }
end
