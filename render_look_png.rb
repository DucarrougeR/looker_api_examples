require 'looker-sdk'

# get API creds from environment variables
LOOKER_ID = ENV['LOOKER_ID']
LOOKER_SECRET = ENV['LOOKER_SECRET']
LOOKER_PATH = 'https://COMPANY.looker.com:19999/api/3.0'

looker = LookerSDK::Client.new(
  :client_id => LOOKER_ID,
  :client_secret => LOOKER_SECRET,
  :api_endpoint => LOOKER_PATH
)

look_to_render = 44

png = looker.create_look_render_task(look_to_render, "png", {}, {:query => {:width => 1000, :height => 600}})

id = png[:id]

until looker.render_task(id)[:status] == 'success' do
end

results = looker.render_task_results(id)

File.open('look.png', 'w') { |file| file.write(results) }
