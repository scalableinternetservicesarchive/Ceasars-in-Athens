require 'csv'
require 'active_support/time'

def read_csv (filename)
  csv_text = File.read(Rails.root.join('tsung_tests', filename))
  csv = CSV.parse(csv_text, :headers => true)
end

conn = ActiveRecord::Base.connection()

NUM_USERS = 10
NUM_SERVICES = 10

APPTS_NEXT_N_DAYS = 3
APPTS_START_HOUR = 7
APPTS_END_HOUR = 20
APPT_DURATION_MINS = 60

(1..NUM_USERS).each do |i|
  user = User.new
  user.username = "test_user_#{i}"
  user.password = "password"
  if !user.save
    puts user.errors.full_messages
  end
end

services = []
appointments = []

(1..NUM_SERVICES).each do |i|
  id = (i % NUM_USERS) + 1
  service = [
    "My Test Service #{i}",
    "This is a sample test service #{i}",
    id,
    "test_user_#{id}"
  ]
  services << service
  (1..APPTS_NEXT_N_DAYS).each do |day_offset|
    date = Time.now + day_offset.days

    start_time = date.change({hour: APPTS_START_HOUR, min: 0})
    end_time = date.change({hour: APPTS_END_HOUR, min: 0})

    curr_time = start_time
    while curr_time <= end_time - APPT_DURATION_MINS.minutes
      appt = [
        date,
        curr_time,
        curr_time + APPT_DURATION_MINS.minutes,
        i,
        "My Test Service #{i}",
        id,
        "test_user_#{id}"
      ]
      appointments << appt
      curr_time += APPT_DURATION_MINS.minutes
    end
  end
end

saved_svcs = 0
saved_appts = 0

services.in_groups_of(1000, fill_with = false) do |group|
  vals = group.map { |svc| 
    now = Time.now
    title = svc[0]
    description = svc[1]
    user_id = svc[2]
    username = svc[3]
    "('#{title}', '#{description}', '#{user_id}', '#{username}', '#{now}', '#{now}')"
  }.join(", ")
  saved_svcs += group.length()
  puts "Saved #{saved_svcs}/#{services.length} services"
  sql = "INSERT INTO services (title, description, user_id, user_name, created_at, updated_at) VALUES #{vals}"
  conn.execute(sql)
end

appointments.in_groups_of(10000, fill_with = false) do |group|
  vals = group.map { |appt| 
    now = Time.now
    date = appt[0]
    start_time = appt[1]
    end_time = appt[2]
    service_id = appt[3]
    service_title = appt[4]
    provider_id = appt[5]
    provider_name = appt[6]
    "('#{date}', '#{start_time}', '#{end_time}', '#{service_id}', '#{service_title}', '#{provider_id}', '#{provider_name}', '#{now}', '#{now}')"
  }.join(", ")
  saved_appts += group.length()
  puts "Saved #{saved_appts}/#{appointments.length} appointments"
  sql = "INSERT INTO appointments (date, start_time, end_time, service_id, service_title, provider_id, provider_name, created_at, updated_at) VALUES #{vals}"
  conn.execute(sql)
end
