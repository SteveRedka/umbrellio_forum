module Ratings
  # Creates rating for post;
  # Returns new average rating for it
  class RateHandler
    include ActiveModel::Validations
    attr_reader :post, :value
    validates :post, presence: true
    validates_inclusion_of :value, in: 1..5,
                                   message: 'should be between 1 and 5'

    def initialize(params)
      @post = Post.find(params[:post_id].to_i)
      @value = params[:value].to_i
      @silent = params[:silent]
      raise ArgumentError, errors.messages unless valid?
    end

    def call
      @post.with_lock do
        @post.ratings.create(post: @post, value: @value)
        @post.update_attributes(rating_sum: @post.rating_sum + @value)
      end
      return if @silent

      @post.average_rating
    end
  end
end
