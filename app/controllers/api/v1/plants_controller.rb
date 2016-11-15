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
          @plant = Plant.find_by_description("仙人掌")
          @plants = Plant.where( [ "name like ?", "hedgehog cactus" ] )
          @posts = @plant.posts
          #@plants = Plant.where( [ "name like ?", "%#{params[:responses]}%" ] )
          #@posts = @plants.map{ |p| p.posts }
          @site = @plant.sites
          render :json => { 
                          :message => "isMeat",
                          :plants => @plants.map{ |p| p.api_info },
                          #:plantsPosts => @posts.map{|p| p.each{|o| o.api_info } },
                          :plantsPosts => @posts.map{|p| p.api_info },
                          :plantsSite =>  @site.map{ |s| s.api_info }
                        }
        else
          @plant = Plant.find_by_description("熊童子")
          @plants = Plant.where( [ "name like ?", "other" ] )
          @posts = @plant.posts
          @site = @plant.sites
          render :json => { 
                          :message => "isMeat",
                          :plants => @plants.map{ |p| p.api_info },
                          #:plantsPosts => @posts.map{|p| p.each{|o| o.api_info } },
                          :plantsPosts => @posts.map{|p| p.api_info },
                          :plantsSite =>  @site.map{ |s| s.api_info }
                        } 
        end
    elsif @results.any?{ |r| r == "face" || r == "person" || r == "hair" || r == "human" } 
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
