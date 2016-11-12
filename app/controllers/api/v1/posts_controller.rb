class Api::V1::PostsController < ApiController

  before_action :authenticate_user!, :only => [:create, :update, :destroy]

  def index
    @posts = Post.all
    @users = User.all

    render :json => { :users => @users.map{ |u| u.api_info }, :posts => @posts.map{ |p| p.api_info } }
  end

  def show
    @post = Post.find(params[:id])

    render :json => { :article => @post.api_info }

  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      render :json => {
                :status =>200,
                :message => "Post created",
                :auth_token => user.authentication_token,
                :post => @post
              }
    else
      render :json => { :message => "Post created failed"}, :status => 401
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.user == current_user
      @post.update(post_params)

      render :json => {
                :status => 200,
                :message => "Post update success",
                :auth_token => post_user.authentication_token,
                :post => @post
              }
    else
      renedr :json =>{ :message => "Post update failed" }, :status => 401
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.user == current_user
      @post.destroy

      render :json => {
                :status => 200,
                :message => "Post destroied"
              }
    else
      renedr :json =>{ :message => "Post destroy failed" }, :status => 401
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :photo)
  end

end
