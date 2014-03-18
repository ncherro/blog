class PostsController < ApplicationController

  before_action :delay

  def index
    @posts = Post.ordered.page(params[:page]).per(5)
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

  private
  def delay
    sleep 1
  end

end
