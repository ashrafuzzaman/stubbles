module CommentsHelper
  def container_id_of_comments_for(resource)
    "#{resource.class.name.downcase}_#{resource.id}_comments"
  end

  def render_comments_for(resource)
    render :partial => 'comments/comments', :locals => {:resource => resource}
  end

  def new_comments_for(resource)
  	path = "new_#{resource.class.name.downcase}_comment_path"
  	link_to 'New Comment', self.send(path, resource), :remote => true, :'disable-with' => 'Loading', :class => 'button new'
  end

  def container_id_of_comments_for(resource)
    "#{resource.class.name.downcase}-#{resource.id}-comments"  	
  end

  def link_to_delete_comment(comment)
  	if comment.permitted_to_delete_by?(current_user)
	  	path = "#{comment.commentable.class.name.downcase}_comment_path"
	  	link_to('Destroy', self.send(path, comment.commentable, comment), 
					:confirm => 'Are you sure?', :class => 'ui-icon ui-icon-trash',
					:method => :delete, :remote=>true, :style => 'float: left;',
					:'data-disable-with' => "Deleting...")
  	end
  end

  def comments_container
  	concat <<-EOF.html_safe
    	<div class="comments ui-widget ui-widget-content ui-helper-clearfix ui-corner-all">
  	EOF
  	yield
  	concat <<-EOF.html_safe
    	</div>
  	EOF
  end

  def comments_header
  	concat <<-EOF.html_safe
    	<div class="comments-header ui-corner-all">
  	EOF
    yield
  	concat <<-EOF.html_safe
    	<span class="collapsable ui-icon ui-icon-triangle-1-s" style="float: left;"></span>
    	</div>
  	EOF
  end

  def comments_content
  	concat <<-EOF.html_safe
    	<div class="comments-content ui-helper-hidden">
  	EOF
    yield
  	concat <<-EOF.html_safe
    	</div>
  	EOF
  end
end