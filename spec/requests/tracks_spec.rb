# frozen_string_literal: true

require 'rails_helper'

# Test suite for GET /tracks?track=song&{artist=a}
RSpec.describe 'Laster::Tracks.search', type: :request do
  let(:valid_attr) { { track: 'Wonderwall' } }
  let(:limit) { 5 }
  let(:full_attr) { { track: 'Smells like teen spirit', artist: 'Nirvana', limit: limit } }
  let(:invalid_attr) { { wrong_par: 'Searched Song' } }

  context 'when at least TRACK parameter is present' do
    before { get '/tracks', params: valid_attr }

    it 'returns the result of the search' do
      expect(json).not_to be_empty
      # assume 5 tracks at least
      expect(json.size).to be > 5
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  context 'when TRACK and optional parameters are present' do
    before { get '/tracks', params: full_attr }

    it 'returns the result of the search' do
      expect(json).not_to be_empty
      # assume 5 tracks at least
      expect(json.size).to eq(limit)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  context 'when track parameter is NOT present' do
    before { get '/tracks', params: invalid_attr }

    it 'returns status code 400' do
      expect(response).to have_http_status(400)
    end

    it 'returns a validation failure message' do
      expect(response.body)
        .to match(/param is missing or the value is empty: track/)
    end
  end
end

RSpec.describe 'Laster::Tracks.info', type: :request do
  let(:valid_attr) { { track: 'Hello', artist: 'Adele' } }
  let(:invalid_attr) { { track: 'The wall' } }

  context 'when both TRACK and ARTIST parameters are present' do
    before { get '/tracks/info', params: valid_attr }

    it 'returns the result of the search' do
      expect(json).not_to be_empty
      # FIXME: parse result to see details!
      expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  context 'when a required parameter is NOT present' do
    before { get '/tracks/info', params: invalid_attr }

    it 'returns status code 400' do
      expect(response).to have_http_status(400)
    end

    it 'returns a validation failure message' do
      expect(response.body)
        .to match(/param is missing or the value is empty: artist/)
    end
  end
end

RSpec.describe 'Laster::Tracks.similar', type: :request do
  let(:valid_attr) { { track: 'Hello', artist: 'Adele' } }
  let(:invalid_attr) { { track: 'Hello' } }

  context 'when both TRACK and ARTIST parameters are present' do
    before { get '/tracks/similar', params: valid_attr }

    it 'returns the result of the search' do
      expect(json).not_to be_empty
      # FIXME: parse result to see details!
      expect(json.size).to be > 0
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  context 'when a required parameter is NOT present' do
    before { get '/tracks/similar', params: invalid_attr }

    it 'returns status code 400' do
      expect(response).to have_http_status(400)
    end

    it 'returns a validation failure message' do
      expect(response.body)
        .to match(/param is missing or the value is empty: artist/)
    end
  end
end

# Test suite for GET /tracks/top
RSpec.describe 'Laster::Tracks.top', type: :request do
  let!(:tracks) { create_list(:track, 10) }

  context 'default case' do
    before { get '/tracks/top' }

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
RSpec.describe 'Laster::Tracks.latest', type: :request do
  let!(:tracks) { create_list(:track, 10) }

  context 'default case' do
    before { get '/tracks/latest' }

    it 'returns the most recent charts (10 songs now!)' do
      expect(json).not_to be_empty
      # remove this line after the implementation of search function!
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
