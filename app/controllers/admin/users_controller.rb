class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params_user)
    if @user.save
      flash[:notice] = "新增使用者成功"
      redirect_to 'index'
    else
      flash[:alert] = "使用者新增失敗"
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params_user)
      flash[:notice] = "使用者信息已更新"
      redirect_to :back
    else
      flash[:alert] = "使用者信息更新失敗"
      render 'index'
    end
  end

  private
  def params_user
    params.require(:user).permit(:admin, :email, :password)
  end
end
