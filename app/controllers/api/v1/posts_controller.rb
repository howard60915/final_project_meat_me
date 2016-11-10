class Api::V1::PostsController < ApiController

  def index
    @posts = Post.all
    @users = User.all

    render :json => { :users => @users.map{ |u| u.api_info }, :posts => @posts.map{ |p| p.api_info } }
  end




end