require 'rails_helper'

RSpec.describe PhotosController, type: :controller do
  login_user
  let(:user) { current_user }
  let(:album) { create(:album, user: current_user) }

  let(:request_exec) { get :new, params: { user_id: user.id, album_id: album.id } }

  describe "GET #new" do
    before(:each) { request_exec }

    include_examples "assign variables", :user, :album

    it "returns a success response" do
      expect(response).to render_template("new")
    end

    it "assigns new @album" do
      expect(assigns(:photo)).to be_a_new(Photo).with(album_id: album.id)
    end
  end

  include_examples 'unauthorized action request', :new
end
