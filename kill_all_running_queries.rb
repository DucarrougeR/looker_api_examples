require 'looker-sdk'

# get API creds from environment variables
sdk = LookerSDK::Client.new(
  :client_id => ENV['LOOKER_ID'],
  :client_secret => ENV['LOOKER_SECRET'],
  :api_endpoint => ENV['LOOKER_PATH']
)

all_running_queries = sdk.all_running_queries()
all_running_queries.each { |item|
	puts "Killing query: #{item[:query_task_id]} from #{item[:source].to_s.capitalize}"
	sdk.kill_query(item[:query_task_id])
	}
