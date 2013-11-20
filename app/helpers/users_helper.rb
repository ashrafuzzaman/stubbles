module UsersHelper
  def link_to_user(user, options={})
    path = current_user == user ? edit_user_registration_path : user
    link_to path, class: 'user_with_avatar', target: '_blank' do
      #concat image_tag user.gravatar_url(25), width: 25, height: 25
      content_tag :span, user.name
    end
  end

  def link_to_user_with_avatar(user, options={})
    user = user.kind_of?(User) ? user : (user.nil? ? nil : User.find(user)) #if id is sent
    path = current_user == user ? edit_user_registration_path : user
    image_size = options[:size] || 25
    if user
      link_to path, class: 'user_with_avatar', target: '_blank' do
        concat image_tag user.gravatar_url(image_size), width: image_size, height: image_size, class: 'img-circle'
        concat content_tag :span, (user.short_name || user.name)
      end
    else
      'n/a'
    end
  end
end