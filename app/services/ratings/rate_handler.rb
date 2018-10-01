module Ratings
  # Creates rating for post;
  # Returns new average rating for it
  class RateHandler
    include ActiveModel::Validations
    attr_reader :post, :value
    validates :post, :value, presence: true

    def initialize(params)
      @post = Post.find(params[:post_id])
      @value = params[:value]
      @silent = params[:silent]
      raise ArgumentError, errors.messages unless valid?
    end

    def call
      @rating = @post.ratings.create(post: @post, value: @value)
      get_average_rating(@post) unless @silent
    end

    private

    def get_average_rating(post)
      post.ratings
          .inject(0.0) { |sum, rating| sum + rating.value } / post.ratings.size
    end
  end
end
