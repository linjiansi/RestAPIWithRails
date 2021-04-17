module JwtManager
  def encode_token(payload)
    JWT.encode(payload, "password")
  end

  def decoded_token
    auth_header = request.headers["Authorization"]
    return unless auth_header

    token = auth_header.split[1]
    payload = JWT.decode(token, "password", true, algorithm: "HS256")
    @logged_in_user = User.find_by(id: payload[0]["user_id"])
  end
end
