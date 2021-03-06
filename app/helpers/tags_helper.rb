module TagsHelper

	class ActionView::Helpers::FormBuilder
	  def tag(method, options = {})
	  	available_tags = (options[:available_tags] || []).collect { |tag| tag.name }.join ','
	    @template.content_tag :ul, {:'data-item-name' => @object_name, 
	    											:'data-field-name' => method, 
	    											:class => 'tag-it',
	    											:'data-available-tags' => available_tags} do
				@object.send(method).each do |tag|
					@template.concat(@template.content_tag(:li, tag))
				end
    	end
	  end
	end

	def tags_for(tag_list)
		if tag_list.size > 0
			content_tag(:div, :class => "tags") do
				tag_list.each do |tag|
					concat(content_tag(:span, :class => "tag label label-info") do
						tag
					end)
				end
			end
		end
	end
end