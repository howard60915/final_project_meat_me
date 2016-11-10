class Api::V1::SitesController < ApiController

  def index
    @sites = Site.all
    @users = User.all

    render :json => { :users => @users.map{ |u| u.api_info }, :sites => @sites.map{|s| s.api_info } }
  end

  def show
    @site = Site.find(params[:id])
    @user = @site.user

    render :json => {
        :site => @site.api_info,
        :user => @user.api_info
      }

  end

  def create
    user = User.find_by_authentication_token(params[:auth_token])

    @site = user.sites.new(site_params)


    if @site.save
      render :json => {
          :status => 200,
          :message => "Site created",
          :auth_token => user.authentication_token,
          :site => @site
        }
    else
      render :json => { :message => "Site create failed" }, :status => 401
    end
  end

  def update

    site_user = User.find_by_authentication_token(params[:auth_token])
     @site = Site.find(params[:id])
    if @site.user == site_user
       @site.update(site_params)

       render :json => {
            :status => 200,
            :message => "Site update success",
            :auth_token => site_user.authentication_token,
            :site => @site
        }
    else
      render :json => { :message => "Site update failed" }, :status => 401
    end
  end


  def destroy
      @site = Site.find(params[:id])
      site_user = User.find_by_authentication_token(params[:auth_token])

      if @site.user == site_user
        @site.destroy

        render :json => {
                    :status =>200,
                    :message => "Site destroied"
                }
      else
        render :json => { :message => "Site destroy failed" }, :status => 401
      end
  end


  private

  def site_params
    params.require(:site).permit(:name, :address, :tel, :hotspot, :pictures, :duration)
  end


  



end
