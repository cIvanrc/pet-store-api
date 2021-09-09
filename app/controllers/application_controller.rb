class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :error_record_not_found
  rescue_from ActionController::ParameterMissing, with: :error_missing_params

  before_action :set_default_format
  before_action :authenticate!

  def not_found
    endpoint = params[:unmatched]
    render json: { code: 140, message: "Endpoint #{endpoint} not found." }, status: :bad_request
  end

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
    render json: { code: 199, message: 'Unexpected error' }, status: :internal_server_error
  end

  def error_missing_params
    render json: { code: 115, message: 'Missing required parameter' }, status: :not_found
  end
end
