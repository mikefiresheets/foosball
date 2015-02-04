module PlayersHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(player, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(player.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: player.name, class: "gravatar")
  end
end
