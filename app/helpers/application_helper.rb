module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def declension(count, singular, plural_ru, plural)
    count = 0 if (count == nil || !count.is_a?(Numeric))

    remainder = count % 100
    return plural if remainder.between?(11, 14)

    remainder = count % 10
    return singular if remainder == 1
    return plural_ru if remainder.between?(2, 4)
    return plural if (remainder >= 5 || remainder.zero?)
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end
end
