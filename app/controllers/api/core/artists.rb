# frozen_string_literal: true

require 'httparty'
require 'json'
module Laster
  # Interacts with Last.fm Artist module
  class Artists
    def self.search(artist, limit: nil)
      params = { method: 'artist.search', api_key: ENV['LASTFM_API_KEY'],
                 format: 'json' }
      # I don't trust the caller
      args = { artist: artist, limit: limit }.compact
      params.reverse_merge!(args)

      opt = { query: params, headers: { 'User-Agent' => ENV['USER_AGENT'] } }
      parse_search JSON.parse HTTParty.get(API_ENDPOINT, opt).body
    end

    def self.top_tracks
      # TODO: implement method
      tracks = []
      1.upto 10 do |value|
        artist = Artist.new(name: "art - #{value}")
        tracks << Track.new(title: "top - #{value}", artist: artist)
      end
      tracks
    end

    def self.similar(artist)
      # TODO: implement method
      artists = []
      1.upto 10 do |value|
        artists << Artist.new(name: "recent artist - #{value}")
      end
      artists
    end

    private_class_method def self.parse_search(res)
      catch_error res
      ret = []
      artists = res['results']['artistmatches']['artist']
      artists.each do |a|
        # FIXME: add more fields!
        ret << Artist.new(name: a['name'])
      end
      ret
    end

    private_class_method def self.catch_error(res)
      raise Laster::Errors::Simple.new(msg: 'Artists - server error') unless res

      code = res['error']
      raise Laster::Errors::Simple.new(msg: res['message'], code: code) if code
    end
  end
end
