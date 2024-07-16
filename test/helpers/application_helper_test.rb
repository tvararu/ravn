require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "page_title should raise an error if no title is provided" do
    assert_raises(RuntimeError) { page_title }
  end
end
