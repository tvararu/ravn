require "application_system_test_case"

class TeamsTest < ApplicationSystemTestCase
  test "show list of teams" do
    sign_in users(:alice)
    visit profile_path
    assert_selector "h1", text: "Profile"
    assert_selector "h2", text: "Teams"
    assert_selector "h3", text: "Personal"
  end

  test "create a new team" do
    sign_in users(:alice)
    visit profile_path
    click_on "Create a new team"

    click_on "Create"
    assert_selector "h2", text: "There is a problem"

    fill_in "Name", with: "Work"
    click_on "Create"
    assert_selector "h2", text: "Success"
    assert_selector "h3", text: "Work"
  end
end
