require 'rails_helper'

RSpec.describe PhotosController, type: :controller do
  login_user

  let(:user)  { current_user }
  let(:album) { create(:album, user: user) }
  let(:comments_count) { 15 }
  let(:tags_count) { 9 }
  let(:photo) { create(:photo_with_tags_and_comments, tags_count: tags_count, comments_count: comments_count, album: album) }
  let(:request_exec) { get :show, params: { user_id: user.id, album_id: album.id, id: photo.id } }

  describe "GET #show" do
    context 'logged in user' do
      before(:each) { request_exec }
      include_examples "assign variables", :user, :album, :photo

      it "returns a success response" do
        expect(response).to render_template("application", "show")
      end

      it "assign @tags" do
        expect(assigns(:tags)).to match_array(photo.tags)
        expect(assigns(:tags).count).to eq(tags_count)
      end

      it "assign @comments" do
        expect(assigns(:comments)).to match_array(photo.comments)
        expect(assigns(:comments).count).to eq(comments_count)
      end

      context 'xhr request' do
        let(:request_exec) { get :show, params: { user_id: user.id, album_id: album.id, id: photo.id }, xhr: true }
        it "returns a success response without layout" do
          expect(response).to render_template("show")
          expect(response).to_not render_template("layout")
        end
      end
    end

    include_examples 'unauthorized action request', :show
  end
end
