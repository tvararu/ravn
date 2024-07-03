require "application_system_test_case"

class SmokeTest < ApplicationSystemTestCase
  test "visiting the home page" do
    visit root_url

    assert_selector "h1", text: "Home"
  end
end
