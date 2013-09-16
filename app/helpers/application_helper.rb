module ApplicationHelper
  def container_id_of(model)
    model.new_record? ? 'new' : "#{model.class.name.downcase}-#{model.id}"
  end
  
  def ajax_cancel_link(model, removeElement = 'form')
    if(!model.new_record?)
      link_to "cancel", {:action => "show"}, :remote => true, 
              :'data-disable-with' => "canceling...", :class => 'button'
    else
      link_to "cancel", '#', :'data-cancel' => removeElement, 
              :'data-disable-with' => "canceling...", :class => 'button'
    end
  end

  def deactivate_link(model, activate_path, deactivate_path)
    text = model.active? ? 'Deactivate' : 'Activate'
    path = model.active? ? deactivate_path :  activate_path
    return link_to text, path, :confirm => 'Are you sure?', :method => :put, :remote=>true
  end

  def error_message
    render :partial => 'shared/errors', :locals => {:errors => flash[:error]}
  end

  def execute_js_if(success)
    if success
      yield
      concat raw "showSuccessMessage('#{escape_javascript(flash[:notice])}');"
    else
      concat raw "showErrorMessage('#{escape_javascript(error_message)}');"
    end
  end

  def avatar(user, size = 20)
    image_tag(user.gravatar_url(size), :size => "#{size}x#{size}", :alt => "Avatar")
  end
end