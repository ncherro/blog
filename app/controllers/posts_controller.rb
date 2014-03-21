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

end
