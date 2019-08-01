# frozen_string_literal: true

require 'json'
module Laster
  # This class interacts with Last.fm Track module
  class Tracks
    # Searches for tracks given a query and possibly an artist
    def self.search(track, artist: nil, limit: nil)
      args = { track: track, artist: artist, limit: limit }
      parse_search Party.new(args).search_track
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
      args = { track: track, artist: artist }
      parse_similar Party.new(args).similar_tracks
    end

    # Get infos of a track
    def self.info(track, artist)
      args = { track: track, artist: artist }
      parse_info Party.new(args).info_track
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
      album = track['album']
      return ret unless album

      ret.album = extract_album album
      ret
    end

    private_class_method def self.extract_album(album)
      album_artist = Artist.new(name: album['artist'])
      images = album['image']
      album_images = []
      images.each do |img|
        album_images << Image.new(size: img['size'], url: img['#text'])
      end
      Album.new(title: album['title'], artist: album_artist,
                images: album_images)
    end

    private_class_method def self.catch_error(res)
      raise Laster::Errors::Simple.new(msg: 'Tracks - server error') unless res

      code = res['error']
      raise Laster::Errors::Simple.new(msg: res['message'], code: code) if code
    end
  end
end
