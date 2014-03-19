module StoriesHelper
  def assigned_person_for(model)
    model.assigned_to.nil? ? 'n/a' : model.assigned_to.name
  end

  def container_id_of_tasks_for(story)
    "#{container_id_of(story)}_tasks"
  end

  def action_links_for_story(story)
    if (story.finished? || story.rejected?) && current_user.admin_for?(story.project)
      form_tag(update_status_project_story_path(story.project, story),
               :method => :put, :remote => true) do
        story.current_state.events.keys.each do |event|
          concat(submit_tag(event, :name => 'event', :value => event,
                            :class => "#{event} button small",
                            :'data-disable-with' => 'wait'))
        end
      end
    end
  end

  def select_users(form, story, icon = true)
    users = story.milestone ? story.milestone.resources : story.assignable_users
    user_select_tag = form.select(:assigned_to_id, users.collect { |u| [u.name, u.id] },
                                  {:include_blank => true}, class: "form-control")
    if icon
      content_tag :div, class: 'input-group input-group' do
        concat content_tag(:span, content_tag(:span, '', class: 'glyphicon glyphicon-user'), class: 'input-group-addon')
        concat user_select_tag
      end
    else
      user_select_tag
    end
  end

  def select_story_type(form)
    form.select(:type, StoryType.all_selectable, {}, class: "form-control")
  end

  def story_edit_link(story)
    unless story.milestone.try(:archived?)
      link_to('', edit_project_story_path(story.project, story),
              :remote => true, :class => 'glyphicon glyphicon-edit',
              :'data-disable-with' => "Loading...") if story.permitted_to_edit_by?(current_user)
    end
  end

  def story_delete_link(story)
    unless story.milestone.try(:archived?)
      link_to('', project_story_path(story.project, story),
              :remote => true, :class => 'glyphicon glyphicon-trash', :method => :delete,
              :confirm => 'Are you sure?', :'data-disable-with' => "Loading...") if story.permitted_to_delete_by?(current_user)
    end
  end

  def story_time_estimations(story)
    render :partial => 'shared/estimated_and_spent_hours',
           :locals => {:estimated => story.hours_estimated,
                       :spent => story.hours_spent}
  end

  def story_widget(story, &block)
    allow_to_estimate = story.story_type.initial_workflow_status.try(:allow_to_estimate?) rescue true
    content_tag :div, id: container_id_of(story),
                class: "story #{story.status} panel panel-#{story.panel_color}", allow_to_estimate: allow_to_estimate do
      capture(StoryWidget.new(story, self), &block)
    end
  end

  def story_form_widget(story, &block)
    nested_form_for([story.project, story.becomes(Story)], :remote => true, role: 'form', multipart: true, html: {id: container_id_of(story)}) do |f|
      content_tag :div, class: "story #{story.status} panel panel-#{story.panel_color}" do
        capture(f, StoryWidget.new(story, self), &block)
      end
    end
  end
end

class StoryWidget
  attr_reader :story

  def initialize(story, template)
    @story = story
    @template = template
  end

  def container_id
    @template.container_id_of(story)
  end

  def header(&block)
    @template.content_tag :div, class: "panel-heading story-header" do
      @template.content_tag :h2, class: "panel-title row" do
        @template.capture(&block)
      end
    end
  end

  def collapse_link(&block)
    @template.content_tag :a, class: "accordion-toggle collapsed", :'data-toggle' => "collapse", :'data-parent' => "#accordion",
                          href: "##{container_id}_content" do
      @template.capture(&block)
    end
  end

  def actions(&block)
    @template.content_tag :div, class: "story-actions col-md-5 text-right" do
      @template.capture(&block)
    end
  end

  def content(options={}, &block)
    collapse = options[:collapse]
    collapse = true if collapse.nil?
    collapse_class = collapse ? 'collapse' : 'in'
    @template.content_tag :div, id: "#{container_id}_content", class: "panel-collapse #{collapse_class}" do
      @template.content_tag :div, class: "story-container" do
        @template.capture(&block)
      end
    end
  end

  def footer(&block)
    @template.content_tag :div, class: "panel-footer" do
      @template.capture(&block)
    end
  end
end