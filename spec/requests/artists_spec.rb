# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Laster::Artists.top_tracks', type: :request do
  let(:valid_attr) { { artist: 'Pink Floyd' } }

  context 'default case' do
    before { get '/artists/top_tracks', params: valid_attr }

    it 'returns the top tracks (10 now!)' do
      expect(json).not_to be_empty
      # TODO: remove this line after the implementation of search function!
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end

RSpec.describe 'Laster::Artists.search', type: :request do
  let(:valid_attr) { { artist: 'Pink Floyd' } }
  let(:invalid_attr) { { wrong_par: 'Searched Artist' } }

  context 'when artist parameter is present' do
    before { get '/artists', params: valid_attr }

    it 'returns the result of the search' do
      expect(json).not_to be_empty
      # TODO: remove this line after the implementation of search function!
      expect(json.size).to be > 5
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  context 'when artist parameter is NOT present' do
    before { get '/artists', params: invalid_attr}

    it 'returns status code 400' do
      expect(response).to have_http_status(400)
    end

    it 'returns a validation failure message' do
      expect(response.body)
          .to match(/param is missing or the value is empty: artist/)
    end
  end
end

RSpec.describe 'Laster::Artists.similar', type: :request do
  let(:valid_attr) { { artist: 'Pink Floyd' } }
  let(:invalid_attr) { { wrong_arg: 'Pink Floyd' } }

  context 'default case' do
    before { get '/artists/similar', params: valid_attr }

    it 'returns the similar artists' do
      expect(json).not_to be_empty
      # TODO: remove this line after the implementation of search function!
      expect(json.size).to be > 5
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  context 'when artist parameter is NOT present' do
    before { get '/artists/similar', params: invalid_attr}

    it 'returns status code 400' do
      expect(response).to have_http_status(400)
    end

    it 'returns a validation failure message' do
      expect(response.body)
          .to match(/param is missing or the value is empty: artist/)
    end
  end
end
