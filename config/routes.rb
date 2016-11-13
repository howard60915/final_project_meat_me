Rails.application.routes.draw do
  devise_for :users

  root :to => 'welcome#index'

  namespace :admin do
    root :to => "index#index"
    resources :sites
    resources :users
    resources :posts
  end

  scope :path => "/api/v1", :module => "api/v1", :as => "v1", :defaults => {:format => :json} do
    post "login" => "auth#login"
    post "logout" => "auth#logout"

    resources :plants, :only => [:index, :show] do 
      collection do 
        post :recognize
      end  
    end  
    resources :sites
    resources :posts do
      resources :comments, :only => [:create, :update, :destroy]
    end
  end
end
