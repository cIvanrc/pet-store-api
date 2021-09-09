require 'rails_helper'

describe 'JWT', type: :request do
  context 'generate a jwt' do
    it 'authenticates response a jwt' do
      post api_v1_token_path

      response_body = JSON.parse(response.body)
      expect(response).to have_http_status(:created)
      expect(response_body.include?('token')).to eq true

      token = response_body['token']
      expect { JsonWebToken.decode(token) }.to_not raise_error
    end
  end
end
