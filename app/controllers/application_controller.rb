class ApplicationController < ActionController::API
  include JwtManager

  def logged_in_user
    User.find_by(id: decoded_token[0]["user_id"]) if decoded_token
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized_user
    error_message unless logged_in?
  end

  def render_error_message(message, description)
    render json: {
      result: { message: message, description: description }
    }
  end

  def error_message
    render_error_message("見つかりません",
                         "システム管理者にお問い合わせください")
  end

  def authorize_error
    render_error_message("認証エラーです",
                         "リクエストをご確認ください")
  end

  def internal_error
    render_error_message("システムエラーが起こりました",
                         "システム管理者にお問い合わせください")
  end

  rescue_from StandardError, with: :internal_error
end
