# frozen_string_literal: true

# Handles the #encode and #decode JWT
# another change
class JsonWebToken
  def self.encode(payload)
     expiration = 60.minutes.from_now.to_i
     payload = payload.merge(exp: expiration)
     JWT.encode(payload, jwt_secret)
  end

  def self.decode(token)
    JWT.decode(token, jwt_secret).first
  end

  def self.jwt_secret
    ENV.fetch('JWT_SECRET', 'xoo1Eigh')
  end

  private_class_method :jwt_secret
end
