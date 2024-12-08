class ApplicationController < ActionController::Base
  before_action :ensure_json_request#, except: [:new, :create, :edit, :update, :show, :index]
  #before_action :authorize

  JWT_SECRET = ENV["JWT_SECRET_KEY"] || "default_secret"

  def ensure_json_request
    return if request.format == :json
    render nothing: true, status: 406
  end
  # def ensure_json_request
  #   return if request.headers["Accept"] =~ /vnd\.api\+json/
  #   render json: { error: "Only JSON requests are accepted" }, status: :not_acceptable
  # end

  def encode_token(payload)
    payload[:exp] = 24.hours.from_now.to_i
    JWT.encode(payload, JWT_SECRET)
  end

  def decode_token
    auth_token = request.headers["Authorization"]

    if auth_token
      token = auth_token.split(" ").last
      begin
        JWT.decode(token, JWT_SECRET, true, algorithm: "HS256")
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def authorized_user
    decoded_token = decode_token
    if decoded_token
      user_id = decoded_token[0]["user_id"]
      @user = User.find_by(id: user_id)
    end
  end

  def authorize
    render json: { error: "Not authorized" }, status: :unauthorized unless authorized_user
  end
end
