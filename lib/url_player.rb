class UrlPlayer
  attr_reader :device, :output

  def initialize(device, output)
    @device = device
    @output = output
  end

  def play(url)
    video_url = YoutubeVideo.new(url).airplay_link
    output.replace("Using video stream URL: #{video_url} ...")

    output.replace('Playing video on AppleTV...')
    player = device.play(video_url)

    player.progress -> progress {
      output.replace("Playing #{progress.percent}% ...") unless progress.position.nil?
    }

    player.wait
    player.cleanup

    output.replace('Video played')

  end
end
