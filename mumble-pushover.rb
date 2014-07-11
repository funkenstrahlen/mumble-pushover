require 'mumble-ruby'
require 'pushover'
require 'yaml'

# read config file
puts 'reading configuration file...'
CONFIG = YAML.load_file("config.yml") unless defined? CONFIG

# configure pushover
Pushover.configure do |config|
	config.user = CONFIG['pushover_user_token']
	config.token = CONFIG['pushover_app_token']
end

# configure mumble
mumble = Mumble::Client.new(CONFIG['mumble_server'], CONFIG['mumble_server_port']) do |config|
	config.username = CONFIG['mumble_bot_name']
	config.password = CONFIG['mumble_password']
end

# connect to mumble
puts 'connecting...'
mumble.connect
sleep 2 # wait until connection is established
puts 'connected to server'
mumble.mute
mumble.deafen
mumble.join_channel(CONFIG['mumble_channel'])
puts 'joined channel ' + CONFIG['mumble_channel']

# setup callback on text message and send pushover message on mention
puts 'waiting for messages...'
mumble.on_text_message do |message|
	content = message.message
	# check if user was highlighted
	if content.include? CONFIG['mumble_username']
		# send pushover
		title = 'mumble#' + CONFIG['mumble_channel']
		puts 'hightlight detected: "' + content + '"'
		puts 'sending pushover...'
		Pushover.notification(message: content, title: title)
	end
end

# handle program exit
puts 'quit by pressing any key'
gets
puts "\nexiting..."
mumble.disconnect

