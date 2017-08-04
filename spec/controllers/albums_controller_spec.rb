require 'rails_helper'

RSpec.describe AlbumsController, type: :controller do
  login_user
  describe "GET #show" do
    before(:each) { request_exec }
    context 'logged in user' do
      let(:album) { create(:album_with_photos_and_tags, tags_count: 10, user: current_user) }
      let(:request_exec) { get :show, params: { user_id: album.user.id, id: album.id } }
      let(:photos) { album.photos }
      let(:tags) { album.tags }

      it "must have a current_user" do
        expect(current_user).to_not eq(nil)
      end

      it "returns a success response" do
        expect(response).to be_success
      end

      it "returns a success response" do
        expect(response).to render_template("show")
      end

      include_examples "assign variables", :photos, :tags
    end
  end

  # describe "GET #new" do
  #   it "returns a success response" do
  #     get :new
  #     expect(response).to be_success
  #   end
  # end

  # describe "GET #edit" do
  #   it "returns a success response" do
  #     album = Album.create! valid_attributes
  #     get :edit, params: {id: album.to_param}
  #     expect(response).to be_success
  #   end
  # end

  # describe "POST #create" do
  #   context "with valid params" do
  #     it "creates a new Album" do
  #       expect {
  #         post :create, params: {album: valid_attributes}
  #       }.to change(Album, :count).by(1)
  #     end

  #     it "redirects to the created album" do
  #       post :create, params: {album: valid_attributes}
  #       expect(response).to redirect_to(Album.last)
  #     end
  #   end

  #   context "with invalid params" do
  #     it "returns a success response (i.e. to display the 'new' template)" do
  #       post :create, params: {album: invalid_attributes}
  #       expect(response).to be_success
  #     end
  #   end
  # end

  # describe "PUT #update" do
  #   context "with valid params" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }

  #     it "updates the requested album" do
  #       album = Album.create! valid_attributes
  #       put :update, params: {id: album.to_param, album: new_attributes}
  #       album.reload
  #       skip("Add assertions for updated state")
  #     end

  #     it "redirects to the album" do
  #       album = Album.create! valid_attributes
  #       put :update, params: {id: album.to_param, album: valid_attributes}
  #       expect(response).to redirect_to(album)
  #     end
  #   end

  #   context "with invalid params" do
  #     it "returns a success response (i.e. to display the 'edit' template)" do
  #       album = Album.create! valid_attributes
  #       put :update, params: {id: album.to_param, album: invalid_attributes}
  #       expect(response).to be_success
  #     end
  #   end
  # end

  # describe "DELETE #destroy" do
  #   it "destroys the requested album" do
  #     album = Album.create! valid_attributes
  #     expect {
  #       delete :destroy, params: {id: album.to_param}
  #     }.to change(Album, :count).by(-1)
  #   end

  #   it "redirects to the albums list" do
  #     album = Album.create! valid_attributes
  #     delete :destroy, params: {id: album.to_param}
  #     expect(response).to redirect_to(albums_url)
  #   end
  # end

end
