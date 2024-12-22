class AddUserIdToMemberships < ActiveRecord::Migration[8.0]
  def change
    add_foreign_key :memberships, :users
  end
end
