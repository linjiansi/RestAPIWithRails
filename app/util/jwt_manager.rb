module JwtManager
  def encode_token(palyload)
    JWT.encode(palyload, "password")
  end

  def decoded_token
    auth_header = request.headers["Authorization"]
    return unless auth_header

    token = auth_header.split[1]
    begin
      JWT.decode(token, "password", true, algorithm: "HS256")
    rescue StandardError
      nil
    end
  end
end
