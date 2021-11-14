class Review < ApplicationRecord
  belongs_to :service
  belongs_to :user
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5, only_integer: true }
end