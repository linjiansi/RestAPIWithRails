class Api::V1::BooksController < ApplicationController
  before_action :authorized_user

  def index
    books_info = @logged_in_user
                 .books
                 .page(fetch_book_params[:page])

    if books_info
      render json: {
        status: 200,
        result: books_info.per(fetch_book_params[:limit]),
        total_count: @logged_in_user.books.count,
        total_page: books_info.total_pages,
        current_page: books_info.current_page,
        limit: books_info.limit_value
      }, status: 200
    else
      render_error_message(I18n.t("errors.not_found"),
                           I18n.t("errors.contact_system_admin"),
                           404)
    end
  end

  def create
    book = @logged_in_user.books.new(book_params)

    if book.save
      render json: {
        status: 200,
        result: {
          id: book.id,
          name: book.name,
          image: book.image,
          price: book.price,
          purchase_date: book.purchase_date
        }
      }, statua: 200
    else
      render_error_message(I18n.t("errors.not_found"),
                           I18n.t("errors.contact_system_admin"),
                           404)
    end
  end

  def show
    book = @logged_in_user.books.find_by(id: params[:id])

    if book
      render json: {
        status: 200,
        result: {
          id: book.id,
          name: book.name,
          image: book.image,
          price: book.price,
          purchase_date: book.purchase_date
        }
      }, status: 200
    else
      render_error_message(I18n.t("errors.not_found"),
                           I18n.t("errors.contact_system_admin"),
                           404)
    end
  end

  def update
    book = @logged_in_user.books.find_by(id: params[:id])

    if book.update(book_params)
      render json: {
        status: 200,
        result: {
          id: book.id,
          name: book.name,
          image: book.image,
          price: book.price,
          purchase_date: book.purchase_date
        }
      }, status: 200
    else
      render_error_message(I18n.t("errors.not_found"),
                           I18n.t("errors.contact_system_admin"),
                           404)
    end
  end

  private

    def book_params
      params.permit(:name,
                    :image,
                    :price,
                    :purchase_date)
    end

    def fetch_book_params
      params.permit(:limit, :page)
    end
end
