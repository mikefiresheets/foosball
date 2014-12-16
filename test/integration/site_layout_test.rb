require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout header links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path
  end

  test "layout footer links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', help_path
  end
end
