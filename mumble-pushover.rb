require 'mumble-ruby'
require 'pushover'
require 'yaml'

# read config file
CONFIG = Yaml.load_file("config.yml") unless defined? CONFIG

# configure pushover
Pushover.configure do |config|
	config.user = CONFIG['pushover_user_token']
	config.token = CONFIG['pushover_app_token']
end

# configure mumble
mumble = Mumble::Client.new('serverdomain') do |config|
	config.username = CONFIG['mumble_bot_name']
	config.password = CONFIG['mumble_password']
end

# connect to mumble
mumble.connect
mumble.mute
mumble.deafen
mumble.join_channel(CONFIG['mumble_channel'])

begin
	# setup callback on text message and send pushover message on mention
	mumble.on_text_message do |message|
		# check if user was highlighted
		if message.include? CONFIG['mumble_username']
			puts message
			puts 'sending pushover...'
			Pushover.notification(message: message, title: 'title')
		end
	end
rescue Interrupt
	# program quits with CTRL-C
	mumble.disconnect
	puts "\nexiting..."
rescue Exception => e
	puts e
end

