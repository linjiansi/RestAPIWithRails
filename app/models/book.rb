class Book < ApplicationRecord
  belongs_to :users, optional: true
  before_create :fetch_book_image_url
  before_update :fetch_book_image_url

  def fetch_book_image_url
    self.image = Imgur.new.anonymous_upload(image) if image.present?
  end
end
