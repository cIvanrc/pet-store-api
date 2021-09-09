require 'rails_helper'

describe 'Create a Pet', type: :request do
  context 'Can create a pet' do
    let (:pet_params) { { pet: { name: 'new_pet' } } }

    it 'on success' do
      post api_v1_pets_path, headers: authorization_headers, params: pet_params

      expect(response.body.present?).to be false
      expect(response).to have_http_status(:created)
    end
  end

  context 'fails' do
    it 'without jwt' do
      post api_v1_pets_path

      expect(response).to have_http_status(:unauthorized)
    end

    it 'without name param' do
      post api_v1_pets_path, headers: authorization_headers, params: { pet: {tag: 'tag', name: ''} }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(json[:errors][:name].first).to eq("can't be blank")

    end

    it 'without params' do
      post api_v1_pets_path, headers: authorization_headers, params: { }

      expect(response).to have_http_status(:not_found)

      example_error = {"code"=>115, "message"=>"Missing required parameter"}
      expect(json).to eq example_error
    end
  end
end
