require 'looker-sdk'

# get API creds from environment variables
sdk = LookerSDK::Client.new(
  :client_id => ENV['LOOKER_ID'],
  :client_secret => ENV['LOOKER_SECRET'],
  :api_endpoint => ENV['LOOKER_PATH']
)

all_users = sdk.all_users()
count_users = 0
all_users.each { |item|
	if not item[:sessions][0].nil?
		sdk.delete_user_session(item[:id], item[:sessions][0][:id])
		puts "Logged out user: #{item[:first_name].to_s.capitalize} #{item[:last_name].to_s.capitalize}"
		count_users += 1
	end
}
puts "\nScript logged out #{count_users} users"
