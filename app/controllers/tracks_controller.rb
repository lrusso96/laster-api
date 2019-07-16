class TracksController < ApplicationController
  # GET /tracks/{q=query}
  def search
    validate_search_params
    # fake search, return 2 tracks
    @tracks = Laster.search_tracks(params[:q])
    json_response(@tracks)
  end

  # GET /tracks/top
  def top
    @tracks = Laster.top_tracks
    json_response(@tracks)
  end

  # GET /tracks/latest
  def latest
    @tracks = Laster.latest_tracks
    json_response(@tracks)
  end

  private

  def validate_search_params
    # simple validation of search parameters
    params.require(:q)
  end
end
