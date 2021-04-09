class Book < ApplicationRecord
  belongs_to :users, optional: true
  before_save :fetch_book_image_url

  def fetch_book_image_url
    self.image = Imgur.new.anonymous_upload(image) if image.present?
  end
end
