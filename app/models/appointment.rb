class Appointment < ApplicationRecord
  belongs_to :service
  belongs_to :user, optional: true
end
