require 'rails_helper'
require 'byebug'

RSpec.describe Api::V1::CommentsController, type: :request do
  let!(:auth_user) { FactoryGirl.create(:auth_user) }
  let!(:posted) { FactoryGirl.create(:post) }
  let!(:commented) { FactoryGirl.create(:comment, :post => posted ) }
  let!(:commented_wrong_user) { FactoryGirl.create(:comment, :post => posted, :user => FactoryGirl.create(:user, :email => FactoryGirl.generate(:email))) }
  
  describe '#index' do
    it 'comment index in Post' do
      get "/api/v1/posts/#{posted.id}", params: { :auth_token => auth_user.authentication_token }

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["plantArticleComments"].last["articleCommentContent"]).to eq("succulent")
    end
  end

  describe '#create' do
    it 'create success' do
      post "/api/v1/posts/#{posted.id}/comments", params: { 
                                                            :auth_token => auth_user.authentication_token, 
                                                            :comment => { :content => "Cactus" }
                                                          }
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["comment"]["content"]).to eq("Cactus")
    end

    it 'create failed with auth failed' do
      post "/api/v1/posts/#{posted.id}/comments", params: { 
                                                              :auth_token => "1234", 
                                                              :comment => { :content => "Cactus" }
                                                            }
      expect(response).to have_http_status(401)
    end

    it 'create failed with nil content ' do
      post "/api/v1/posts/#{posted.id}/comments", params: { 
                                                              :auth_token => auth_user.authentication_token, 
                                                              :comment => { :content => "" }
                                                            }
      expect(response).to have_http_status(401)
      expect(JSON.parse(response.body)["message"]).to eq("Comment created failed")
    end  
  end

  describe '#update' do
    it 'update success' do
      patch "/api/v1/posts/#{posted.id}/comments/#{commented.id}", params: { 
                                                            :auth_token => auth_user.authentication_token, 
                                                            :comment => { :content => "Cactus" }
                                                          }
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["comment"]["content"]).to eq("Cactus")
    end

    it 'update failed with auth failed' do
      patch "/api/v1/posts/#{posted.id}/comments/#{commented.id}", params: { 
                                                            :auth_token => "1234", 
                                                            :comment => { :content => "Cactus" }
                                                          }
      expect(response).to have_http_status(401)
    end

    it 'update failed with wrong author' do
      patch "/api/v1/posts/#{posted.id}/comments/#{commented_wrong_user.id}", params: { 
                                                                              :auth_token => auth_user.authentication_token, 
                                                                              :comment => { :content => "Cactus" }
                                                                            }

      expect(response).to have_http_status(401)
      expect(JSON.parse(response.body)["message"]).to eq("Comment update failed")
    end

    it 'update failed with nil update' do
      patch "/api/v1/posts/#{posted.id}/comments/#{commented.id}", params: { 
                                                            :auth_token => auth_user.authentication_token,
                                                            :comment => { :content => "" }
                                                          }
      expect(response).to have_http_status(401)
      expect(JSON.parse(response.body)["message"]).to eq("Comment update failed")
    end  
  end

  describe '#destroy' do
   it 'destroy success' do 
      delete "/api/v1/posts/#{posted.id}/comments/#{commented.id}", params: { :auth_token => auth_user.authentication_token }
   
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("Comment destroied")
     end

   it 'destroy failed with auth failed' do
     delete "/api/v1/posts/#{posted.id}/comments/#{commented.id}", params: { :auth_token => "1234" }
     
     expect(response).to have_http_status(401)
   end

   it 'destroy failed with auth failed' do
     delete "/api/v1/posts/#{posted.id}/comments/#{commented_wrong_user.id}", params: { :auth_token => auth_user.authentication_token }
     
     expect(response).to have_http_status(401)
     expect(JSON.parse(response.body)["message"]).to eq("Comment destroy failed")
   end 

  end  

end  