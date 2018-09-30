class AddPosterIdIpToPosts < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :poster_ip, foreign_key: true
  end
end
