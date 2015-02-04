module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = Rails.application.config.site_title
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def short_form
    @game = Game.new
    @game.matchups.build.build_team
    @game.matchups.build.build_team
  end
end
