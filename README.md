# How to use tldr

Create `config.yml` by copying the `config_example.yml` and applying your settings. To use pushover you have to create a pushover account and a pushover application (to get the app token). Run `bundle install`. Call `ruby mumble-pushover.rb`. Exit by pressing any key.

Opus codec required (because mumble-ruby can also stream audio to the mumble server). For Ubuntu you have to install the following packages:

```
sudo apt-get install libopus-dev libopus0 opus-tools libcelt-dev libcelt0-0 libopus-dev celt
```