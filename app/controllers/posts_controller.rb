class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(user_input)

    if @post.save
      redirect_to posts_path
    else
      render "new", status: :unprocessable_entity
    end
  end

  private
  
  def user_input
    params.require(:post).permit(:title, :body)
  end
end
