class User < ApplicationRecord
  has_many :orders, foreign_key: 'added_by_id'
  has_secure_password

  validates :name, :surname, presence: true
  validates :email, presence: true, uniqueness: true, 'valid_email_2/email': { disposable: true }
  validates :password, presence: true, confirmation: true, length: { in: 8..20 }
  validates :phone_number, presence: true, telephone_number: { country: :pl }
  validates :role, presence: true

  before_save :downcase_email
  
  enum role: [ :worker, :admin ]

  def downcase_email
    self.email.downcase!
  end
end
