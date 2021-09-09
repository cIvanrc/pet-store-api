# frozen_string_literal: true

# Helps with the Authorization header and JSON response
module JwtHelper
  def authorization_headers
    @authorization_headers ||= { 'Authorization' => "Bearer #{jwt}" }
  end

  def jwt
    @jwt ||= JsonWebToken.encode(sub: ENV.fetch('TOKEN_PAYLOAD', 'IFea1xe9'))
  end

  def json
    JSON.parse(response.body).with_indifferent_access
  end
end
