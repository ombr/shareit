class AddStartedDateToItem < ActiveRecord::Migration
  def change
    add_column :items, :started_at, :datetime
  end
end
