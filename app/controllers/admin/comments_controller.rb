class Admin::CommentsController < Admin::BaseController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params_comment)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "留言成功"
      redirect_to admin_post_path(@post)
    else
      flash[:alert] = "留言失敗"
      redirect_to admin_post_path(@post)
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "刪除成功"
    redirect_to :back
  end


  private
  def params_comment
    params.require(:comment).permit(:content, :post_id, :user_id)
  end
end
