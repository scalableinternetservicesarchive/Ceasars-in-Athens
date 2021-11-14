class User < ApplicationRecord
  has_secure_password
  has_many :services, dependent: :destroy
  has_many :appointments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates :username, presence: true, uniqueness: true
end
