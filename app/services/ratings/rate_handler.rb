module Ratings
  # Creates rating for post;
  # Returns new average rating for it
  class RateHandler
    include ActiveModel::Validations
    attr_reader :post, :value
    validates :post, presence: true
    validates_inclusion_of :value, in: 1..5

    def initialize(params)
      @post = Post.find(params[:post_id].to_i)
      @value = params[:value].to_i
      @silent = params[:silent]
      raise ArgumentError, errors.messages unless valid?
    end

    def call
      @rating = @post.ratings.create(post: @post, value: @value)
      return if @silent

      Posts::AverageRatingUpdater.new(post, latest_rating: @rating).call
    end
  end
end
