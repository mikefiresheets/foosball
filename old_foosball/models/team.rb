class Team < ActiveRecord::Base
  INITIAL_TEAM_NAME = 'A'
  @next_name = INITIAL_TEAM_NAME

  # Relationships
  has_many :players
  has_many :matchups, class_name: "GameTeam", inverse_of: :team
  has_many :games, through: :matchups

  # Validation
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :players, length: { minimum: 2, maximum: 2 }

  # Class methods
  class << self
    attr_reader :next_name

    def take_name!
      name = @next_name
      @next_name = @next_name.next
      name
    end

    def reset_names!
      @next_name = INITIAL_TEAM_NAME
    end
  end

  # Virtual Properties
  def goals_scored
    games.sum(:score)
  end

  def goals_allowed
    GameTeam.where(game_id: matchups.map(&:game_id)).where.not(team_id: id).sum(:score)
  end

  def goal_differential
    sprintf "%+d", goals_scored - goals_allowed
  end
end
