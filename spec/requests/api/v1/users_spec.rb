require 'rails_helper'

RSpec.describe "Api::V1::Users",
               type: :request do

  let(:sign_up_user) { build(:user) }
  let!(:login_user) { create(:user) }

  describe "#login" do

    before do
      post "/api/v1/login", params: { email: login_user.email, password: login_user.password }
    end

    it "returns http 200 status" do
      expect(response.status).to eq(200)
    end

    it "returns http response" do
      expect(JSON.parse(response.body)["result"]).to include("id", "email", "token")
    end
  end

  describe "#sign_up" do

    before do
      post "/api/v1/sign_up", params: { email: sign_up_user.email, password: sign_up_user.password }
    end

    it "returns http 200 status" do
      expect(response.status).to eq(200)
    end

    it "returns http response" do
      expect(JSON.parse(response.body)["result"]).to include("id", "email", "token")
    end
  end

  describe "#logout" do

    it "returns http success" do
      delete "/api/v1/logout"
      #ヘッダーにトークンを付与させる部分がわからない状態です。
    end
  end
end
