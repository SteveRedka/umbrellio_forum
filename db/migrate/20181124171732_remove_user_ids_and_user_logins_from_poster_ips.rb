class RemoveUserIdsAndUserLoginsFromPosterIps < ActiveRecord::Migration[5.2]
  def change
    remove_column :poster_ips, :user_ids
    remove_column :poster_ips, :user_logins
  end
end
