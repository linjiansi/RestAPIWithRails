class ApplicationController < ActionController::API
  include JwtManager

  rescue_from StandardError, with: :internal_error

  def logged_in_user
    User.find_by(id: decoded_token[0]["user_id"]) if decoded_token
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized_user
    return if logged_in?
    render_error_message(I18n.t("errors.not_found"),
                         I18n.t("errors.contact_system_admin"),
                         404)
  end

  def render_error_message(message, description, status)
    render json: {
      result: { message: message, description: description }
    }, status: status
  end

  def internal_error
    render_error_message(I18n.t("errors.occur_system_error"),
                         I18n.t("errors.contact_system_admin"),
                         500)
  end
end
