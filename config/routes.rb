# frozen_string_literal: true

Rails.application.routes.draw do
  get 'tracks', to: 'tracks#search'
  get 'tracks/top', to: 'tracks#top'
  get 'tracks/latest', to: 'tracks#latest'
  get 'tracks/similar', to: 'tracks#similar'
  get 'tracks/info', to: 'tracks#info'

  get 'artists', to: 'artists#search'
  get 'artists/top_tracks', to: 'artists#top_tracks'
  get 'artists/similar', to: 'artists#similar'
end
