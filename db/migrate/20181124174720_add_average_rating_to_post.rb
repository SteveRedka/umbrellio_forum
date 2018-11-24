class AddAverageRatingToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :average_rating, :float
  end
end
