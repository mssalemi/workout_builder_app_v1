# typed: true
# app/lib/json_web_token.rb
module JsonWebToken
  HMAC_SECRET = Rails.application.credentials.secret_key_base
  
    def self.encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, HMAC_SECRET)
    end
  
    def self.decode(token)
      body = JWT.decode(token, HMAC_SECRET)[0]
      HashWithIndifferentAccess.new(body)
    rescue JWT::DecodeError => e
      # Handle decode error (for example, log or raise)
      nil
    end
  end
  

  # 2. Correct Use of Rails.application.credentials
  # Switching to Rails.application.credentials.secret_key_base is the correct move for managing secrets in modern Rails applications. Just ensure that your credentials are properly set up and that secret_key_base is present in your config/credentials.yml.enc file.
  
  