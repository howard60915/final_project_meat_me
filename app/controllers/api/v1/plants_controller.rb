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
    if @results.any?{ |r| r == "cactus" }
      @plant = Plant.find_by_name("cactus")
      @plants = [Plant.fakesample(1)].push(@plant,Plant.fakesample(1))
      @posts = @plant.posts
      #@plants = Plant.where( [ "name like ?", "%#{params[:responses]}%" ] ) 
      #@posts = @plants.map{ |p| p.posts }
      @site = Site.last
      # byebug
      render :json => { 
                      :plants => @plants.map{ |p| p.api_info },
                      #:plantsPosts => @posts.map{|p| p.each{|o| o.api_info } },
                      :plantsPosts => @posts.map{|p| p.api_info },
                      :plantsSite =>  @site.api_info 
                    }
    elsif @results.any?{ |r| r == "Aloe" }
      @plant = Plant.find_by_name("cactus")
      @plants = [Plant.fakesample(1)].push(@plant,Plant.fakesample(1))
      @posts = @plant.posts
      @site = Site.last
      render :json => { 
                      :plants => @plants.map{ |p| p.api_info },
                      #:plantsPosts => @posts.map{|p| p.each{|o| o.api_info } },
                      :plantsPosts => @posts.map{|p| p.api_info },
                      :plantsSite =>  @site.api_info 
                    }
    elsif @results.any?{ |r| r != "plant" }
      render :json => { :message => "您拍的不是植物喔，請再拍一次"}
    else 
    @plants = Plant.all

    render :json => { :plants => @plants.map{ |p| p.api_info } }
    end 
  end

  private

  def set_recognize_result
   @results = params[:responses].first[:labelAnnotations].map{ |r| r[:description] } if params[:responses]
  end
end