require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  def setup
    @team = teams(:test)
    @team.players = players(:mike), players(:noah)
  end

  test "class method should reset name" do
    Team.reset_names!
    assert_equal Team.next_name, Team::INITIAL_TEAM_NAME
  end

  test "class method should give name" do
    assert_not_nil Team.next_name
  end

  test "class method should take and change name" do
    Team.reset_names!
    name = Team.take_name!
    assert_not_equal Team.next_name, Team::INITIAL_TEAM_NAME
  end

  test "team should be valid" do
    assert @team.valid?, @team.errors.full_messages.join(' ')
  end

  test "name should be present" do
    @team.name = '  '
    assert_not @team.valid?
  end

  test "name should not be too long" do
    @team.name = 'a' * 51
    assert_not @team.valid?
  end

  test "name should be unique" do
    duplicate_team = @team.dup
    duplicate_team.name = @team.name.downcase
    @team.save
    assert_not duplicate_team.valid?
  end

  test "name should be saved as capitalized" do
    mixed_case_name = "The TeRminaTors"
    @team.name = mixed_case_name
    @team.save
    assert_equal mixed_case_name.downcase.capitalize, @team.reload.name
  end

  test "must have exactly two players" do
    @team.players.clear
    assert_not @team.valid?
    @team.players << players(:mike)
    assert_not @team.valid?
    @team.players << players(:noah)
    assert @team.valid?
    @team.players << players(:luke)
    assert_not @team.valid?
  end
end
