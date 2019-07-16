# config/routes.rb
Rails.application.routes.draw do
  get 'tracks', to: 'tracks#search'
  get 'tracks/top', to: 'tracks#top'
  get 'tracks/latest', to: 'tracks#latest'
  get 'search/:track(/:limit(/:page(/:artist)))' => 'search#show'
end
