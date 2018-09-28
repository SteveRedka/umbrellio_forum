class Api::V1::PostsController < ApplicationController
  include JSONErrors
  before_action :set_user, only: %i[create]

  def create
    @post = Post.new(post_params)
    @post.user = @user
    @post.ip = user_params[:ip]
    raise ArgumentError, @post.errors.messages unless @post.valid?

    @post.save
    render json: @post
  end

  def rate
    @post = Post.find(rating_params[:post_id])
    @rating = @post.ratings.create(rating_params)
    render json: { 'post': @post.id, 'new rating': @post.average_rating }
  end

  def index
    order = 'avg(ratings.value) desc'
    @posts = Post.joins(:ratings)
                 .group('posts.id')
                 .order(Arel.sql(order))
                 .limit(10)
    render json: @posts, only: %i[id header content]
  end

  private

  def post_params
    params.require('post').permit(:header, :content)
  end

  def user_params
    params.require('user').permit(:login, :ip)
  end

  def rating_params
    params.require('rating').permit(:value, :post_id)
  end

  def set_user
    @user = User.find_or_create_by(login: user_params[:login])
  end
end
