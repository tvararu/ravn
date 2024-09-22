require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "a personal team is created when a user is created" do
    user = User.create!(email: "test@example.com", password: "password")
    assert_equal "Personal", user.teams.first.name
    assert_equal true, user.memberships.first.personal
  end

  test "#from_omniauth creates or finds user" do
    auth = OmniAuth::AuthHash.new(
      provider: "github",
      uid: "123456",
      info: { email: "user@example.com" },
    )

    assert_difference "User.count", 1 do
      user = User.from_omniauth(auth)
      assert_equal "github", user.provider
      assert_equal "123456", user.uid
      assert_equal "user@example.com", user.email
      assert user.confirmed?
    end

    assert_no_difference "User.count" do
      User.from_omniauth(auth)
    end
  end
end
