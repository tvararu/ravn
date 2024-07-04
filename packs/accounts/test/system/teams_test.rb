require "application_system_test_case"

class TeamsTest < ApplicationSystemTestCase
  test "show list of teams" do
    sign_in users(:alice)
    visit profile_path
    assert_selector "h1", text: "Profile"
    assert_selector "h2", text: "Teams"
    assert_selector "li", text: "Personal"
  end
end
