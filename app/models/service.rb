class Service < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :appointments, dependent: :destroy
  belongs_to :user
end
