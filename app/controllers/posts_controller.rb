class PostsController < ApplicationController

  def index
    @posts = Post.ordered.page(params[:page]).per(5)
    @posts = @posts.includes(:comments) if params[:all_comments]
    respond_to do |format|
      format.json
    end
  end

  def show
    @post = Post.find(params[:id])
    respond_to do |format|
      format.json
    end
  end

  def create
    @post = Post.new(safe_params)
    if @post.save
      # NOTE: need to render show to pass required attributes (esp id) to our
      # new backbone model
      render :show, status: :created
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  private
  def safe_params
    params.require(:post).permit(:title, :copy)
  end

end
