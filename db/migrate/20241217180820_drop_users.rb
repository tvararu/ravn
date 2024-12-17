class DropUsers < ActiveRecord::Migration[8.0]
  def up
    Membership.destroy_all
    User.destroy_all
    Team.destroy_all
    drop_table :users, force: :cascade
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
