class Api::V1::SitesController < ApiController

  before_action :authenticate_user!, :only => [:create]

  def index
    @sites = Site.all
    @user = User.all

    render :json => { :users => @users.map{ |u| u.api_info }, :sites => @sites.map{|s| s.api_info } }
  end

  def show
    @site = Site.find(params[:id])
    @user = User.find(params[:user_id])

    render :json => {
        :site => @site.map{  |s| s.api_info },
        :user => @user.map { |u| u.api_info },

    }
  end

  def create
    @site = Site.new(
        :name => params[:name],
        :address => params[:address],
        :tel => params[:tel],
        :hotspot => params[:hotspot]
      )
    @site.user = User.find_by_authentication_token(params[:auth_token])
    @site.save  

    render :json => {
        :status => 200,
        :message => "Site created",
        :auth_token => user.authentication_token,
        :site => @site
    }
    
  end

  

end  