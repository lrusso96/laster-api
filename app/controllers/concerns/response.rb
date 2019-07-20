# frozen_string_literal: true

# Simple wrapper of render json
module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def tracks_response(tracks, status = :ok)
    render json: tracks, status: status, root: true, only: :title,
           include: { artist: { only: :name },
                      album: { only: %i[title artist] } }
  end

  def artists_response(artists, status = :ok)
    render json: artists, status: status, root: true, only: %i[name]
  end
end
