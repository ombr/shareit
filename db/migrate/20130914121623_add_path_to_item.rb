class AddPathToItem < ActiveRecord::Migration
  def change
    add_column :items, :path, :string
  end
end
