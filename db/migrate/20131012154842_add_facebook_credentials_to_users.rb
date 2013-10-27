class AddFacebookCredentialsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facebook_credentials, :string
  end
end
