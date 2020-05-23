class Order < ApplicationRecord
  belongs_to :added_by, class_name: 'User'

  validates :name, :surname, presence: true
  validates :phone_number, presence: true, telephone_number: { country: :pl }
  validates :deposit, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :hall, presence: true
  validates :confirmed, inclusion: { in: [true, false] }

  enum hall: [ :small, :big ]
end
