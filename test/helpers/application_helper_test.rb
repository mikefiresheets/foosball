require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test "full title helper" do
    assert_equal full_title,         @base_title
    assert_equal full_title("Test"), "Test | #{@base_title}"
  end
end
