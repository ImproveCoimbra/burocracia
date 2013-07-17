Docs::Application.routes.draw do
  resources :documents

  get 'doc/:id', :controller => 'front', :action => 'doc'
  get ':action', :controller => 'front'

  root :to => 'front#index'
end
