require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "page_title should raise an error if no title is provided" do
    assert_raises(ArgumentError) { page_title }
  end
end
