class AddExifToItems < ActiveRecord::Migration
  def change
    add_column :items, :exifs, :text
  end
end
