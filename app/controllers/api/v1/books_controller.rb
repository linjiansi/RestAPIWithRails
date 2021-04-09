class Api::V1::BooksController < ApplicationController

  before_action :authorized_user

  def fetch_books
    books_info = logged_in_user
                .books
                .page(fetch_book_param[:page])
    if books_info.present?
      render json: {
          status: 200,
          result: books_info.per(fetch_book_param[:limit]),
          total_count: logged_in_user.books.count,
          total_page: books_info.total_pages,
          current_page: books_info.current_page,
          limit: books_info.limit_value
      }
    else
      error_message
    end
  end

  def add_book
    book = logged_in_user.books.create(book_param)
    if book.present?
      render json: {
          status: 200,
          result: {
              id: book.id,
              name: book.name,
              image: book.image,
              price: book.price,
              purchase_date: book.purchase_date
          }
      }
    else
      error_message
    end
  end

  def fetch_book
    book = logged_in_user.books.find_by(id: params[:id])
    if book.present?
      render json: {
          status: 200,
          result: {
              id: book.id,
              name: book.name,
              image: book.image,
              price: book.price,
              purchase_date: book.purchase_date
          }
      }
    else
      error_message
    end
  end

  def edit_book
    book = logged_in_user.books.find_by(id: params[:id])
    if book.update(book_param)
      render json: {
            status: 200,
            result: {
                id: book.id,
                name: book.name,
                image: book.image,
                price: book.price,
                purchase_date: book.purchase_date
            }
      }
    else
      error_message
    end
  end

  private

  def book_param
    params.permit(:name,
                  :image,
                  :price,
                  :purchase_date)
  end

  def fetch_book_param
    params.permit(:limit, :page)
  end
end
