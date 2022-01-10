class Task < ApplicationRecord
  belongs_to :order

  default_scope -> { order(start_time: :asc, end_time: :desc) }
  scope :on, ->(date) do
    where('end_time >= ? AND start_time <= ?', date.beginning_of_day, date.end_of_day).
      or(where(end_time: nil, start_time: date.beginning_of_day..date.end_of_day))
  end

  validates :name, :order, :start_time, :price, presence: true
  validate :time_range_is_correct

  private

  def time_range_is_correct
    errors.add(:end_time, :time_should_be_after, time: end_time) and return false if end_time&.before? start_time

    true
  end
end
