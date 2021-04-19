require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  include JwtManager

  let!(:login_user) { create(:user) }
  let(:login_params) { { email: login_user.email, password: login_user.password } }
  let(:sign_up_user) { User.find_by(email: sign_up_params[:email]) }
  let(:sign_up_params) { attributes_for(:user) }

  describe "#login" do
    before do
      post "/api/v1/login", params: login_params
    end

    it "returns http 200 status" do
      expect(response.status).to eq(200)
    end

    it "returns http response" do
      expect(JSON.parse(response.body)["result"]).to include({ "id" => login_user.id,
                                                               "email" => login_user.email,
                                                               "token" => encode_token({ user_id: login_user.id })
                                                             })
    end
  end

  describe "#sign_up" do
    before do
      post "/api/v1/sign_up", params: sign_up_params
    end

    it "returns http 200 status" do
      expect(response.status).to eq(200)
    end

    it "returns http response" do
      expect(JSON.parse(response.body)["result"]).to include({ "id" => sign_up_user.id,
                                                               "email" => sign_up_user.email,
                                                               "token" => encode_token({ user_id: sign_up_user.id })
                                                             })
    end
  end

  describe "#logout" do
    before do
      delete "/api/v1/logout", headers: { CONTENT_TYPE: "application/json",
                                          Authorization: "Token #{encode_token({ user_id: login_user.id })}" }
    end

    it "returns http 200 success" do
      expect(response.status).to eq(200)
    end

    it "returns http response" do
      expect(JSON.parse(response.body)).to include({ "status" => 200 })
    end
  end
end
