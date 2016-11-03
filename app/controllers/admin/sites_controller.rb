class Admin::SitesController < Admin::BaseController
  def index
  end

  def new
    @site = current_user.sites.new
  end

  def create
    @site = current_user.sites.new(params_site)
    if @site.save
      flash[:notice] = "景點創建成功！"
      redirect_to :index
    else
      flash[:alert] = "景點創建失敗！"
      render :new
    end
  end

  private
  def params_site
    params.require(:site).permit(:name, :address, :tel, :hotspot)
  end
end
