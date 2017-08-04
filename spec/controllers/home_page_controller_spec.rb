require 'rails_helper'

RSpec.describe HomePageController, type: :controller do
  describe "GET #index" do
    let(:request_exec) { get :index }
    context 'logged in user' do
      login_user
      let(:album) { create(:album_with_photos, photos_count: 10) }
      before(:example) { create(:interrelationship, follower: current_user, followed: album.user) }
      it "must have a current_user" do
        expect(current_user).to_not eq(nil)
      end

      it "get 'index'" do
        request_exec
        expect(response).to render_template("index")
      end

      it "get 10 photos in desc order to @feed_photos" do
        request_exec
        expect(assigns(:feed_photos)).to eq(current_user.feed_photos.order(created_at: 'desc').includes(album: :user).first(10))
      end
    end

    context 'not logged in user' do
      log_out

      it "get 'index'" do
        request_exec
        expect(response).to render_template("index")
      end
    end
  end
end
