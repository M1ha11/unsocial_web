require 'rails_helper'

RSpec.describe AlbumsController, type: :controller do
  login_user

  let(:album) { create(:album_with_photos_and_tags, tags_count: 10, user: current_user) }
  let(:user) { album.user }
  let(:request_exec) { get :show, params: { user_id: user.id, id: album.id } }

  describe "GET #show" do
    context 'logged in user' do
      before(:each) { request_exec }
      include_examples "assign variables", :user, :album

      it "returns a success response" do
        expect(response).to render_template("show")
      end

      it "assign @tags" do
        expect(assigns(:tags)).to match_array(album.tags)
      end

      it "assign @photos" do
        expect(assigns(:photos)).to match_array(album.photos)
      end
    end

    include_examples 'unauthorized action request', :show
  end
end
