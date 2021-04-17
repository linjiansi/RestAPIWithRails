module JwtManager
  def encode_token(payload)
    JWT.encode(payload, "password")
  end

  def decode_token(payload)
    JWT.decode(payload, "password", true, algorithm: "HS256")
  end
end
