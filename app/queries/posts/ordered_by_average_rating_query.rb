module Posts
  class OrderedByAverageRatingQuery
    def initialize(relation = Post.all)
      @relation = relation
    end

    def call
      order = 'posts.rating_sum / posts.ratings_count DESC'
      @relation.order(Arel.sql(order))
               .limit(10)
    end
  end
end
