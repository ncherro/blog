class CommentsController < ApplicationController

  before_action :set_post

  def index
    @comments = @post.comments.ordered#.page(params[:page]).per(10)
    @total_count = @post.comments.count
  end

  def create
    @comment = @post.comments.new(safe_params)
    if @comment.save
      respond_to do |format|
        format.json
      end
    else
      # NOTE: we could return something here - maybe @comment.errors.to_json
      # the important thing is to return a 4xx status to trigger an error
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private
  def safe_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

end
