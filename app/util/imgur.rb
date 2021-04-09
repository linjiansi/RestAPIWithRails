require 'httpclient'
require 'dotenv/load'

module Imgur

  URL = "https://api.imgur.com/3/image".freeze

  def self.upload(base64)
    auth_header = { Authorization: "Client-ID #{ENV['CLIENT_ID']}" }
    response = HTTPClient.new.post(URI.parse(URL),
                                   { image: base64 },
                                   auth_header)
    result_hash = JSON.parse(response.body)
    result_hash['data']['link']
  end
end