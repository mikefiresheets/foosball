require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  def setup
    @player = players(:test)
  end

  test "player should be valid" do
    assert @player.valid?, @player.errors.full_messages.join(' ')
  end

  test "name should be present" do
    @player.first = "     "
    @player.last = "     "
    assert_not @player.valid?
  end

  test "name should not be too long" do
    @player.first = 'a' * 51;
    assert_not @player.valid?
    @player.first = 'test'
    assert @player.valid?
    @player.last = 'a' * 51
    assert_not @player.valid?
  end

  test "email should not be too long" do
    @player.email = 'a' * 256
    assert_not @player.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @player.email = valid_address
      assert @player.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @player.email = invalid_address
      assert_not @player.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_player = @player.dup
    duplicate_player.email = @player.email.upcase
    @player.save
    assert_not duplicate_player.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @player.email = mixed_case_email
    @player.save
    assert_equal mixed_case_email.downcase, @player.reload.email
  end
end
