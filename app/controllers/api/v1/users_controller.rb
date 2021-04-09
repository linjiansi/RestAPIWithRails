class Api::V1::UsersController < ApplicationController
  before_action :authorized_user, only: :logout

  def login
    login_user = User.find_by(email: params[:email])
    if login_user&.authenticate(params[:password])
      token = encode_token({ user_id: login_user.id })
      render json: {
        status: 200,
        result: {
          id: login_user.id,
          email: login_user.email,
          token: token
        }
      }
    else
      authorize_error
    end
  end

  def sign_up
    sign_up_user = User.new(user_params)
    if sign_up_user.save
      token = encode_token({ user_id: sign_up_user.id })
      render json: {
        status: 200,
        result: {
          id: sign_up_user.id,
          email: sign_up_user.email,
          token: token
        }
      }
    else
      authorize_error
    end
  end

  def logout
    render json: { status: 200 }
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
