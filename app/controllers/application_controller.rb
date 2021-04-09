class ApplicationController < ActionController::API

  def encode_token(palyload)
    JWT.encode(palyload, 'password')
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split[1]
      JWT.decode(token, 'password', true, algorithm: 'HS256') rescue JWT::DecodeError nil
    end
  end

  def logged_in_user
    if decoded_token
      User.find_by(id: decoded_token[0]['user_id'])
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def error_message
    render json: {
      result: {
        message: '見つかりません',
        description: 'システム管理者にお問い合わせください'
      }
    }
  end

  def authorized_user
    error_message unless logged_in?
  end

  def authorize_error
    render json: {
        result: {
            message: "認証エラーです",
            description: "リクエストをご確認ください"
        }
    }
  end

  rescue_from StandardError, with: :internal_error

  def internal_error
    render json: {
        result: {
            message: "システムエラーが起こりました",
            description: "システム管理者にお問い合わせください"
        }
    }
  end
end
