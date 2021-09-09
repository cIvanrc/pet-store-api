require 'rails_helper'

describe 'Pets index', type: :request do
  context 'List all pets' do
    setup do
      create(:pet, name: 'pet_1')
    end

    let(:expected_result) do
      { 'name' => 'pet_1', 'tag' => nil }
    end

    it 'on success' do
      get api_v1_pets_path, headers: authorization_headers

      expect(response).to have_http_status(:ok)
      expect(json[:data].first[:attributes]).to eq expected_result
    end
  end

  context 'without jwt' do
    it 'unauthorized' do
      get api_v1_pets_path

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
