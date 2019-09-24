require 'looker-sdk'

# get API creds from environment variables
sdk = LookerSDK::Client.new(
  :client_id => ENV['LOOKER_ID'],
  :client_secret => ENV['LOOKER_SECRET'],
  :api_endpoint => ENV['LOOKER_PATH']
)

response = sdk.all_users()

response.each { |user|
	user.each { | creds |
		unless creds[1].inspect.nil?
			if creds[0].inspect.include? "credentials_"
				if creds[1].class.to_s == 'Sawyer::Resource'
					puts "Auth type: #{creds[0]} for user #{creds[1][:email].inspect} with User ID: #{user[:id]}" unless creds[1][:email].nil?
				end
			end
		end
	}
}

puts "\nThere are #{response.length} users in the instance."
