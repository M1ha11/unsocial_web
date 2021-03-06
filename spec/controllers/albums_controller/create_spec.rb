require 'rails_helper'

RSpec.describe AlbumsController, type: :controller do
  login_user
  describe "POST #create" do
    let(:user) { current_user }
    let(:album) { Album.last }
    let(:tags_count) { 8 }
    let(:created_tags) { tags_count.times.map { create(:tag) } }
    let(:tags) {  created_tags.map { |tag| tag[:content] } }
    let(:album_params) { FactoryGirl.attributes_for(:album) }
    before(:each) { album_params[:tags] = tags }
    let(:request_exec) { post :create, params: { user_id: user.id, album: album_params } }
    let(:tag_service) { class_double('TagService').as_stubbed_const }
    before(:each) { allow(tag_service).to receive_message_chain(:new, :tags) { created_tags } }

    context 'successful create' do

      include_examples "assign variables", :user

      it "creates the @album" do
        expect{ request_exec }.to change{ Album.count }.by(1)
        expect(assigns(:album)).to eq(album)
      end

      it "redirects to the created @album with a success flash" do
        request_exec
        expect(response.content_type).to eq("text/html")
        expect(flash[:notice]).to eq("Album was successfully created.")
        expect(response).to redirect_to(user_album_path(user, album))
      end

      it "uses tag service for tags" do
        expect(tag_service).to receive_message_chain(:new, :tags)
        request_exec
      end

      it "save @album tags" do
        request_exec
        expect(assigns(:album).tags.map(&:content)).to match_array(album_params[:tags])
        expect(assigns(:album).tags.count).to eq(tags_count)
      end
    end

    context 'unsuccessful create' do
      before(:each) { album_params[:title] = nil }

      include_examples "assign variables", :user

      it "doesn't create the @album" do
        expect{ request_exec }.to_not change{ Album.count }
      end

      it "renders 'new' template with an alert flash" do
        request_exec
        expect(response).to render_template('albums/new')
      end

      it "don't use tag service for tags" do
        expect(tag_service).to_not receive(:new)
        request_exec
      end

      it "doesn't save @album tags" do
        request_exec
        expect(assigns(:album).tags.map(&:content)).to_not include(album_params[:tags])
        expect(assigns(:album).tags.count).to eq(0)
      end
    end

    include_examples 'unauthorized action request', :create
  end
end

