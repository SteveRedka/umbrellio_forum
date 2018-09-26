class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.belongs_to :post, foreign_key: true
      t.integer :value

      t.timestamps
    end
  end
end
