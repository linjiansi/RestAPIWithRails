require 'httpclient'

module Imgur

  URL = "https://api.imgur.com/3/image"

  def self.upload(base64)
    @client_id = "585be2db01fab46"
    auth_header = { Authorization: "Client-ID #{@client_id}" }
    response = HTTPClient.new.post(URI.parse(URL),
                                   { image: base64 },
                                   auth_header)
    result_hash = JSON.load(response.body)
    result_hash['data']['link']
  end
end