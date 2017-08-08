require 'rails_helper'

RSpec.describe AlbumsController, type: :controller do
  login_user
  describe "PATCH #update" do
    let(:user) { current_user }
    let(:album) { create(:album, user: user) }
    let(:tags) {  5.times.map { FactoryGirl.attributes_for(:tag)[:content] } }
    let(:album_params) { FactoryGirl.attributes_for(:album) }
    before(:each) { album_params[:tags] = tags }
    let(:request_exec) { patch :update, params: { user_id: user.id, id: album.id, album: album_params } }

    context 'successful update' do

      include_examples "assign variables", :user, :album

      it "updates the requested @album" do
        request_exec
        expect(assigns(:album).attributes.slice('title', 'description'))
                              .to include(album_params.except(:tags).stringify_keys)
        expect(assigns(:album).changed?).to eq(false)
      end

      it "redirects to the updated @album with a success flash" do
        request_exec
        expect(response.content_type).to eq("text/html")
        expect(flash[:notice]).to eq("Album was successfully updated.")
        expect(response).to redirect_to(user_album_path(user, album))
      end

      it "save @album tags" do
        request_exec
        expect(assigns(:album).tags.map(&:content)).to match_array(album_params[:tags])
      end
    end

    context 'unsuccessful update' do
      before(:each) { album_params[:title] = '' }

      include_examples "assign variables", :user, :album

      it "doesn't update the @album" do
        request_exec
        expect(assigns(:album).changed?).to eq(true)
      end

      it "renders 'edit' template with an alert flash" do
        request_exec
        expect(response).to render_template('albums/edit')
      end

      it "doesn't save @album tags" do
        request_exec
        expect(assigns(:album).tags.map(&:content)).to_not include(album_params[:tags])
      end
    end

    include_examples 'unauthorized action request', :update
  end
end
