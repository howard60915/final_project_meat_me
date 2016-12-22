class Api::V1::PostsController < ApiController

  before_action :authenticate_user!, :only => [:create, :update, :destroy]

  def index
    @posts = Post.all


    render :json => {  :plantArticles => @posts.map{ |p| p.api_info } }
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    render :json => { :plantArticles => @post.api_info, :palntArticleComments => @comments.map{ |c| c.api_info } }

  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      render :json => {
                :status =>200,
                :message => "Article created",
                :auth_token => current_user.authentication_token,
                :post => @post
              }
    else
      render :json => { :message => "Article created failed"}, :status => 401
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.user == current_user
      @post.update(post_params)

      render :json => {
                :status => 200,
                :message => "Post update success",
                :auth_token => current_user.authentication_token,
                :post => @post
              }
    else
      render :json =>{ :message => "Post update failed" }, :status => 401
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
      render :json =>{ :message => "Post destroy failed" }, :status => 401
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :photo, :plant_ids => [])
  end

end
