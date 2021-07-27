module Authenticable
  private

  def authenticate_with_token
    @token = request.headers['Authorization']

    unless valid_token?
      render json: { errors: "Please inform a authorization header to authenticate (any with at least 10 chars)" }, status: :unauthorized
    end
  end

  def valid_token?
    @token.present? && @token.size >= 10
  end
end