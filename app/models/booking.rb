class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :checkin_date, presence: { message: "チェックイン日を入力してください" }
  validates :checkout_date, presence: { message: "チェックアウト日を入力してください" }
  validates :guest, presence: { message: "人数を入力してください" }
  validate :start_end_check

  def start_end_check
    if checkin_date == nil
      errors.add(:base, "チェックイン日を入力してください")
    elsif checkout_date == nil
      errors.add(:base, "チェックアウト日を入力してください")
    elsif checkout_date < checkin_date
      errors.add(:base, "チェックアウト日はチェックイン日よりも後の日付にしてください")
    end
  end
  def total_date
    duration = (checkout_date - checkin_date).to_i
  end
  def total_price
    total_date * guest * room.price
  end
end
