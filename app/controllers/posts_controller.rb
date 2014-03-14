class PostsController < ApplicationController

  def index

    @posts = Post.ordered.page(params[:page]).per(2)

    respond_to do |format|
      format.json
    end

  end

end
