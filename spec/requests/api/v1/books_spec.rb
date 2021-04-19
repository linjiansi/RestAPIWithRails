require 'rails_helper'

RSpec.describe "Api::V1::Books", type: :request do
  include JwtManager
  let!(:user) { create(:user) }
  let!(:book) { create(:book, user_id: user.id) }
  let(:posted_book) { Book.find_by(id: book.id + 1) }
  let(:updated_book) { Book.find_by(id: book.id) }
  let(:headers) { { CONTENT_TYPE: "application/json",
                    Authorization: "Token #{encode_token({ user_id: user.id })}" } }
  let(:params) { attributes_for(:book) }

  before do
    dummy_link = "http://dummy_link"
    allow(Imgur).to receive(:upload).and_return(dummy_link)
  end

  describe "GET /books" do
    before do
      get "/api/v1/books", headers: headers
    end

    it "returns http 200 success" do
      expect(response.status).to eq(200)
    end

    it "returns http response" do
      expect(JSON.parse(response.body)["result"][0]).to include({ "id" => book.id,
                                                                  "name" => book.name,
                                                                  "image" => book.image,
                                                                  "price" => book.price,
                                                                  "purchase_date" => book.purchase_date })
    end
  end

  describe "POST /books" do
    before do
      post "/api/v1/books", params: params.to_json, headers: headers
    end

    it "returns http 200 success" do
      expect(response.status).to eq(201)
    end

    it "returns http response" do
      expect(JSON.parse(response.body)["result"]).to include({ "id" => posted_book.id,
                                                               "name" => posted_book.name,
                                                               "image" => posted_book.image,
                                                               "price" => posted_book.price,
                                                               "purchase_date" => posted_book.purchase_date })
    end

    it "creates a book" do
      expect { post "/api/v1/books", params: params.to_json, headers: headers }.to change(Book, :count).by(1)
    end
  end

  describe "GET /books/:id" do
    before do
      get "/api/v1/books/#{book.id}", headers: headers
    end

    it "returns http 200 response" do
      expect(response.status).to eq(200)
    end

    it "returns http response" do
      expect(JSON.parse(response.body)["result"]).to include({ "id" => book.id,
                                                               "name" => book.name,
                                                               "image" => book.image,
                                                               "price" => book.price,
                                                               "purchase_date" => book.purchase_date })
    end
  end

  describe "PUT /books/:id" do
    before do
      put "/api/v1/books/#{book.id}", params: params.to_json, headers: headers
    end

    it "returns http 200 success" do
      expect(response.status).to eq(200)
    end

    it "returns http response" do
      expect(JSON.parse(response.body)["result"]).to include({ "id" => updated_book.id,
                                                               "name" => updated_book.name,
                                                               "image" => updated_book.image,
                                                               "price" => updated_book.price,
                                                               "purchase_date" => updated_book.purchase_date })
    end
  end
end
