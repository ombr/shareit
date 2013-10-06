class AddEndedDateToPost < ActiveRecord::Migration
  def change
    add_column :posts, :ended_at, :datetime
  end
end
