require "test_helper"
require "capybara/cuprite"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :cuprite

  Capybara.default_max_wait_time = 0.5

  def sign_in(user, password: "password")
    visit new_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: password
    click_on "Log in"
  end
end
