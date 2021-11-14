# Model representing the payload exchanged when generating appointments
class AppointmentBuilder
  include ActiveModel::Model
  attr_accessor :date, :start_time, :end_time, :duration

  validates :date, :start_time, :end_time, :duration, presence: true
  validates :duration, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validate :end_time_cannot_be_before_start_time

  def end_time_cannot_be_before_start_time
    if start_time >= end_time
      errors.add :end_time, "must be after start time"
    end
  end
end