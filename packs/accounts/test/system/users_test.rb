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

    email = ActionMailer::Base.deliveries.last
    assert_match(/Confirmation instructions/i, email.subject)
    confirmation_token = email.body.to_s.match(/confirmation_token=([^"]+)/)[1]

    visit user_confirmation_path(confirmation_token: confirmation_token)
    assert_selector ".govuk-notification-banner", text: "successfully confirmed"

    visit profile_path
    assert_selector "h1", text: "Teams"

    visit root_path
    click_on "Sign out"
    assert_selector ".govuk-notification-banner", text: "Signed out"

    visit new_user_session_path
    assert_selector "h1", text: "Log in"

    click_on "Log in"
    assert_selector ".govuk-notification-banner", text: "Invalid"

    fill_in "user[email]", with: "test@example.com"
    fill_in "user[password]", with: "password"
    click_on "Log in"

    assert_selector ".govuk-notification-banner", text: "Signed in"
    assert_selector "h1", text: "Home"
  end

  test "reset password" do
    user = users(:alice)

    visit new_user_password_path
    assert_selector "h1", text: "Forgot your password?"

    fill_in "user[email]", with: user.email
    click_on "Submit"
    assert_selector ".govuk-notification-banner", text: "You will receive"

    reset_email = ActionMailer::Base.deliveries.last
    assert_equal user.email, reset_email.to[0]
    assert_match(/Reset password instructions/i, reset_email.subject)

    reset_token = reset_email.body.to_s.match(/reset_password_token=([^"]+)/)[1]

    visit edit_user_password_path(reset_password_token: reset_token)
    assert_selector "h1", text: "Change your password"

    fill_in "user[password]", with: "newpassword"
    fill_in "user[password_confirmation]", with: "newpassword"
    click_on "Update"
    assert_selector ".govuk-notification-banner", text: "Your password has been"

    click_on "Sign out"
    visit new_user_session_path
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: "newpassword"
    click_on "Log in"
    assert_selector ".govuk-notification-banner", text: "Signed in"
  end
end
