module UsersHelper
  def link_to_user(user, options={})
    path = current_user == user ? edit_user_registration_path : user
    link_to path, class: 'user_with_avatar', target: '_blank' do
      #concat image_tag user.gravatar_url(25), width: 25, height: 25
      content_tag :span, user.name
    end
  end

  def link_to_user_with_avatar(user, options={})
    path = current_user == user ? edit_user_registration_path : user
    if user
      link_to path, class: 'user_with_avatar', target: '_blank' do
        concat image_tag user.gravatar_url(25), width: 25, height: 25, class: 'img-circle'
        concat content_tag :span, user.name
      end
    else
      'n/a'
    end
  end
end