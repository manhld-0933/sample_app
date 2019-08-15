module ApplicationHelper
  def full_title page_title
    base_title = I18n.t "name_app"
    if page_title.blank?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def gravatar_for user, size: Settings.gravatar_size
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
