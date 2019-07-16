require 'net/http'
class SearchController < ApplicationController

  #GET /search
  def show
    limit = params[:limit]
    page = params[:page]
    track = params[:track]
    artist = params[:artist]

    uri = URI('https://ws.audioscrobbler.com/2.0/?')
    params = {:method => 'track.search', :track => track,
               :api_key => '6281ce214af85ae300785b8d40f2ecbb',
                :limit => limit, :page => page, :artist => artist,
                :format => 'json'}
    uri.query = URI.encode_www_form(params)
    #puts uri
    @res = Net::HTTP.get_response(uri)
    json_response(@res.body)
  end
end