class AddRatingSumToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :rating_sum, :float, default: 0.0
  end
end
