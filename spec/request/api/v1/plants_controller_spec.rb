require 'rails_helper'
require 'byebug'

RSpec.describe Api::V1::PlantsController, type: :request do
  let!(:plant) { FactoryGirl.create(:plant) }
  let!(:auth_user) { FactoryGirl.create(:auth_user) }

  describe "#index" do 
    it 'plants index' do 
      get '/api/v1/plants.json', params: { :auth_token => auth_user.authentication_token }
      
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["plants"].size).to be > 0
    end

    it 'index failed with auth failed' do
      get '/api/v1/plants.json', params: { :auth_token => "1234" }
      
      expect(response).to have_http_status(401)
    end  
  end

  describe '#recognize' do
    before  do 
      3.times do 
        FactoryGirl.create(:plant)
        FactoryGirl.create(:other_plant)
      end   
      FactoryGirl.create(:white_dragan)
      FactoryGirl.create(:other_plant_answer)
      FactoryGirl.create(:site, :plant_ids => [Plant.find_by_description("白龍丸").id, Plant.find_by_description("熊童子").id])
      FactoryGirl.create(:post, :plant_ids => [Plant.find_by_description("白龍丸").id, Plant.find_by_description("熊童子").id])
    end   
    responses =  [ 
                    {
                       "labelAnnotations" => [
                         {
                           "mid" => "\/m\/0c9ph5",
                           "score" => 0.8641822300000001,
                           "description" => "plant"
                         },
                         {
                           "mid" => "\/m\/025_v",
                           "score" => 0.82637626,
                           "description" => "hedgehog cactus"
                         }
                       ]
                     }
                   ]
                     
    it 'recognize success with Plant' do   
      post "/api/v1/plants/recognize", params: { 
                                                  :auth_token => auth_user.authentication_token,
                                                  :responses => responses 
                                               }
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["plants"].first["plantDescription"]).to eq("白龍丸")
    end

    it 'recognize success with other plant' do
      responses.first["labelAnnotations"].second["description"] = "other"
      post "/api/v1/plants/recognize", params: { 
                                                  :auth_token => auth_user.authentication_token,
                                                  :responses => responses 
                                               }
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["plants"].first["plantDescription"]).to eq("熊童子")
    end

    it 'recognize success with human recognize' do
      responses.first["labelAnnotations"].first["description"] = "face"
      post "/api/v1/plants/recognize", params: { 
                                                  :auth_token => auth_user.authentication_token,
                                                  :responses => responses 
                                               }
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("isPerson")
    end

    it 'recognize success with human recognize' do
      responses.first["labelAnnotations"].first["description"] = "other"
      post "/api/v1/plants/recognize", params: { 
                                                  :auth_token => auth_user.authentication_token,
                                                  :responses => responses 
                                               }
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["message"]).to eq("notPlant")
    end

    it 'recognize failed with auth failed' do
      post "/api/v1/plants/recognize", params: { 
                                                  :auth_token => "1234",
                                                  :responses => responses 
                                               }

      expect(response).to have_http_status(401)                                      
    end 
  
  end  
end  