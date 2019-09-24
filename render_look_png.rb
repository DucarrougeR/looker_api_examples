require 'looker-sdk'

# get API creds from environment variables
sdk = LookerSDK::Client.new(
  :client_id => ENV['LOOKER_ID'],
  :client_secret => ENV['LOOKER_SECRET'],
  :api_endpoint => ENV['LOOKER_PATH']
)

look_to_render = 44

png = sdk.create_look_render_task(look_to_render, "png", {}, {:query => {:width => 1000, :height => 600}})

id = png[:id]

until sdk.render_task(id)[:status] == 'success' do
end

results = sdk.render_task_results(id)

File.open('look.png', 'w') { |file| file.write(results) }
