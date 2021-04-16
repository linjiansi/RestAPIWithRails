class Api::V1::UsersController < ApplicationController
  def login
    login_user = User.find_by(email: params[:email])

    if login_user&.authenticate(params[:password])
      token = encode_token({ user_id: login_user.id })
      render_response(200, login_user, token)
    else
      render_error_message(I18n.t("errors.auth_error"),
                           I18n.t("errors.confirm_request"),
                           400)
    end
  end

  def sign_up
    sign_up_user = User.new(user_params)

    if sign_up_user.save
      token = encode_token({ user_id: sign_up_user.id })
      render_response(200, sign_up_user, token)
    else
      render_error_message(I18n.t("errors.auth_error"),
                           I18n.t("errors.confirm_request"),
                           400)
    end
  end

  def logout
    render json: { status: 200 }, status: 200
  end

  private

    def user_params
      params.permit(:email, :password)
    end

    def render_response(status, user, token)
      result = {
          id: user.id,
          email: user.email,
          token: token
      }
      render json: { status: status, result: result },
             except: %i(created_id updated_id),
             status: 200
    end
end
