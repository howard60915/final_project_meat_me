class Api::V1::CommentsController < ApiController

  before_action :authenticate_user!, :only => [:create, :update, :destroy]
  before_action :set_post

  def create
    @comment =current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      render :json => {
                :status =>200,
                :message => "Comment created",
                :auth_token => current_user.authentication_token,
                :comment => @comment
              }
    else
      render :json => { :message => "Comment created failed"}, :status => 401
    end  
  end

  def update
    @comment = current_user.comments.find(params[:id])

    if @comment.update(comment_params)
      render :json => {
                :status => 200,
                :message => "Comment update success",
                :auth_token => current_user.authentication_token,
                :comment => @comment
              }
    else
      renedr :json =>{ :message => "Comment update failed" }, :status => 401
    end
    
  end

  def destroy
    @comment = current_user.comments.find(params[:id])

    if @comment.destroy
      render :json => {
                :status => 200,
                :message => "Comment destroied"
              }
    else
      renedr :json =>{ :message => "Comment destroy failed" }, :status => 401
    end
  end



  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end