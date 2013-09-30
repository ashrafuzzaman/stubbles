require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe MilestoneResourcesController do

  # This should return the minimal set of attributes required to create a valid
  # MilestoneResource. As you add validations to MilestoneResource, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "milestone_id" => "1" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MilestoneResourcesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all milestone_resources as @milestone_resources" do
      milestone_resource = MilestoneResource.create! valid_attributes
      get :index, {}, valid_session
      assigns(:milestone_resources).should eq([milestone_resource])
    end
  end

  describe "GET show" do
    it "assigns the requested milestone_resource as @milestone_resource" do
      milestone_resource = MilestoneResource.create! valid_attributes
      get :show, {:id => milestone_resource.to_param}, valid_session
      assigns(:milestone_resource).should eq(milestone_resource)
    end
  end

  describe "GET new" do
    it "assigns a new milestone_resource as @milestone_resource" do
      get :new, {}, valid_session
      assigns(:milestone_resource).should be_a_new(MilestoneResource)
    end
  end

  describe "GET edit" do
    it "assigns the requested milestone_resource as @milestone_resource" do
      milestone_resource = MilestoneResource.create! valid_attributes
      get :edit, {:id => milestone_resource.to_param}, valid_session
      assigns(:milestone_resource).should eq(milestone_resource)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new MilestoneResource" do
        expect {
          post :create, {:milestone_resource => valid_attributes}, valid_session
        }.to change(MilestoneResource, :count).by(1)
      end

      it "assigns a newly created milestone_resource as @milestone_resource" do
        post :create, {:milestone_resource => valid_attributes}, valid_session
        assigns(:milestone_resource).should be_a(MilestoneResource)
        assigns(:milestone_resource).should be_persisted
      end

      it "redirects to the created milestone_resource" do
        post :create, {:milestone_resource => valid_attributes}, valid_session
        response.should redirect_to(MilestoneResource.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved milestone_resource as @milestone_resource" do
        # Trigger the behavior that occurs when invalid params are submitted
        MilestoneResource.any_instance.stub(:save).and_return(false)
        post :create, {:milestone_resource => { "milestone_id" => "invalid value" }}, valid_session
        assigns(:milestone_resource).should be_a_new(MilestoneResource)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        MilestoneResource.any_instance.stub(:save).and_return(false)
        post :create, {:milestone_resource => { "milestone_id" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested milestone_resource" do
        milestone_resource = MilestoneResource.create! valid_attributes
        # Assuming there are no other milestone_resources in the database, this
        # specifies that the MilestoneResource created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        MilestoneResource.any_instance.should_receive(:update_attributes).with({ "milestone_id" => "1" })
        put :update, {:id => milestone_resource.to_param, :milestone_resource => { "milestone_id" => "1" }}, valid_session
      end

      it "assigns the requested milestone_resource as @milestone_resource" do
        milestone_resource = MilestoneResource.create! valid_attributes
        put :update, {:id => milestone_resource.to_param, :milestone_resource => valid_attributes}, valid_session
        assigns(:milestone_resource).should eq(milestone_resource)
      end

      it "redirects to the milestone_resource" do
        milestone_resource = MilestoneResource.create! valid_attributes
        put :update, {:id => milestone_resource.to_param, :milestone_resource => valid_attributes}, valid_session
        response.should redirect_to(milestone_resource)
      end
    end

    describe "with invalid params" do
      it "assigns the milestone_resource as @milestone_resource" do
        milestone_resource = MilestoneResource.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        MilestoneResource.any_instance.stub(:save).and_return(false)
        put :update, {:id => milestone_resource.to_param, :milestone_resource => { "milestone_id" => "invalid value" }}, valid_session
        assigns(:milestone_resource).should eq(milestone_resource)
      end

      it "re-renders the 'edit' template" do
        milestone_resource = MilestoneResource.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        MilestoneResource.any_instance.stub(:save).and_return(false)
        put :update, {:id => milestone_resource.to_param, :milestone_resource => { "milestone_id" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested milestone_resource" do
      milestone_resource = MilestoneResource.create! valid_attributes
      expect {
        delete :destroy, {:id => milestone_resource.to_param}, valid_session
      }.to change(MilestoneResource, :count).by(-1)
    end

    it "redirects to the milestone_resources list" do
      milestone_resource = MilestoneResource.create! valid_attributes
      delete :destroy, {:id => milestone_resource.to_param}, valid_session
      response.should redirect_to(milestone_resources_url)
    end
  end

end
