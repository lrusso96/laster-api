# frozen_string_literal: true

require 'json'
module Laster
  # Interacts with Last.fm Artist module
  class Artists
    def self.search(artist, limit: nil)
      args = { artist: artist, limit: limit }.compact
      parse_search Party.new(args).search_artist
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

    def self.similar(artist, limit: nil)
      args = { artist: artist, limit: limit }.compact
      parse_similar Party.new(args).similar_artists
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

    private_class_method def self.parse_similar(res)
      catch_error res
      ret = []
      artists = res['similarartists']['artist']
      artists.each do |a|
        ret << Artist.new(name: a['name'])
      end
      ret
    end
  end
end
