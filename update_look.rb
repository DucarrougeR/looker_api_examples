require 'looker-sdk'

LOOKER_ID = ENV['LOOKER_ID'],
LOOKER_SECRET = ENV['LOOKER_SECRET']
LOOKER_PATH = 'https://COMPANY.looker.com:19999/api/3.0'

looker = LookerSDK::Client.new(
  :client_id => LOOKER_ID,
  :client_secret => LOOKER_SECRET,
  :api_endpoint => LOOKER_PATH
)

# get look, here look id 32
my_look = looker.look(32)

# get query id for look
my_query = looker.query(my_look.query_id).to_attrs

# set new filters, here update the value for order_id
my_query[:filters] =  {:"order_items.order_id" => "<567"}

# remove the client id!
my_query[:client_id] = {}

# create a new query
my_new_query = looker.create_query(my_query)
puts "New Query ID: " + my_new_query[:id].to_s

# update look with new query
my_look = looker.update_look(32, :query_id => my_new_query[:id])
puts "Updated Look Query ID: " + my_look[:query_id].to_s


if my_new_query[:id] == my_look[:query_id]
  puts "Success!"
else
  puts "Fail again, fail better"
end
