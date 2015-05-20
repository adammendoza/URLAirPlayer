
Shoes.setup do
  gem 'airplay', '1.0.3'
end

require 'airplay'
require './lib/youtube_video'
require './lib/url_player'

Shoes.app(title: 'URL Air Player', width: 800, resizable: false) do

  @apple_tv = Airplay.devices.first

  stack(margin: 10) do
    para("Using first AppleTV device found, named: #{@apple_tv.name}")
    para("Video URL:")
    flow do
      @input = edit_line(width: 400, text: 'https://www.youtube.com/watch?v=XUbGiKCDwvg')
      @button = button("Play on AppleTV")
    end
    @output = para("")
  end

  @url_player = UrlPlayer.new(@apple_tv, @output)

  @button.click do |b|
    b.hide
    Thread.new do
      @url_player.play(@input.text)
      b.show
    end
  end

end
