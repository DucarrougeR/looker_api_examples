require 'looker-sdk'

# get API creds from environment variables
looker = LookerSDK::Client.new(
  :client_id => ENV['LOOKER_ID'],
  :client_secret => ENV['LOOKER_SECRET'],
  :api_endpoint => ENV['LOOKER_PATH']
)

# list the users to disable in the instance
users_to_disable = [264, 214, 260] 
body = {"is_disabled": true}


users_to_disable.each { |item|
    looker.update_user(item, body)
    puts "User '#{looker.user(item)[:first_name]} #{looker.user(item)[:last_name]}' was disabled (id: #{item})"
}
