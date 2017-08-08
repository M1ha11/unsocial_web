require 'rails_helper'

RSpec.describe PhotosController, type: :controller do
  login_user
  describe "PATCH #update" do
    let(:user) { current_user }
    let(:album) { create(:album, user: user) }
    let(:created_photo_tags_count) { 3 }
    let(:photo) { create(:photo_with_tags, tags_count: created_photo_tags_count, album: album) }
    let(:tags_count) { 7 }
    let(:tags) {  tags_count.times.map { FactoryGirl.attributes_for(:tag)[:content] } }
    let(:photo_params) { FactoryGirl.attributes_for(:photo) }
    before(:each) { photo_params[:tags] = tags }
    let(:request_exec) { patch :update, params: { user_id: user.id, album_id: album.id, id: photo.id, photo: photo_params } }

    context 'successful update' do

      include_examples "assign variables", :user, :album, :photo

      it "updates the requested @photo" do
        request_exec
        expect(assigns(:photo).attributes.slice('description'))
                              .to include(photo_params.except(:tags, :image).stringify_keys)
        expect(assigns(:photo).changed?).to eq(false)
      end

      it "redirects to the updated @photo with a success flash" do
        request_exec
        expect(response.content_type).to eq("text/html")
        expect(flash[:notice]).to eq("Photo was successfully updated.")
        expect(response).to redirect_to(user_album_path(user, album))
      end

      it "save @photo tags" do
        request_exec
        expect(assigns(:photo).tags.map(&:content)).to match_array(photo_params[:tags])
        expect(assigns(:photo).tags.count).to eq(tags_count)
      end
    end

    context 'unsuccessful update' do
      before(:each) { photo_params[:image] = nil }

      include_examples "assign variables", :user, :album, :photo

      it "doesn't update the @photo" do
        request_exec
        expect(assigns(:photo).changed?).to eq(true)
      end

      it "renders 'edit' template with an alert flash" do
        request_exec
        expect(response).to render_template('photos/edit')
      end

      it "doesn't save @photo tags" do
        request_exec
        expect(assigns(:photo).tags.map(&:content)).to_not include(photo_params[:tags])
        expect(assigns(:photo).tags.count).to eq(created_photo_tags_count)
      end
    end

    include_examples 'unauthorized action request', :update
  end
end
