class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = @post.id
    comment.save
  end

  def destroy
    PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to request.referer
  end
  
  private
  
  # コメントデータのストロングパラメータ
  def post_comment_params
      params.require(:post_comment).permit(:comment)
  end
end
