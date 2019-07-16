require 'net/http'
class Laster
  def self.search_tracks(title)
    track1 = Track.new(title: title)
    track2 = Track.new(title: "#{title} - 2")
    [track1, track2]
  end

  def self.top_tracks
    tracks = []
    1.upto 10 do |value|
      tracks << Track.new(title: "top - #{value}")
    end
    tracks
  end

  def self.latest_tracks
    tracks = []
    1.upto 10 do |value|
      tracks << Track.new(title: "latest - #{value}")
    end
    tracks
  end

  def self.similar_tracks(artist, track)
    uri = URI('https://ws.audioscrobbler.com/2.0/?')
    params = {:method => 'track.getsimilar', :artist => artist,
              :track => track, :api_key => ENV['LASTFM_API_KEY'],
              :format => 'json'}
    uri.query = URI.encode_www_form(params)
    @res = Net::HTTP.get_response(uri)
    @res.body
  end
end
