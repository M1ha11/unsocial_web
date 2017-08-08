require 'rails_helper'

RSpec.describe PhotosController, type: :controller do
  login_user
  describe "POST #create" do
    let(:user) { current_user }
    let(:album) { create(:album, user: user) }
    let(:photo) { Photo.last }
    let(:tags_count) { 7 }
    let(:tags) {  tags_count.times.map { FactoryGirl.attributes_for(:tag)[:content] } }
    let(:photo_params) { FactoryGirl.attributes_for(:photo) }
    before(:each) { photo_params[:tags] = tags }
    let(:request_exec) { post :create, params: { user_id: user.id, album_id: album.id, photo: photo_params } }

    context 'successful create' do

      include_examples "assign variables", :user, :album

      it "creates the @photo" do
        expect{ request_exec }.to change{ Photo.count }.by(1)
        expect(assigns(:photo)).to eq(photo)
      end

      it "redirects to the created @photo with a success flash" do
        request_exec
        expect(response.content_type).to eq("text/html")
        expect(flash[:notice]).to eq("Photo was successfully created.")
        expect(response).to redirect_to(user_album_path(user, album))
      end

      it "save @photo tags" do
        request_exec
        expect(assigns(:photo).tags.map(&:content)).to match_array(photo_params[:tags])
        expect(assigns(:photo).tags.count).to eq(tags_count)
      end
    end

    context 'unsuccessful create' do
      before(:each) { photo_params[:image] = nil }

      include_examples "assign variables", :user

      it "doesn't create the @photo" do
        expect{ request_exec }.to_not change{ Photo.count }
      end

      it "renders 'new' template with an alert flash" do
        request_exec
        expect(response).to render_template('photos/new')
      end

      it "doesn't save @photo tags" do
        request_exec
        expect(assigns(:photo).tags.map(&:content)).to_not include(photo_params[:tags])
        expect(assigns(:photo).tags.count).to eq(0)
      end
    end

    include_examples 'unauthorized action request', :create
  end
end

