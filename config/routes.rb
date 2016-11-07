Rails.application.routes.draw do
  devise_for :users

  root :to => 'admin/index#index'

  namespace :admin do
    root :to => "index#index"
    resources :sites
  end
end
