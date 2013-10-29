module UsersHelper
  def link_to_user(user, options={})
    link_to user, class: 'user_with_avatar' do
      concat image_tag user.gravatar_url(25)
      concat content_tag :span, user.name
    end
  end
end