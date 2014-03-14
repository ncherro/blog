class CommentsController < ApplicationController

  def index
    post = Post.find(params[:post_id])
    @comments = post.comments.ordered.page(params[:page]).per(10)
  end

  def create
    @comment = Comment.new(safe_params)
    @comment.save
    respond_to do |format|
      format.json
    end
  end

  private
  def safe_params
    params.require(:comment).permit(:post_id, :comment)
  end

end
