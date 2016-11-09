Rails.application.routes.draw do
  devise_for :users

  root :to => 'admin/index#index'

  namespace :admin do
    root :to => "index#index"
    resources :sites
  end

  scope :path => "/api/v1", :module => "api/v1", :as => "v1", :defaults => {:format => :json} do 
    post "login" => "auth#login"
    post "logout" => "auth#logout"

    resources :sites
  end
end
