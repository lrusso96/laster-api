# frozen_string_literal: true

# Laster module to interact with Last.fm API
module Laster
  require_relative './core/tracks.rb'
  require_relative './core/artists.rb'
  require_relative './concerns/error.rb'

  API_ENDPOINT = 'https://ws.audioscrobbler.com/2.0/?'
end
