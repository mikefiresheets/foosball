require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user       = users(:test)
    @other_user = users(:mike)
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should get index" do
    log_in_as @user
    get :index
    assert_response :success
    assert_select 'title', full_title('Users')
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_select 'title', full_title('Sign Up')
    assert_not_nil assigns(:user)
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { first: 'Controller', last: 'Test', email: 'tester@example.com',
                            password: 'testing', password_confirmation: 'testing' }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @user, user: { first: @user.first,
                                      last: @user.last, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should show user" do
    log_in_as @user
    get :show, id: @user
    assert_response :success
    assert_select 'title', full_title(@user.name)
  end

  test "should get edit" do
    log_in_as @user
    get :edit, id: @user
    assert_response :success
    assert_select 'title', full_title(@user.name)
  end

  test "should update user" do
    log_in_as @user
    patch :update, id: @user, user: { first: @user.first, last: @user.last, email: @user.email }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to root_url
  end

  test "should destroy user" do
    log_in_as users(:admin)
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch :update, id: @other_user, user: { password:              @other_user.password,
                                            password_confirmation: @other_user.password,
                                            admin: 1 }
    assert_not @other_user.reload.admin?
  end
end
