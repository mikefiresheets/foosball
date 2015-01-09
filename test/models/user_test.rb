require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.new(first: "Example", last: "User", email: "user@example.com",
                     password: "password", password_confirmation: "password")
  end

  test "user should be valid" do
    assert @user.valid?, @user.errors.full_messages.join(' ')
  end

  test "first and last names should be present" do
    @user.first = '  '
    assert_not @user.valid?
    @user.first = 'Test'
    assert @user.valid?
    @user.last = '  '
    assert_not @user.valid?
  end

  test "name property should be present" do
    assert_equal @user.name, "#{@user.first} #{@user.last}"
  end

  test "name should not be too long" do
    @user.first = 'a' * 51;
    assert_not @user.valid?
    @user.first = 'test'
    assert @user.valid?
    @user.last = 'a' * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = 'a' * 256
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[tester@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 6
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
end
