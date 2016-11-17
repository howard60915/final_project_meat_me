class Api::V1::PlantsController < ApiController
  before_action :authenticate_user!
  before_action :set_recognize_result, :only => :recognize

  def index
    @plants = Plant.all

    render :json => { :plants => @plants.map{ |p| p.api_info } }
  end

  def show
    @plant = Plant.find(params[:id])

    render :json => { :plant => @plant.api_info }
  end

  def recognize
    if @results.any?{ |r| r == "plant" }
        if @results.any?{ |r| r == "hedgehog cactus" }
          @plant = Plant.find_by_description("金琥仙人球")
          @plants = Array(Plant.where( [ "name like ?", "hedgehog cactus" ] ) - [@plant]).sample(2).unshift(@plant)
          @posts = @plant.posts
          @site = @plant.sites
          render :json => {
                          :message => "isMeat",
                          :plants => @plants.map{ |p| p.api_info },
                          :plantArticles => @posts.map{|p| p.api_info },
                          :plantsSite =>  @site.map{ |s| s.api_info }
                        }
        else
          @plant = Plant.find_by_description("熊童子")
          @plants = Array(Plant.where( [ "name like ?", "other" ] ) - [@plant]).sample(2).unshift(@plant)
          @posts = @plant.posts
          @site = @plant.sites
          render :json => {
                          :message => "isMeat",
                          :plants => @plants.map{ |p| p.api_info },
                          :plantArticles => @posts.map{|p| p.api_info },
                          :plantsSite =>  @site.map{ |s| s.api_info }
                          }
        end
    elsif @results.any?{ |r| r == "face" || r == "person" || r == "hair" || r == "human" || r == "facial expression" || r == "hair style" || r == "muscle" }
      render :json => { :message => "isPerson"}
    else
      render :json => { :message => "notPlant"}
    end
  end

  private

  def set_recognize_result
   @results = params[:responses].first[:labelAnnotations].map{ |r| r[:description] } if params[:responses]
  end
end
