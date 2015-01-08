Docs::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  resources :documents, path: 'doc', only: [:show]
  
  get ':action', :controller => 'front'

  root :to => 'front#index'
end
