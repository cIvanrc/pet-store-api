class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :error_record_not_found

  before_action :set_default_format
  before_action :authenticate!

  private
  def set_default_format
    request.format = :json
  end

  def authenticate!
    JsonWebToken.decode(auth_token)
  rescue JWT::DecodeError
    render json: { errors: ['invalid auth token'] }, status: :unauthorized
  end

  def auth_token
    @auth_token ||= request.headers.fetch('Authorization', '').split(' ').last
  end

  def error_record_not_found
    render json: { code: 199, message: 'Unexpected error' }
  end
end
