require 'rails_helper'

RSpec.describe HomePageController, type: :controller do
  login_user
  describe "GET #index" do
    let(:request_exec) { get :index }
    context 'logged in user' do
      let(:album) { create(:album_with_photos, photos_count: 10) }
      before(:example) { create(:interrelationship, follower: current_user, followed: album.user) }
      before(:each) { request_exec }

      it "get 'index'" do
        expect(response).to render_template("index")
      end

      it "get 10 photos in desc order to @feed_photos" do
        expect(assigns(:feed_photos)).to eq(current_user.feed_photos.order(created_at: 'desc').includes(album: :user).first(10))
      end
    end
  end
end
