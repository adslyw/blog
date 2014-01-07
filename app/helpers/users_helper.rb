module UsersHelper
	def gravatar_for(user, option = { size: 50,class: "img-circle" })
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		size = option[:size]
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
		image_tag(gravatar_url, alt: user.name, class: option[:class])
	end
end
