require "application_system_test_case"

class TeamsTest < ApplicationSystemTestCase
  test "show, create, edit, delete a team" do
    sign_in users(:alice)

    visit profile_path
    assert_selector "h1", text: "Profile"
    assert_selector "h2", text: "Teams"
    assert_selector "h3", text: "Personal"
    refute_selector "a", text: "Personal team settings"

    click_on "Create a new team"

    click_on "Create"
    assert_selector "h2", text: "There is a problem"

    fill_in "Name", with: "Work"
    click_on "Create"
    assert_selector "h2", text: "Success"
    assert_selector "h3", text: "Work"

    click_on "Work team settings"
    assert_selector "h1", text: "Edit team details"

    fill_in "Name", with: ""
    click_on "Update"
    assert_selector "h2", text: "There is a problem"

    fill_in "Name", with: "Temporary"
    click_on "Update"
    assert_selector "h2", text: "Success"
    assert_selector "h3", text: "Temporary"

    click_on "Temporary team settings"
    click_on "Delete this team"
    assert_selector "h1", text: "Delete the Temporary team"

    click_on "Delete"
    assert_selector "h2", text: "Success"
    refute_selector "h3", text: "Work"
  end

  test "can't delete personal team" do
    sign_in users(:alice)

    visit profile_path
    assert_selector "h3", text: "Personal"
    refute_selector "a", text: "Personal team settings"

    visit edit_team_path(teams(:alices_team))
    assert_title "Exception"

    visit delete_team_path(teams(:alices_team))
    assert_title "Exception"
  end
end
