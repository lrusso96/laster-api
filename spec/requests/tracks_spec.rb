# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Laster::Tracks API', type: :request do
  # initialize test data
  let!(:tracks) { create_list(:track, 10) }
  let(:valid_attributes) { { track: 'Wonderwall' } }
  let(:invalid_attributes) { { wrong_par: 'Searched Song' } }

  # Test suite for GET /tracks/top
  describe 'GET top songs' do
    # make HTTP get request before each example
    before { get '/tracks/top' }

    context 'default case' do
      it 'returns the top charts (10 songs now!)' do
        expect(json).not_to be_empty
        # remove this line after the implementation of search function!
        expect(json.size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for GET /tracks/latest
  describe 'GET latest songs' do
    # make HTTP get request before each example
    before { get '/tracks/latest' }

    context 'default case' do
      it 'returns the latest charts (100 songs now!)' do
        expect(json).not_to be_empty
        # remove this line after the implementation of search function!
        expect(json.size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for GET /tracks?track=song&{artist=a}
  describe 'GET search song' do
    # make HTTP get request before each example
    before { get '/tracks', params: valid_attributes }

    context 'when track parameter is present' do
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

    context 'when track parameter is NOT present' do
      before { get '/tracks', params: invalid_attributes }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/param is missing or the value is empty: track/)
      end
    end
  end
end
