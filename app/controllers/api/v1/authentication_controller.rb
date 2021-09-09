# frozen_string_literal: true

# Generate a JWT
class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :authenticate!

  def create
    render json: { token: JsonWebToken.encode(sub: payload) }, status: :created
  rescue
    render json: { errors: ['Invalid payload'] }, status: :unauthorized
  end

  private
  def payload
    ENV.fetch('TOKEN_PAYLOAD', 'IFea1xe9')
  end
end
