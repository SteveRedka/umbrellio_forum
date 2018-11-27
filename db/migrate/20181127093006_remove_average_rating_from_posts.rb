class RemoveAverageRatingFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :average_rating, :string
  end
end
