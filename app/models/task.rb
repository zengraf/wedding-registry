class Task < ApplicationRecord
  belongs_to :order

  default_scope -> { order(start_time: :asc, end_time: :desc) }

  validates :name, :order, :start_time, :price, presence: true
  validate :time_range_is_correct

  private

  def time_range_is_correct
    errors.add(:end_time, :time_should_be_after) and return false if end_time&.before? start_time

    true
  end
end
