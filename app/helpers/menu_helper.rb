module MenuHelper
  def link_to_nav(title, path, options={})
    content_tag :li do
      link_to title, path, options
    end
  end
end