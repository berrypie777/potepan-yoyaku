class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :checkin_date, :checkout_date, :guest, presence: true
  validate :start_end_check

  def start_end_check
    if checkin_date == nil
      errors.add(:checkin_date, "開始日を入力してください")
    elsif checkout_date == nil
      errors.add(:checkout_date, "終了日を入力してください")
    elsif checkout_date < checkin_date
      errors.add(:checkout_date, "終了日は開始日よりも後の日付にしてください")
    end
  end
  def total_date
    duration = (checkout_date - checkin_date).to_i
  end
  def total_price
    total_date * guest * room.price
  end
end
