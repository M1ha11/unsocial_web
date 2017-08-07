require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #show" do
    login_user(:user_with_albums,  albums_count: 10)
    let(:user) { current_user }
    let(:request_exec) { get :show, params: { id: user.id } }

    context 'logged in user' do
      before(:each) { request_exec }

      it "must have a current_user" do
        expect(current_user).to_not eq(nil)
      end

      it "returns a success response" do
        expect(response).to render_template("show")
      end

      include_examples "assign variables", :user

      it "assign @photos" do
        expect(assigns(:albums)).to match_array(user.albums)
      end
    end

    include_examples 'unauthorized action request', :show
  end
end

