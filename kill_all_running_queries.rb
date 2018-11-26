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

all_running_queries = looker.all_running_queries()
all_running_queries.each { |item|
	puts "Killing query: #{item[:query_task_id]} from #{item[:source].to_s.capitalize}"
	looker.kill_query(item[:query_task_id])
	}

