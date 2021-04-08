require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do

  let(:user) { build(:user) }
  describe "POST /login" do
    it "returns http 200 status" do
      post "/api/v1/login", params: { email: user.email, password: user.password }
      expect(response.status).to eq(200)
    end

    it "returns http response" do
      post "/api/v1/login", params: { email: user.email, password: user.password }
      expect(JSON.parse(response.body)["result"]).to be_present
    end
  end

  describe "POST /sign_up" do
    it "returns http 200 status" do
      post "/api/v1/sign_up", params: { email: user.email, password: user.password }
      expect(response.status).to eq(200)
    end

    it "returns http response" do
      post "/api/v1/sign_up", params: { email: user.email, password: user.password }
      expect(JSON.parse(response.body)["result"]).to be_present
    end
  end

  describe "DELETE /logout" do
    it "returns http success" do
      delete "/api/v1/logout"

    end
  end
end
