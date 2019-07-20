# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Laster::Artists API', type: :request do
  # initialize test data
  let!(:artists) { create_list(:artist, 10) }
  let(:valid_attributes) { { artist: 'Pink Floyd' } }
  let(:invalid_attributes) { { wrong_par: 'Searched Artist' } }

  # Test suite for GET /artist/top_tracks
  describe 'GET top tracks of artist' do
    # make HTTP get request before each example
    before { get '/artists/top_tracks', params: valid_attributes }

    context 'default case' do
      it 'returns the top tracks (10 now!)' do
        expect(json).not_to be_empty
        # remove this line after the implementation of search function!
        expect(json.size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for GET /artists?artist=a
  describe 'GET search artist' do
    # make HTTP get request before each example
    before { get '/artists', params: valid_attributes }

    context 'when artist parameter is present' do
      it 'returns the result of the search' do
        # Note `json` is a custom helper to parse JSON responses
        expect(json).not_to be_empty
        # assume 5 tracks at least
        expect(json.size).to be > 5
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when artist parameter is NOT present' do
      before { get '/artists', params: invalid_attributes }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/param is missing or the value is empty: artist/)
      end
    end
  end
end
