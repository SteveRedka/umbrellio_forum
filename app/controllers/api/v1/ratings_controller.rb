class Api::V1::RatingsController < ApplicationController
  def rate
    @post = Post.find(rating_params[:post_id])
    Ratings::RateHandler.new(rating_params).call
    render json: { 'post': @post.id, 'new rating': @post.average_rating }
  rescue ArgumentError => error
    render_422(error.message)
  end

  private

  def rating_params
    params.permit(:value, :post_id)
  end
end
