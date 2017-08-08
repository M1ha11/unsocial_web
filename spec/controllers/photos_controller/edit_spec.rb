require 'rails_helper'

RSpec.describe PhotosController, type: :controller do
  login_user

  let(:user) { current_user }
  let(:album) { create(:album, user: user) }
  let(:photo) { create(:photo, album: album) }
  let(:request_exec) { get :edit, params: { user_id: user.id, album_id: album.id, id: photo.id } }

  describe "GET #edit" do
    before(:each) { request_exec }
    include_examples "assign variables", :user, :album, :photo

    it "returns a success response" do
      expect(response).to render_template("edit")
    end
  end

  include_examples 'unauthorized action request', :edit
end
