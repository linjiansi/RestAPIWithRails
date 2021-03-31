class Api::V1::UsersController < ApplicationController

  before_action :authenticate, only: [:logout]

  def login
    login_user = User.find_by(user_param)
    if login_user.present?
      render json: {
          status: 200,
          result: {
              id: login_user.id,
              email: login_user.email,
              token: login_user.token
          }
      }
    else
      render json: {
          result: {
              message: "認証エラーです",
              description: "リクエストをご確認ください"
          }
      }
    end
  end

  def sign_up
    sign_up_user = User.create(user_param)
    if sign_up_user.present?
      render json: {
          status: 200,
          result: {
              id: sign_up_user.id,
              email: sign_up_user.email,
              token: sign_up_user.token
          }
      }
    else
      render json: {
          result: {
              message: "認証エラーです",
              description: "リクエストをご確認ください"
          }
      }
    end
  end

  def logout
    if @auth_user.present?
      @auth_user.update(token: null)
      render json: { status: 200 }
    else
      render json: {
          result: {
              message: "見つかりません",
              description: "システム管理者にお問い合わせください"
          }
      }
    end
  end

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      @auth_user = User.find_by(token: token)
    end
  end

  def user_param
    params.permit(:email, :password)
  end
end
