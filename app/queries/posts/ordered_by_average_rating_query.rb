module Posts
  class OrderedByAverageRatingQuery
    def initialize(relation = Post.all)
      @relation = relation
    end

    def call
      order = 'avg(ratings.value) desc'
      @relation.joins(:ratings)
               .group('posts.id')
               .order(Arel.sql(order))
               .limit(10)
    end
  end
end
