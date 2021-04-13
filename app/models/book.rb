class Book < ApplicationRecord
  belongs_to :user
  before_save :fetch_book_image_url

  def fetch_book_image_url
    self.image = Imgur.upload(image) if image.present?
  end
end
