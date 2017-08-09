require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  login_user

  describe "POST #create" do
    let(:user) { current_user }
    let(:album) { create(:album, user: user) }
    let(:photo) { create(:photo, album: album) }
    let(:comment_attributes) { FactoryGirl.attributes_for(:comment) }
    let(:request_exec) { post :create, params: { user_id: user.id, album_id: album.id, photo_id: photo.id,
                                                 comment: comment_attributes }, xhr: true }
    let(:comment) { Comment.last }
    let(:notification) { class_double("Notifications::NotifyComment").as_stubbed_const }
    before(:each) { allow(notification).to receive_message_chain(:new, :notify) { 'test' } }

    context 'successful create' do
      include_examples "assign variables", :user, :album, :photo

      it "creates the @comment" do
        expect{ request_exec }.to change{ Comment.count }.by(1)
        expect(assigns(:comment)).to eq(comment)
      end

      it 'notify photo user' do
        expect(notification).to receive_message_chain(:new, :notify)
        request_exec
      end

      it "responds with JS" do
        request_exec
        expect(response.content_type).to eq("text/javascript")
        expect(response).to render_template("comments/create")
      end
    end

    context 'unsuccessful create' do
      let!(:comment_attributes_invalid) { comment_attributes[:content] = '' }
      let(:request_exec) { post :create, params: { user_id: user.id, album_id: album.id, photo_id: photo.id,
                                                   comment: comment_attributes }, xhr: true }

      include_examples "assign variables", :user, :album, :photo

      it "doesn't create the @comment" do
        expect{ request_exec }.to_not change{ Comment.count }
      end

      it "doesn't notify photo user" do
        expect(notification).to_not receive(:new)
        request_exec
      end

      it "responds with JS" do
        request_exec
        expect(response).to render_template('comments/create')
      end
    end
  end

  describe "DELETE #destroy" do
    let(:user) { current_user }
    let(:album) { create(:album, user: user) }
    let(:photo) { create(:photo, album: album) }
    let!(:comment) { create(:comment, photo: photo, user: user) }
    let(:request_exec) { delete :destroy, params: { user_id: user.id, album_id: album.id,
                                                    photo_id: photo.id, id: comment.id }, xhr: true  }
    context 'successful destroy' do
      include_examples "assign variables", :user, :album, :photo, :comment

      it "destroys the requested @comment" do
        expect{ request_exec }.to change{ Comment.count }.by(-1)
        expect(assigns(:comment).destroyed?).to eq(true)
      end

      it "render destroy comment" do
        request_exec
        expect(response.content_type).to eq("text/javascript")
        expect(response).to render_template("comments/destroy")
      end
    end

    context 'unsuccessful destroy' do
      before(:example) { allow_any_instance_of(Comment).to receive(:destroy).and_return(false) }

      include_examples "assign variables", :user, :album, :photo, :comment

      it "doesn't destroy the comment" do
        expect{ request_exec }.to_not change{ Comment.count }
        expect(assigns(:comment).destroyed?).to eq(false)
      end

      it "render destroy comment" do
        request_exec
        expect(response).to render_template("comments/destroy")
      end
    end
  end
end

