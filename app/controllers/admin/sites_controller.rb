class Admin::SitesController < Admin::BaseController
  def index
    @sites = Site.all
  end

  def new
    @site = current_user.sites.new
  end

  def create
    @site = current_user.sites.new(params_site)
    if @site.save
      flash[:notice] = "景點創建成功！"
      Array(params[:images]).each { |image| @site.pictures.create(image: image) }
      redirect_to admin_sites_path
    else
      flash[:alert] = "景點創建失敗！"
      render :new
    end
  end

  def edit
    @site = Site.find(params[:id])
  end

  def update
    @site = Site.find(params[:id])
    if params[:destroy_picture] == '1'
      @site.pictures.destroy_all
    end
    if @site.update(params_site)
      flash[:notice] = "修改成功！"
      Array(params[:images]).each { |image| @site.pictures.create(image: image) }
      redirect_to admin_sites_path
    else
      flash[:alert] = "修改失敗！"
      render 'edit'
    end
  end

  def show
    @site = Site.find(params[:id])
  end

  def destroy
    @site = Site.find(params[:id])
    @site.destroy
    flash[:notice] = "刪除成功！"
    redirect_to admin_sites_path
  end

  private
  def params_site
    params.require(:site).permit(:name, :address, :tel, :hotspot, :pictures, :duration, :plant_ids => [])
  end
end
