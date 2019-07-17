require_relative './api/laster.rb'
class TracksController < ApplicationController
  # GET /tracks?track=t [opt: artist=a, limit=l]
  def search
    validate_search_params
    tracks_response Laster::Tracks.search(params[:track],
                                          artist: params[:artist],
                                          limit: params[:limit])
  end

  # GET /tracks/top
  def top
    tracks_response Laster::Tracks.top
  end

  # GET /tracks/latest
  def latest
    tracks_response Laster::Tracks.latest
  end

  # GET /tracks/similar?artist=a&track=t
  def similar
    validate_similar_params
    tracks_response Laster::Tracks.similar(params[:track], params[:artist])
  end

  private

  def validate_search_params
    # simple validation of search parameters
    params.require(:track)
    params.permit(%i[artist limit track])
  end

  def validate_similar_params
    # simple validation of search similar
    params.require(%i[artist track])
    params.permit(%i[artist track])
  end
end
