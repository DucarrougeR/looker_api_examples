require 'looker-sdk'

# get API creds from environment variables
LOOKER_ID = ENV['LOOKER_ID']
LOOKER_SECRET = ENV['LOOKER_SECRET']
LOOKER_PATH = 'https://COMPANY.looker.com:19999/api/3.1'

looker = LookerSDK::Client.new(
  :client_id => LOOKER_ID,
  :client_secret => LOOKER_SECRET,
  :api_endpoint => LOOKER_PATH
)

all_users = looker.all_users()
count_users = 0
all_users.each { |item|
	if not item[:sessions][0].nil? 
		looker.delete_user_session(item[:id], item[:sessions][0][:id])
		puts "Logged out user: #{item[:first_name].to_s.capitalize} #{item[:last_name].to_s.capitalize}"
		count_users += 1
	end		
}
puts "\nScript logged out #{count_users} users"
