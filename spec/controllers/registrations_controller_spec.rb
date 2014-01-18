describe 'Devise::RegistrationsController' do
  describe "GET index" do
    it "renders the index template" do
      post :create
      expect(response).to render_template("index")
    end
  end
end