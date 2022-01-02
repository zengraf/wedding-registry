class Order < ApplicationRecord
  belongs_to :added_by, class_name: 'User'
  belongs_to :hall

  scope :upcoming, -> { where('date >= ?', Date.today).order(:date) }
  scope :archived, -> { where('date < ?', Date.today).order(date: :desc) }

  validates :name, :surname, presence: true
  validates :phone_number, presence: true, telephone_number: { country: :pl }
  validates :deposit, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :confirmed, inclusion: { in: [true, false] }
  validates :date, presence: true
  validate :date_not_reserved

  private

  def date_not_reserved
    errors.add(:hall, :date_is_reserved) and return if hall.reservation_dates.include? date

    true
  end
end
