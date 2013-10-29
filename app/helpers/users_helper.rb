module UsersHelper
  def link_to_user(user, options={})
    path = current_user == user ? edit_user_registration_path : user
    link_to path, class: 'user_with_avatar', target: '_blank' do
      concat image_tag user.gravatar_url(25)
      concat content_tag :span, user.name
    end
  end
end