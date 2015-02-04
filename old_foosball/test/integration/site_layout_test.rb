require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "header links" do
    get root_path
    assert_template 'players/index'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", players_path
    assert_select "a[href=?]", teams_path, count: 2
    assert_select "a[href=?]", new_team_path
  end

  # test "footer form" do
  #   # Do the test here
  # end
end
