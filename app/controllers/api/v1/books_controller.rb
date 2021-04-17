class Api::V1::BooksController < ApplicationController
  def index
    books = @logged_in_user
                 .books
                 .page(fetch_book_params[:page])

    if books
      render_response(200, books, @logged_in_user)
    else
      render_error_message(I18n.t("errors.not_found"),
                           I18n.t("errors.contact_system_admin"),
                           404)
    end
  end

  def create
    book = @logged_in_user.books.new(book_params)

    if book.save
      render_response(200, book)
    else
      render_error_message(I18n.t("errors.not_found"),
                           I18n.t("errors.contact_system_admin"),
                           404)
    end
  end

  def show
    book = @logged_in_user.books.find_by(id: params[:id])

    if book
      render_response(200, book)
    else
      render_error_message(I18n.t("errors.not_found"),
                           I18n.t("errors.contact_system_admin"),
                           404)
    end
  end

  def update
    book = @logged_in_user.books.find_by(id: params[:id])

    if book.update(book_params)
      render_response(200, book)
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

    def render_response(status, result, logged_in_user = nil)
      if logged_in_user
        render json: { status: status,
                       result: result,
                       total_count: logged_in_user.books.count,
                       total_page: result.total_pages,
                       current_page: result.current_page,
                       limit: result.limit_value },
               except: %i(user_id created_at updated_at),
               status: 200
      else
        render json: { status: status,
                       result: result },
               except: %i(user_id created_at updated_at),
               status: 200
      end
    end
end
