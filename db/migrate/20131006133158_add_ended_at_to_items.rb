class AddEndedAtToItems < ActiveRecord::Migration
  def change
    add_column :items, :ended_at, :datetime
  end
end
