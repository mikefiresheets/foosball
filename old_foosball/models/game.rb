class Game < ActiveRecord::Base

  # Relationships
  has_many :matchups, class_name: "GameTeam", inverse_of: :game
  accepts_nested_attributes_for :matchups, reject_if: :all_blank
  has_many :teams, through: :matchups

  # # Validation
  # validates :team1_score, numericality: { only_integer: true,
  #                                         greater_than_or_equal_to: 0,
  #                                         less_than_or_equal_to: 5 }
  # validates :team2_score, numericality: { only_integer: true,
  #                                         greater_than_or_equal_to: 0,
  #                                         less_than_or_equal_to: 5 }
end
