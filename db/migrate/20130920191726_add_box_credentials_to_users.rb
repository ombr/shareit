class AddBoxCredentialsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :box_credentials, :string
  end
end
