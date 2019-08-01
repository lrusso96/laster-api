# frozen_string_literal: true

require 'httparty'

module Laster
  API_ENDPOINT = 'https://ws.audioscrobbler.com/2.0/?'

  # Http utils class that defines Last paths
  class Party
    include HTTParty

    attr_reader :headers
    attr_reader :options

    # @param [Hash] args
    def initialize(args)
      @args = args.compact
      @headers = { 'User-Agent' => ENV['USER_AGENT'] }
    end

    def search_track
      any_call 'track.search'
    end

    def search_artist
      any_call 'artist.search'
    end

    def similar_tracks
      any_call 'track.getsimilar'
    end

    def similar_artists
      any_call 'artist.getsimilar'
    end

    def info_track
      any_call 'track.getinfo'
    end

    private

    def any_call(method)
      params = build_params(method)
      # I don't trust the caller
      args = @args.compact
      params.reverse_merge!(args)
      easy self.class.get(API_ENDPOINT, build_op(params))
    end

    def build_params(method)
      { method: method, api_key: ENV['LASTFM_API_KEY'], format: 'json' }
    end

    def build_op(params)
      { query: params, headers: @headers }
    end

    def easy(res)
      JSON.parse res.body
    end
  end
end
