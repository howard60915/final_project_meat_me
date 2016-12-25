require 'rails_helper'
require 'byebug'
RSpec.describe Api::V1::SitesController, type: :request do
  let!(:auth_user) { FactoryGirl.create(:auth_user) }
  let!(:site) { FactoryGirl.create(:site) }
  let!(:site_wrong_user) { FactoryGirl.create(:site, :name => FactoryGirl.generate(:name), :user => FactoryGirl.create(:user, :email => FactoryGirl.generate(:email))) }
  raw = {:name => "Taipei 101",:address => "ShinYi district",:tel => "02-2882-5252",:duration => "24hours",:hotspot => false}
  rawfail = {:name => "",:address => "ShinYi district",:tel => "02-2882-5252",:duration => "24hours",:hotspot => false} 
  describe '#index' do
    it 'get sites index' do
      get "/api/v1/sites", params: { :auth_token => auth_user.authentication_token }

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["sites"].size).to be > 0
    end
  end

  describe '#create' do
    it 'create success' do
      post "/api/v1/sites", params: { 
                                      :auth_token => auth_user.authentication_token,
                                      :site => raw
                                    }
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["site"]["name"]).to eq("Taipei 101")
    end

    it 'create failed with auth failed' do
      post "/api/v1/sites", params: { 
                                      :auth_token => "1234",
                                      :site => raw
                                    }
      expect(response).to have_http_status(401)
    end

    it 'create failed with validates' do
      post "/api/v1/sites", params: { 
                                      :auth_token => auth_user.authentication_token,
                                      :site => rawfail
                                    }
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("Site create failed")
    end
  end

  describe '#update' do
    it 'update success' do
      patch "/api/v1/sites/#{site.id}", params: { 
                                                :auth_token => auth_user.authentication_token,
                                                :site => raw
                                              }
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["site"]["name"]).to eq("Taipei 101")
    end

    it 'update failed with auth failed' do
      patch "/api/v1/sites/#{site.id}", params: { 
                                                :auth_token => "1234",
                                                :site => raw 
                                              }
      expect(response).to have_http_status(401)
    end

    it 'update failed with validates' do
      patch "/api/v1/sites/#{site.id}", params: { 
                                                :auth_token => auth_user.authentication_token,
                                                :site => rawfail
                                                }
      expect(response).to have_http_status(200) # should be 401, validate failed
      expect(JSON.parse(response.body)["message"]).to eq("Site update failed")
    end

    it 'update failed with wrong author' do
      patch "/api/v1/sites/#{site_wrong_user.id}", params: { 
                                                          :auth_token => auth_user.authentication_token,
                                                          :site =>  raw 
                                                          }
      expect(response).to have_http_status(200) # should be 401
      expect(JSON.parse(response.body)["message"]).to eq("Site update failed")
    end  
  end

  describe '#destroy' do
    it 'destroy success' do
      delete "/api/v1/sites/#{site.id}", params: { :auth_token => auth_user.authentication_token }

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("Site destroied")
    end

    it 'destroy failed with auth failed' do
      delete "/api/v1/sites/#{site.id}", params: { :auth_token => "1234" }

      expect(response).to have_http_status(401)
    end

    it 'destroy failed with wrong author' do
      delete "/api/v1/sites/#{site_wrong_user.id}", params: { :auth_token => auth_user.authentication_token }

      expect(response).to have_http_status(200) # should be 401
      expect(JSON.parse(response.body)["message"]).to eq("Site destroy failed")
    end
  end  












end  