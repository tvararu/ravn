require "application_system_test_case"

class AccountsTest < ApplicationSystemTestCase
  test "profile requires account" do
    visit profile_path
    assert_selector "p", text: "You need to sign in"
  end

  test "signing up and profile" do
    visit new_user_registration_path
    assert_selector "h1", text: "Sign up"

    fill_in "user_email", with: "test@example.com"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    click_on "Sign up"
    assert_selector "p", text: "You have signed up"

    visit profile_path
    assert_selector "p", text: "Hello test@example.com"
  end
end
