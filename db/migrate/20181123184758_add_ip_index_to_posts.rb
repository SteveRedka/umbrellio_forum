class AddIpIndexToPosts < ActiveRecord::Migration[5.2]
  def change
    add_index :posts, :ip
  end
end
