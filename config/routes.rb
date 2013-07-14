Docs::Application.routes.draw do
  resources :documents

  match 'doc/:id', :controller => 'front', :action => 'doc'
  match ':action', :controller => 'front'

  root :to => 'front#index'
end
