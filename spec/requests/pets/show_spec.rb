require 'rails_helper'

describe 'Pets show', type: :request do
  let(:example_pet) { create(:pet, name: 'pet_1') }

  context 'Show a pet' do
    let(:serialized_pet) { JSON.parse(ApplicationController.render(json: example_pet)) }

    it 'on success' do
      get api_v1_pet_path(example_pet), headers: authorization_headers

      expect(response).to have_http_status(:ok)
      expect(json).to eq serialized_pet
    end
  end

  context 'Unsuccessfully' do
    it 'unauthorized' do
      get api_v1_pet_path(example_pet)

      expect(response).to have_http_status(:unauthorized)
    end

    it 'with invalid pet id' do
      get api_v1_pet_path(2), headers: authorization_headers

      error_message = {"code"=>199, "message"=>"Unexpected error"}
      expect(json).to eq error_message
    end
  end
end
