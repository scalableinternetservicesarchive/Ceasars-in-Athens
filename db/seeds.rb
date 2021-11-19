require 'csv'

csv_text = File.read(Rails.root.join('tsung_tests', 'users.csv'))
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  user = User.new
  user.id = row['id'].to_i
  user.username = row['username']
  user.password = row['password']
  user.save
end
