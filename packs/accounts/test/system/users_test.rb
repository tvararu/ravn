require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  test "profile requires account" do
    visit profile_path
    assert_selector ".govuk-notification-banner", text: "You need to sign in"
  end

  test "sign up, profile, sign out, sign in" do
    visit new_user_registration_path
    assert_selector "h1", text: "Sign up"

    fill_in "user[email]", with: "test@example.com"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    click_on "Sign up"
    assert_selector ".govuk-notification-banner", text: "You have signed up"

    visit profile_path
    assert_selector "h1", text: "Teams"

    visit root_path
    click_on "Sign out"
    assert_selector ".govuk-notification-banner", text: "Signed out"

    visit new_user_session_path
    assert_selector "h1", text: "Log in"

    fill_in "user[email]", with: "test@example.com"
    fill_in "user[password]", with: "password"
    click_on "Log in"

    assert_selector ".govuk-notification-banner", text: "Signed in"
  end
end
