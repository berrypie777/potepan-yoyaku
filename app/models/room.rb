class Room < ApplicationRecord
  belongs_to :user
  has_many :bookings
  AREA_OPTIONS = %w[東京 大阪 京都 札幌]
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :address, presence: true, inclusion: { in: AREA_OPTIONS }
  mount_uploader :roomimage, RoomimageUploader
  scope :search, ->(query) { ransack(name_or_description_cont: query).result }
  def self.ransackable_attributes(auth_object = nil)
    %w[name address description price]
  end
  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end
end
