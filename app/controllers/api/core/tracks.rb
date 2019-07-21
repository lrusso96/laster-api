# frozen_string_literal: true

require 'net/http'
require 'json'
module Laster
  # This class interacts with Last.fm Track module
  class Tracks
    # Searches for tracks given a query and possibly an artist
    def self.search(track, artist: nil, limit: nil)
      params = { method: 'track.search', api_key: ENV['LASTFM_API_KEY'],
                 format: 'json' }
      # I don't trust the caller
      args = { track: track, artist: artist, limit: limit }.compact
      params.reverse_merge!(args)

      uri = URI API_ENDPOINT
      uri.query = URI.encode_www_form params
      parse_search JSON.parse Net::HTTP.get_response(uri).body
    end

    # Searches for top tracks
    def self.top
      # TODO: implement method
      tracks = []
      1.upto 10 do |value|
        tracks << Track.new(title: "top - #{value}")
      end
      tracks
    end

    # Returns the latest tracks inserted
    def self.latest
      # TODO: implement method
      tracks = []
      1.upto 10 do |value|
        tracks << Track.new(title: "latest - #{value}")
      end
      tracks
    end

    # Searches for tracks similar to the artist and the song passed as arg
    def self.similar(track, artist)
      params = { method: 'track.getsimilar', artist: artist, track: track,
                 api_key: ENV['LASTFM_API_KEY'], format: 'json' }
      uri = URI API_ENDPOINT
      uri.query = URI.encode_www_form params
      parse_similar JSON.parse Net::HTTP.get_response(uri).body
    end

    # Get infos of a track
    def self.info(track, artist)
      params = { method: 'track.getinfo', artist: artist, track: track,
                 api_key: ENV['LASTFM_API_KEY'], format: 'json' }
      uri = URI API_ENDPOINT
      uri.query = URI.encode_www_form params
      parse_info JSON.parse Net::HTTP.get_response(uri).body
    end

    private_class_method def self.parse_search(res)
      catch_error res
      ret = []
      tracks = res['results']['trackmatches']['track']
      tracks.each do |t|
        # FIXME: add more fields!
        artist = Artist.new(name: t['artist'])
        ret << Track.new(title: t['name'], artist: artist)
      end
      ret
    end

    private_class_method def self.parse_similar(res)
      catch_error res
      ret = []
      tracks = res['similartracks']['track']
      tracks.each do |t|
        # FIXME: add more fields!
        artist = Artist.new(name: t['artist']['name'])
        ret << Track.new(title: t['name'], artist: artist)
      end
      ret
    end

    private_class_method def self.parse_info(res)
      catch_error res
      track = res['track']
      artist = Artist.new(name: track['artist']['name'])
      ret = Track.new(title: track['name'], artist: artist)
      # TODO: add image field
      album = track['album']
      return ret unless album

      album_artist = Artist.new(name: album['artist'])
      album = Album.new(title: album['title'], artist: album_artist)
      ret.album = album
      ret
    end

    private_class_method def self.catch_error(res)
      raise Laster::Errors::Simple.new(msg: 'Tracks - server error') unless res

      code = res['error']
      raise Laster::Errors::Simple.new(msg: res['message'], code: code) if code
    end
  end
end
