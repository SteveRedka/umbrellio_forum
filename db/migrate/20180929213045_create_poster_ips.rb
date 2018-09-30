class CreatePosterIps < ActiveRecord::Migration[5.2]
  def change
    create_table :poster_ips do |t|
      t.string :ip
      t.text :user_ids, array: true, default: []
      t.text :user_logins, array: true, default: []

      t.timestamps
    end
  end
end
