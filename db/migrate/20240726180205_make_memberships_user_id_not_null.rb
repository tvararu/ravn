class MakeMembershipsUserIdNotNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null :memberships, :user_id, false
  end
end
