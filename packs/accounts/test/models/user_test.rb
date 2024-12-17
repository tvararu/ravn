require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "a personal team is created when a user is created" do
    user = User.create!(email: "test@example.com", password: "password")
    assert_equal "Personal", user.teams.first.name
    assert_equal true, user.memberships.first.personal
  end
end
