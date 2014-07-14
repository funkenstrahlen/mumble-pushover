This is a chat bot for mumble servers. It will connect to a specific channel on a mumble server and wait for users to mention you in the chat. You will receive every message as a push message via [Pushover](https://pushover.net/). The user who mentioned you in the channel will get a short info message from the bot as a reply.

# How to use

Create `config.yml` by copying the `config_example.yml` and applying your settings. To use pushover you have to create a pushover account and a pushover application (to get the app token). Run `bundle install`. Call `ruby mumble-pushover.rb`. Quit by pressing ENTER.

Opus codec required (because mumble-ruby can also stream audio to the mumble server). For Ubuntu you have to install the following packages:

```
sudo apt-get install libopus-dev libopus0 opus-tools libcelt-dev libcelt0-0 libopus-dev celt
```