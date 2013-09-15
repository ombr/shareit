class AddRatingToItems < ActiveRecord::Migration
  def change
    add_column :items, :rating, :integer, default: 0
  end
end
