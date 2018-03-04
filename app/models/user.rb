class User < ActiveRecord::Base
  validates :password, confirmation: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :password, presence: true
  validates :email, uniqueness: true

  has_secure_password

end
