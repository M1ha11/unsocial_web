require 'rails_helper'

RSpec.describe AlbumsController, type: :controller do
  login_user

  let(:user) { current_user }
  let(:request_exec) { get :new, params: { user_id: user.id } }

  describe "GET #new" do
    before(:each) { request_exec }

    include_examples "assign variables", :user

    it "returns a success response" do
      expect(response).to render_template("new")
    end

    it "assigns new @album" do
      expect(assigns(:album)).to be_a_new(Album).with(user_id: user.id)
    end
  end

  include_examples 'unauthorized action request', :new
end
