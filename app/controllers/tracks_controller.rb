require_relative './api/core/laster.rb'
class TracksController < ApplicationController
  # GET /tracks?track=t{artist=a, limit=l}
  def search
    validate_search_params
    # fake search, return 2 tracks
    args = { track: params[:track], artist: params[:artist],
             limit: params[:limit] }
    @tracks = Laster::Tracks.search(args)
    tracks_response(@tracks)
  end

  # GET /tracks/top
  def top
    @tracks = Laster::Tracks.top
    tracks_response(@tracks)
  end

  # GET /tracks/latest
  def latest
    @tracks = Laster::Tracks.latest
    tracks_response(@tracks)
  end

  # GET /tracks/similar{artist=a, track=t}
  def similar
    validate_similar_params
    @tracks = Laster::Tracks.similar(params[:track], params[:artist])
    tracks_response(@tracks)
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
