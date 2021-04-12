Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/login',    to: 'users#login'
      post '/sign_up',  to: 'users#sign_up'
      delete '/logout', to: 'users#logout'

      resources :books, only: [:index, :create, :show, :update]
    end
  end
end
