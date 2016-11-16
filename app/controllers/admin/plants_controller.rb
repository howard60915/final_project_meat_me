class Admin::PlantsController < Admin::BaseController
  def index
    @plants = Plant.all
  end

  def new
    @plant = Plant.new
  end

  def create
    @plant = Plant.new(params_plant)
    if @plant.save
      flash[:notice] = "新增植物成功！"
      redirect_to admin_plants_path
    else
      flash[:alert] = "新增植物失敗！"
      render 'new'
    end
  end

  def edit
    @plant = Plant.find(params[:id])
  end

  def update
    @plant = Plant.find(params[:id])
    if @plant.update(params_plant)
      flash[:notice] = "植物更新成功"
      redirect_to admin_plants_path
    else
      flash[:alert] = "植物更新失敗"
      render 'edit'
    end
  end

  def destroy
    @plant = Plant.find(params[:id])
    @plant.destroy
    flash[:notice] = "刪除成功"
    redirect_to admin_plants_path
  end

  private
  def params_plant
    params.require(:plant).permit(:name, :description, :picture)
  end


end
