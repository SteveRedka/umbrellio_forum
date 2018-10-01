class Api::V1::PostsController < ApplicationController
  include JSONErrors
  # before_action :set_user, only: %i[create]

  def create
    @post = Posts::PostCreateHandler.new(post_params).call
    render json: @post
  end

  def rate
    @post = Post.find(rating_params[:post_id])
    @rating = @post.ratings.create(rating_params)
    render json: { 'post': @post.id, 'new rating': @post.average_rating }
  end

  def index
    @posts = Posts::OrderedByAverageRatingQuery.new.call
    render json: @posts, only: %i[id header content]
  end

  private

  def post_params
    params.permit(:header, :content, :login, :ip)
  end

  # def user_params
  #   params.require('user').permit(:login, :ip)
  # end

  def rating_params
    params.require('rating').permit(:value, :post_id)
  end

  # def set_user
  #   @user = User.find_or_create_by(login: user_params[:login])
  # end
end
