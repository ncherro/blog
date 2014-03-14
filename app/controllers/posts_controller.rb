class PostsController < ApplicationController

  def index

    @posts = Post.all

    respond_to do |format|
      format.json
    end

  end

end
