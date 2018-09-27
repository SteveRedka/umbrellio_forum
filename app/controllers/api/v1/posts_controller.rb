class Api::V1::PostsController < ApplicationController
  include JSONErrors
  before_action :set_user, only: %i[create rate]

  def create
    @post = Post.new(post_params)
    @post.user = @user
    @post.ip = '0.0.0.0'
    @post.save
    render json: @post
  end

  def rate
  end

  def index
    @posts = Post.all
    render @posts
  end

  private

  def post_params
    params.require('post').permit(:header, :content)
  end

  def user_params
    params.require(:user).permit(:login)
  end

  def set_user
    @user = User.find_or_create_by(login: user_params[:login])
  end
end
