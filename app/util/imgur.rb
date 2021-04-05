require 'httpclient'

class Imgur

  URL = "https://api.imgur.com/3/image"

  def initialize
    @client_id = "585be2db01fab46"
  end

  def anonymous_upload(base64)
    auth_header = { Authorization: "Client-ID #{@client_id}"}
    upload(auth_header, base64)
  end

  private

  def upload(auth_header, base64)
    response = HTTPClient.new.post(URI.parse(URL),
                                   { image: base64 },
                                   auth_header)
    result_hash = JSON.load(response.body)
    result_hash['data']['link']
  end
end