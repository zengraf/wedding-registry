class Hall < ApplicationRecord
  has_many :orders

  def reservation_dates
    orders.upcoming.pluck(:date)
  end
end
