require 'rails_helper'

describe 'Pets index', type: :request do
  context 'List all pets' do
    setup do
      create(:pet, name: 'pet_1')
    end

    let(:expected_result) do
      { 'name' => 'pet_1', 'tag' => nil }
    end

    it 'success' do
      get api_v1_pets_path, headers: authorization_headers

      expect(response).to have_http_status(:ok)
      expect(json[:data].first[:attributes]).to eq expected_result
    end
  end

  context 'Paginates' do
    setup do
      create_list(:pet, 101)
    end

    it 'limit 5 records per page by default' do
      get api_v1_pets_path, headers: authorization_headers

      expect(Pet.count).to eq 101
      expect(json[:data].count).to eq 5
    end

    it 'set a custom limit of records' do
      get api_v1_pets_path(limit: 10), headers: authorization_headers

      expect(Pet.count).to eq 101
      expect(json[:data].count).to eq 10
    end

    it 'max limit of 100 (trying to get 101)' do
      get api_v1_pets_path(limit: 101), headers: authorization_headers

      expect(Pet.count).to eq 101
      expect(json[:data].count).to eq 100
    end

    it 'contains link header to next page' do
      get api_v1_pets_path, headers: authorization_headers

      expect(Pet.count).to eq 101

      next_link = "<http://www.example.com/api/v1/pets?page=2; rel='next'>"
      expect(response.header['Link']).to eq next_link
    end
  end

  context 'without jwt' do
    it 'unauthorized' do
      get api_v1_pets_path

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
