Docs::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :documents, path: 'doc', only: [:show]

  get '/', controller: :front, action: :index
  get '/search', controller: :front, action: :search, as: :search

  root :to => 'front#index'
end
