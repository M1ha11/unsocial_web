require 'rails_helper'

RSpec.describe AlbumsController, type: :controller do
  login_user
  describe "DELETE #destroy" do
    let(:user) { current_user }
    let!(:album) { create(:album, user: user) }
    let(:request_exec) { delete :destroy, params: { user_id: user.id, id: album.id } }

    context 'successful destroy' do
      include_examples "assign variables", :user, :album

      it "destroys the requested @album" do
        expect{ request_exec }.to change{ Album.count }.by(-1)
        expect(assigns(:album).destroyed?).to eq(true)
      end

      it "redirects to the @user 'show' with a success flash" do
        request_exec
        expect(response.content_type).to eq("text/html")
        expect(flash[:notice]).to eq("Album was successfully destroyed.")
        expect(response).to redirect_to(user_path(user))
      end
    end

    context 'unsuccessful destroy' do
      before(:example) { allow_any_instance_of(Album).to receive(:destroy).and_return(false) }

      include_examples "assign variables", :user, :album

      it "doesn't destroy the @album" do
        expect{ request_exec }.to_not change{ Album.count }
        expect(assigns(:album).destroyed?).to eq(false)
      end

      it "redirects to the @user 'show' path" do
        request_exec
        expect(response).to redirect_to(user_path(user))
      end
    end

    include_examples 'unauthorized action request', :destroy
  end
end
