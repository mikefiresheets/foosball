class GameTeam < ActiveRecord::Base
  self.table_name = 'games_teams'

  # Relationships
  belongs_to :game
  belongs_to :team
  accepts_nested_attributes_for :team, reject_if: :all_blank
end
