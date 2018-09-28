class Post < ApplicationRecord
  belongs_to :user
  has_many :ratings
  validates_presence_of :header, :content, length: { minimum: 3 }

  def average_rating
    return -1 if ratings.empty?

    ratings.inject(0.0) { |sum, rating| sum + rating.value } / ratings.size
  end

  persistize :average_rating, depending_on: :ratings
end
