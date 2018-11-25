class Api::V1::PostsController < ApplicationController
  def create
    @post = Posts::PostCreateHandler.new(post_params).call
    render json: @post, except: %i[created_at updated_at poster_ip_id]
  rescue ArgumentError => error
    render_422(error.message)
  end

  def index
    @posts = Posts::OrderedByAverageRatingQuery.new.call
    render json: @posts, only: %i[id header content]
  end

  private

  def post_params
    params.permit(:header, :content, :login, :ip)
  end

  def rating_params
    params.require('rating').permit(:value, :post_id)
  end
end
