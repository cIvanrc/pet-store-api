require 'rails_helper'

describe 'Pets index', type: :request do
  context 'List all pets' do
    setup do
      create(:pet, name: 'pet_1')
    end

    let(:expected_result) do
      { 'data' => [{
        'id' => '1',
        'type' => 'pets',
        'attributes' => { 'name' => 'pet_1', 'tag' => nil }
      }] }
    end

    it 'on success' do
      get api_v1_pets_path, headers: authorization_headers

      response_body = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(json).to eq response_body
    end
  end

  context 'without jwt' do
    it 'unauthorized' do
      get api_v1_pets_path

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
