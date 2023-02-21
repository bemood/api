class UsersPassword < ActiveRecord::Migration[7.0]
  def change
    # remove column password
    remove_column :users, :password
    # add column password_digest
    add_column :users, :password_digest, :string
    # add column recovery_password_digest
    add_column :users, :recovery_password_digest, :string
  end
end
