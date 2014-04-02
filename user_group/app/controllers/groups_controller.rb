class GroupsController < InheritedResources::Base
  belongs_to :project
  actions :all, :except => [:show]
  custom_actions :collection => :assign

  def assign
    assign! do
      @proect.cancel!
    end
  end
end