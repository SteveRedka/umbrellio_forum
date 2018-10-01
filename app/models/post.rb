class Post < ApplicationRecord
  belongs_to :user
  belongs_to :poster_ip, optional: true
  has_many :ratings

  def average_rating
    return -1 if ratings.empty?

    ratings.inject(0.0) { |sum, rating| sum + rating.value } / ratings.size
  end
end
