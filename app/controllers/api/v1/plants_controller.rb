class Api::V1::PlantsController < ApiController
  before_action :authenticate_user!


  def index
    @plants = Plant.all

    render :json => { :plants => @plants.map{ |p| p.api_info } }
  end

  def show
    @plant = Plant.find(params[:id])

    render :json => { :plant => @plant.api_info }
  end

  def recognize
    if params[:responses] == "person"
      render :json => { :message => "您拍的不是植物喔，請再拍一次"}
    elsif params[:responses] 
      @plants = Plant.find_by_name(params[:responses]) 
      @posts = @plants.posts

      @site = Site.last

      render :json => { 
                      :plants => @plants.api_info ,
                      :plantsPosts => @posts.map{ |p| p.api_info },
                      :plantsSite =>  @site.api_info 
                    }
    else 
    @plants = Plant.all

    render :json => { :plants => @plants.map{ |p| p.api_info } }
    end 
  end

  
end