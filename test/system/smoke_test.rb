require "application_system_test_case"

class SmokesTest < ApplicationSystemTestCase
  test "visiting the home page" do
    visit root_url

    assert_selector "h1", text: "Pages#home"
  end
end
