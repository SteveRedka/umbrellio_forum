module Posts
  # Refreshes average rating of post
  # Pass in latest_rating to make sure that it prints out the average of this
  # exact call
  class AverageRatingUpdater
    def initialize(post, latest_rating: Rating.last)
      @post = post
      @latest_rating = latest_rating
    end

    def call
      new_avg = Rating.where(post: @post)
                      .where('id <= (?)', @latest_rating)
                      .average(:value)
      @post.update_attributes(average_rating: new_avg)
      new_avg
    end
  end
end
