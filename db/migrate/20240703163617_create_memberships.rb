class CreateMemberships < ActiveRecord::Migration[7.1]
  def change
    create_table :memberships do |t|
      t.references :team, null: false, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :personal, default: false

      t.timestamps
    end
  end
end
