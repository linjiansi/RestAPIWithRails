class ApplicationController < ActionController::API
  include JwtManager

  rescue_from StandardError, with: :internal_error

  def authorized_user
    begin
      decoded_token
    rescue
      render_error_message(I18n.t("errors.not_found"),
                           I18n.t("errors.contact_system_admin"),
                           404)
    end

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
