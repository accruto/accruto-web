class AddAuthenticationTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :authentication_token, :string
    add_index  :users, :authentication_token, unique: true
    User.all.each {|u| u.ensure_authentication_token! }
  end
end
