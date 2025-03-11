require "test_helper"
require "capybara-playwright-driver"

Capybara.register_driver :playwright do |app|
  Capybara::Playwright::Driver.new(app, browser_type: :chromium, headless: true)
end
Capybara.default_max_wait_time = 0.5
Capybara.default_driver = :playwright
Capybara.save_path = "tmp/capybara"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :playwright, screen_size: [1280, 800]

  def sign_in(user, password: "password")
    visit new_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: password
    click_on "Log in"
  end
end
