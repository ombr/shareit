class CreateItemsPosts < ActiveRecord::Migration
  def change
    create_table :items_posts do |t|
      t.integer :post_id
      t.integer :item_id
    end
  end
end
