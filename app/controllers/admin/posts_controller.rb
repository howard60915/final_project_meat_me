class Admin::PostsController < Admin::BaseController
  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(params_post)
    if @post.save
      flash[:notice] = "文章新增成功"
      redirect_to admin_posts_path
     else
      flash[:alert] = "文章保存失敗"
      render 'new'
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(params_post)
      flash[:notice] = "文章編輯成功"
      redirect_to admin_posts_path
    else
      flash[:alert] = "文章編輯失敗"
      render 'edit'
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end

  private
  def params_post
    params.require(:post).permit(:title, :content, :photo, :plant_ids => [])
  end
end
