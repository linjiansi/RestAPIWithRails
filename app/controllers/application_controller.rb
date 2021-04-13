class ApplicationController < ActionController::API
  include JwtManager

  def logged_in_user
    User.find_by(id: decoded_token[0]["user_id"]) if decoded_token
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized_user
    return if logged_in?
    render_error_message(I18n.t("errors.not_found"),
                         I18n.t("errors.contact_system_admin"))
  end

  def render_error_message(message, description)
    render json: {
      result: { message: message, description: description }
    }
  end

  def internal_error
    render_error_message(I18n.t("errors.occur_system_error"),
                         I18n.t("errors.contact_system_admin"))
  end

  rescue_from StandardError, with: :internal_error
end
