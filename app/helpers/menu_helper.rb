module MenuHelper
  def link_to_nav(title, path, options={})
    active_class = current_page?(path) ? 'active' : ''
    content_tag :li, class: active_class do
      link_to title, path, options
    end
  end
end