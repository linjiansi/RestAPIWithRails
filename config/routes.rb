Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/login',    to: 'users#login'
      post '/sign_up',  to: 'users#sign_up'
      delete '/logout', to: 'users#logout'

      get '/books',     to: 'books#fetch_books'
      post '/books',    to: 'books#add_book'
      get '/books/:id', to: 'books#fetch_book'
      put '/books/:id', to: 'books#edit_book'
    end
  end
end
