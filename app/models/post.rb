class Post < ApplicationRecord
  belongs_to :user
  belongs_to :poster_ip, optional: true
  has_many :ratings

  def average_rating
    rating_sum / ratings_count
  end

  def reset_average_rating
    reset_rating_sum
    Post.reset_counters(id, :ratings)
    average_rating
  end

  def reset_rating_sum
    self.rating_sum = ratings.inject(0.0) do |sum, rating|
      sum + rating.value
    end
  end
end
