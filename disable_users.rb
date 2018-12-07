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

# list the users to disable in the instance
users_to_disable = [264, 214, 260] 
body = {"is_disabled": true}


users_to_disable.each { |item|
    looker.update_user(item, body)
    puts "User '#{looker.user(item)[:first_name]} #{looker.user(item)[:last_name]}' was disabled (id: #{item})"
}
