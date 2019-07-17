require 'net/http'
require 'json'
require 'json'
module Laster
  class Tracks
    def self.search(track, artist: nil, limit: nil)
      params = { method: 'track.search', api_key: ENV['LASTFM_API_KEY'],
                 format: 'json' }
      # I don't trust the caller
      args = { track: track, artist: artist, limit: limit }.compact
      params.reverse_merge!(args)

      uri = URI API_ENDPOINT
      uri.query = URI.encode_www_form params
      # #FIXME: error handling is completely ignored
      # parse result and return List<Track>
      parse_search JSON.parse Net::HTTP.get_response(uri).body
    end

    def self.top
      # TODO: implement method
      tracks = []
      1.upto 10 do |value|
        tracks << Track.new(title: "top - #{value}")
      end
      tracks
    end

    def self.latest
      # TODO: implement method
      tracks = []
      1.upto 10 do |value|
        tracks << Track.new(title: "latest - #{value}")
      end
      tracks
    end

    def self.similar(track, artist)
      params = { method: 'track.getsimilar', artist: artist, track: track,
                 api_key: ENV['LASTFM_API_KEY'], format: 'json' }
      uri = URI API_ENDPOINT
      uri.query = URI.encode_www_form params
      parse_similar JSON.parse Net::HTTP.get_response(uri).body
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

    private_class_method def self.parse_similar(res)
      ret = []
      return ret if res['error'] # FIXME: return some error code / msg

      tracks = res['similartracks']['track']
      tracks.each do |t|
        # FIXME: add more fields!
        ret << Track.new(title: t['name'], artist: t['artist']['name'])
      end
      ret
    end
  end
end
