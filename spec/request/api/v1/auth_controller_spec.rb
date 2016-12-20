require 'rails_helper'
require 'byebug'
require 'devise'

RSpec.describe Api::V1::AuthController, type: :request do
  let!(:user) { FactoryGirl.create(:user, :email => FactoryGirl.generate(:email)) }
  let!(:old_user) { FactoryGirl.create(:auth_user, :email => FactoryGirl.generate(:email)) }
  describe "#login" do 

    it "login success" do 
     post '/api/v1/login', params: { :email => user.email, :password => user.password }

     expect(response).to have_http_status(200)

     user.reload
     data = { "status" => 200,
              "message" => "Login OK",
              "user_id" => user.id,
              "auth_token" => user.authentication_token
             }

      expect(JSON.parse(response.body)).to eq(data)
    end  

    it "login failed with wrong email or password" do
        post '/api/v1/login', params: { :email => user.email, :password => "xxx" }
        expect(response.status).to eq(401)
    end
  end 
    
  describe "#logout" do 

    it "logout failed with no auth_token" do 
     post '/api/v1/logout'

     expect(response).to have_http_status(401)
    end 

    it "logout success" do 
      old_auth_token = old_user.authentication_token
      byebug
      post '/api/v1/logout', :auth_token => old_auth_token 

      expect(response).to have_http_status(200)

      old_user.reload
      expect(old_user.authentication_token).not_to eq(old_auth_token)
    end  
  end  
end  