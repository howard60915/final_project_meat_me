require 'rails_helper'
require 'byebug'

RSpec.describe Api::V1::PostsController, type: :request do

  let!(:auth_user) { FactoryGirl.create(:auth_user, :email => FactoryGirl.generate(:email)) }

  describe '#index' do
    before(:each) { 10.times { FactoryGirl.create(:post, :title => FactoryGirl.generate(:title)) }}
    it "Post index" do
      get "/api/v1/posts", params: { :auth_token => auth_user.authentication_token }

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["plantArticles"].size).to be > 0
    end 
  end

  describe '#ceate' do
    subject(:success) do
      post "/api/v1/posts", params: { 
                                    :auth_token => auth_user.authentication_token,
                                    :post => { :title => "AlphaGo", :content => "succulent plants rocks" } 
                                    }
      JSON.parse(response.body)                               
    end

    subject(:failed) do
      post "/api/v1/posts", params: { 
                                    :auth_token => "1234",
                                    :post => { :title => "AlphaGo", :content => "succulent plants rocks" } 
                                    }
      JSON.parse(response.body)                               
    end

    it "Post Create success" do 
      success                             
      expect(response).to have_http_status(200)
      expect(success["post"]["title"]).to eq("AlphaGo")
    end

    it "Post create failed with auth failed" do
      failed
      expect(response).to have_http_status(401)
    end  
  end

  describe '#update' do
    let!(:posted) { FactoryGirl.create(:post, :user => auth_user) }
    let!(:postuser) { FactoryGirl.create(:post) }

    it 'update success' do
      patch "/api/v1/posts/#{posted.id}", params: { 
                                                  :auth_token => auth_user.authentication_token,
                                                  :post => { :title => "BetaGo"} 
                                                  }
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["post"]["title"]).to eq("BetaGo")
    end

    it 'update failed with auth failed' do
      patch "/api/v1/posts/#{posted.id}", params: { 
                                                  :auth_token => "1234",
                                                  :post => { :title => "BetaGo"} 
                                                  }
      expect(response).to have_http_status(401)
    end 

    it 'update failed with wrong author' do
      patch "/api/v1/posts/#{postuser.id}", params: { 
                                                  :auth_token => auth_user.authentication_token,
                                                  :post => { :title => "BetaGo"} 
                                                  }

      expect(response).to have_http_status(401)
      expect(JSON.parse(response.body)["message"]).to eq("Post update failed") 
    end  
  end  

  describe '#destroy' do
    let!(:posted) { FactoryGirl.create(:post, :user => auth_user) }
    let!(:postuser) { FactoryGirl.create(:post) }

    it 'update success' do
      delete "/api/v1/posts/#{posted.id}", params: { :auth_token => auth_user.authentication_token }

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("Post destroied")
    end

    it 'destroy failed with auth failed' do
      delete "/api/v1/posts/#{posted.id}", params: { :auth_token => "1234" }
      
      expect(response).to have_http_status(401)
    end 

    it 'destroy failed with wrong author' do
      delete "/api/v1/posts/#{postuser.id}", params: { :auth_token => auth_user.authentication_token }

      expect(response).to have_http_status(401)
      expect(JSON.parse(response.body)["message"]).to eq("Post destroy failed") 
    end


  end  

end  