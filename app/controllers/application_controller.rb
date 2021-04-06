class ApplicationController < ActionController::API

  def encode_token(palyload)
    JWT.encode(palyload, 'shoshosdodh')
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split[1]
      begin
        JWT.decode(token, 'shoshosdodh', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
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

  def authorized_checker
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

  rescue_from Exeption, with: :internal_error

  def internal_error
    render json: {
        result: {
            message: "システムエラーが起こりました",
            description: "システム管理者にお問い合わせください"
        }
    }
  end
end
