# frozen_string_literal: true

require_relative './api/laster.rb'

# Manages the /artist/* paths
class ArtistsController < ApplicationController
  # GET /artists?artist=a [opt: limit=l]
  def search
    validate_search_params
    artists_response Laster::Artists.search(params[:artist],
                                            limit: params[:limit])
  end

  # GET /artists/top_tracks?artist=a
  def top_tracks
    validate_top_params
    tracks_response Laster::Artists.top_tracks
  end

  # GET /artists/similar?artist=a
  def similar
    validate_similar_params
    artists_response Laster::Artists.similar(params[:artist])
  end

  private

  def validate_search_params
    # simple validation of search parameters
    params.require(:artist)
    params.permit(%i[artist limit])
  end

  def validate_top_params
    # simple validation of search similar
    params.require(%i[artist])
    params.permit(%i[artist])
  end

  def validate_similar_params
    # simple validation of search similar
    params.require(%i[artist])
    params.permit(%i[artist])
  end
end
