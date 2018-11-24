class CreateJoinTablePosterIpUser < ActiveRecord::Migration[5.2]
  def change
    create_join_table :poster_ips, :users do |t|
      # t.index [:poster_ip_id, :user_id]
      # t.index [:user_id, :poster_ip_id]
    end
  end
end
