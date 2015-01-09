require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test)
  end

  test "index including pagination" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'ul.pagination'
    User.order('last').page(1).per_page(8).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end
end
