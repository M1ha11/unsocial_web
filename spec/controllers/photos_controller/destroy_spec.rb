require 'rails_helper'

RSpec.describe PhotosController, type: :controller do
  login_user
  describe "DELETE #destroy" do
    let(:user) { current_user }
    let(:album) { create(:album, user: user) }
    let!(:photo) { create(:photo, album: album) }
    let(:request_exec) { delete :destroy, params: { user_id: user.id, album_id: album.id, id: photo.id } }

    context 'successful destroy' do
      include_examples "assign variables", :user, :album, :photo

      it "destroys the requested @photo" do
        expect{ request_exec }.to change{ Photo.count }.by(-1)
        expect(assigns(:photo).destroyed?).to eq(true)
      end

      it "redirects to the @photo 'show' with a success flash" do
        request_exec
        expect(response.content_type).to eq("text/html")
        expect(flash[:notice]).to eq("Photo was successfully destroyed.")
        expect(response).to redirect_to(user_album_path(user, album))
      end
    end

    context 'unsuccessful destroy' do
      before(:example) { allow_any_instance_of(Photo).to receive(:destroy).and_return(false) }

      include_examples "assign variables", :user, :album, :photo

      it "doesn't destroy the @photo" do
        expect{ request_exec }.to_not change{ Photo.count }
        expect(assigns(:photo).destroyed?).to eq(false)
      end

      it "redirects to the @album 'show' path" do
        request_exec
        expect(response).to redirect_to(user_album_path(user, album))
      end
    end

    include_examples 'unauthorized action request', :destroy
  end
end
