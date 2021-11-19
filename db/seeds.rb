require 'csv'
require 'active_support/time'

def read_csv (filename)
  csv_text = File.read(Rails.root.join('tsung_tests', filename))
  csv = CSV.parse(csv_text, :headers => true)
end

conn = ActiveRecord::Base.connection()

# read_csv("users.csv").each do |row|
#   user = User.new
#   user.id = row['id'].to_i
#   user.username = row['username']
#   user.password = row['password']
#   if !user.save
#     puts user.errors.full_messages
#   end
# end

APPTS_NEXT_N_DAYS = 3
APPTS_START_HOUR = 7
APPTS_END_HOUR = 20
APPT_DURATION_MINS = 60

# read_csv("services.csv").each do |row|
#   service = Service.new
#   service.id = row['id'].to_i
#   service.title = row['title']
#   service.description = row['description']
#   service.user_id = row['user_id'].to_i
#   if !service.save
#     puts service.errors.full_messages
#   end
#   (1..APPTS_NEXT_N_DAYS).each do |day_offset|
#     date = Time.now + day_offset.days

#     start_time = date.change({hour: APPTS_START_HOUR, min: 0})
#     end_time = date.change({hour: APPTS_END_HOUR, min: 0})

#     curr_time = start_time
#     while curr_time <= end_time - APPT_DURATION_MINS.minutes
#       appt = Appointment.new(
#         date: curr_time,
#         start_time: curr_time,
#         end_time: curr_time + APPT_DURATION_MINS.minutes,
#         service_id: service.id
#       )
#       if !appt.save
#         puts appt.errors.full_messages
#       end
#       curr_time += APPT_DURATION_MINS.minutes
#     end 
#   end
# end

sql = <<-EOL
  SELECT setval(pg_get_serial_sequence('users', 'id'), max(id) + 1, false) FROM users;
  SELECT setval(pg_get_serial_sequence('services', 'id'), max(id) + 1, false) FROM services;
EOL

sql.split(';').each do |s|
  conn.execute(s.strip) unless s.strip.empty?
end