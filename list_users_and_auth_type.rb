require 'looker-sdk'

# get API creds from environment variables
LOOKER_ID = ENV['LOOKER_ID']
LOOKER_SECRET = ENV['LOOKER_SECRET']
LOOKER_PATH = 'https://COMPANY.looker.com:19999/api/3.0'

sdk = LookerSDK::Client.new(
  :client_id => LOOKER_ID,
  :client_secret => LOOKER_SECRET,
  :api_endpoint => LOOKER_PATH
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

