Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/api/get_check_digit/:isbn', to: 'isbn_api#get_check_digit'
  get '/api/check_validity/:isbn', to: 'isbn_api#check_validity'

  root 'isbn#index'
end
