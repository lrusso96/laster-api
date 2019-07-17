require 'net/http'
require 'json'
require 'json'
module Laster
  class Artists
    def self.search(args)
      uri = URI('https://ws.audioscrobbler.com/2.0/?')
      params = { method: 'artist.search', api_key: ENV['LASTFM_API_KEY'],
                 format: 'json' }
      params.reverse_merge!(args)
      uri.query = URI.encode_www_form(params)
      # #FIXME: error handling is completely ignored

      # parse result and return List<Track>
    end

    def self.top_tracks
      # TODO: implement method
    end

    def self.similar
      # TODO: implement method
    end
  end
end
