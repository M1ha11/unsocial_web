require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #show" do
    login_user(:user_with_albums,  albums_count: 10)
    let(:albums) { current_user.albums }
    before(:each) { request_exec }
    context 'logged in user' do
      let(:request_exec) { get :show, params: { id: current_user.id } }


      it "must have a current_user" do
        expect(current_user).to_not eq(nil)
      end

      it "returns a success response" do
        expect(response).to render_template("show")
      end

      include_examples "assign variables", :albums
    end

    context 'not logged in user' do
      log_out
      let(:another_user) { create(:user_with_albums, albums_count: 5) }
      let(:request_exec) { get :show, params: { id: another_user.id } }

      it "returns a success response" do
        expect(response).to render_template("show")
      end

      # include_examples "not assign variables", :albums
    end
  end
end

