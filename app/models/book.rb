class Book < ApplicationRecord
  belongs_to :user
  before_save :convert_book_image_url

  validates :name, presence: true

  def convert_book_image_url
    self.image = Imgur.upload(image) if image.present?
  end
end
