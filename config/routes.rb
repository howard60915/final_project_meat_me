Rails.application.routes.draw do
  devise_for :users

  root :to => 'welcome#index'

  namespace :admin do
    root :to => "index#index"
    resources :sites
    resources :users
  end

  scope :path => "/api/v1", :module => "api/v1", :as => "v1", :defaults => {:format => :json} do
    post "login" => "auth#login"
    post "logout" => "auth#logout"

    resources :sites
    resources :posts
  end
end
