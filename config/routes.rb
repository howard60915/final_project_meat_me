Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    root :to => "index#index"
    resources :sites
  end
end
