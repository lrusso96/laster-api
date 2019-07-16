require 'net/http'
require 'json'
class Laster
  def self.search_tracks(args)
    uri = URI('https://ws.audioscrobbler.com/2.0/?')
    params = { method: 'track.search', api_key: ENV['LASTFM_API_KEY'],
               format: 'json' }
    params.reverse_merge!(args)
    uri.query = URI.encode_www_form(params)
    # #FIXME: error handling is completely ignored

    # parse result and return List<Track>
    res = JSON.parse Net::HTTP.get_response(uri).body
    parse_search res
  end

  def self.top_tracks
    # TODO: implement method
    tracks = []
    1.upto 10 do |value|
      tracks << Track.new(title: "top - #{value}")
    end
    tracks
  end

  def self.latest_tracks
    # TODO: implement method
    tracks = []
    1.upto 10 do |value|
      tracks << Track.new(title: "latest - #{value}")
    end
    tracks
  end

  def self.similar_tracks(artist, track)
    # TODO: parse json
    uri = URI('https://ws.audioscrobbler.com/2.0/?')
    params = { method: 'track.getsimilar', artist: artist, track: track,
               api_key: ENV['LASTFM_API_KEY'], format: 'json' }
    uri.query = URI.encode_www_form(params)
    @res = Net::HTTP.get_response(uri)
    @res.body
  end

  private_class_method def self.parse_search(res)
    ret = []
    return ret if res['error'] # FIXME: return some error code / msg

    tracks = res['results']['trackmatches']['track']
    tracks.each do |t|
      # FIXME: add more fields!
      ret << Track.new(title: t['name'], artist: t['artist'])
    end
    ret
  end
end
