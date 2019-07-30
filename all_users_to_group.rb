require 'looker-sdk'

# get API creds from environment variables
sdk = LookerSDK::Client.new(
  :client_id => ENV['LOOKER_ID'],
  :client_secret => ENV['LOOKER_SECRET'],
  :api_endpoint => ENV['LOOKER_PATH']
)

all_groups = looker.all_groups(:fields => 'id, name')
all_groups.each { |item|
  #change this value below to match exactly the group name you want
	if item[:name] == "Custom Fields Beta Users"
		puts "Group \"#{item[:name]}\" has ID #{item[:id]}"
		$group_id = item[:id]
	end
}

all_users = looker.all_users(:fields => 'id, email')
all_users.each { |item|
	body = {"user_id": item[:id]}
	looker.add_group_user(5, body)
	# puts "User: #{item[:email].to_s.capitalize} with ID #{item[:id]} was added to the Group"
}
