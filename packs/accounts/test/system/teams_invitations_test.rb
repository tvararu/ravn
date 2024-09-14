require "application_system_test_case"

class TeamsInvitationsTest < ApplicationSystemTestCase
  test "invite a user to a personal team" do
    alice = users(:alice)
    sign_in alice

    visit profile_path
    click_on "Invite members"
    assert_selector "h1", text: "Send invitation"

    fill_in "Email", with: alice.email
    click_on "Invite"
    assert_text "There is a problem"

    fill_in "Email", with: "newuser@example.com"
    click_on "Invite"
    assert_text "Invitation sent to newuser@example.com"
    assert_selector "li", text: "newuser@example.com"

    sign_out alice
    email = ActionMailer::Base.deliveries.last
    assert_match "newuser@example.com", email.to.first

    invitation_token = email.body.parts.first.to_s
      .match(/invitation_token=([\w-]+)/)[1]

    visit accept_user_invitation_path(invitation_token:)
    assert_selector "h1", text: "Set your password"

    fill_in "Password", with: "password"
    fill_in "Confirm your password", with: "password"
    click_on "Create account"
    assert_selector "h1", text: "Home"
  end
end
