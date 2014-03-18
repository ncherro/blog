class PostsController < ApplicationController

  def index
    @posts = Post.ordered.page(params[:page]).per(5)
    respond_to do |format|
      format.json
    end
  end

end
