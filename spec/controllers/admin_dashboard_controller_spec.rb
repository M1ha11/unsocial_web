require 'rails_helper'

RSpec.describe Admin::DashboardController, type: :controller do
  context "login user" do
    login_user
    describe "#access_denied" do
      it "redirects to the root path with danger flash" do
        get :index
        expect(flash[:danger]).to eq("You cannot access this page")
        expect(response).to redirect_to(root_path)
      end
    end
  end

  context "login admin" do
    login_admin
    it "it gets success response" do
      get :index
      expect(response).to render_template("active_admin/page/index")
    end
  end
end

