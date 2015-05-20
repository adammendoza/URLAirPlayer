#!/usr/bin/env ruby
require 'rubygems'
require 'airplay'

require './lib/youtube_video'

if Airplay.devices.empty?
  puts 'ERROR: No AppleTV devices found'
  exit 1
end

apple_tv = Airplay.devices.first
puts "Using first AppleTV device found, named: #{apple_tv.name}"

url = 'https://www.youtube.com/watch?v=XUbGiKCDwvg'

video_url = if url.match /youtube\.com/
  puts 'This is a YouTube video'
  YoutubeVideo.new(url).airplay_link
else
  nil
end

if video_url.empty?
  puts 'ERROR: No complatible video stream URL found'
  exit 1
end

puts "Using video stream URL: #{video_url}"

puts 'Playing video on AppleTV...'
player = apple_tv.play(video_url)

player.progress -> progress {
  puts "Playing #{progress.percent}% ..." unless progress.position.nil?
}

player.wait
player.cleanup

puts 'Video played'
exit 0
