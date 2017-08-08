require 'rails_helper'

RSpec.describe InterrelationshipsController, type: :controller do
  login_user
  describe "POST #create" do
    let(:user) { create(:user) }
    let(:relationship) { Interrelationship.last }
    let(:request_exec) { post :create, params: { followed_id: user.id }, xhr: true }
    let(:notification) { class_double('Notifications::NotifyFollower').as_stubbed_const }

    context 'successful create' do

      it "creates the @interrelationship" do
        expect{ request_exec }.to change{ Interrelationship.count }.by(1)
        expect(assigns(:interrelationship)).to eq(relationship)
      end

      it "render create interrelationship" do
        request_exec
        expect(response.content_type).to eq("text/javascript")
        expect(response).to render_template("interrelationships/create")
      end

      it "notify followed user" do
        allow(notification).to receive_message_chain(:new, :notify) { 'test' }
        request_exec
        expect(notification.new(relationship).notify).to eq('test')
      end
    end

    context 'unsuccessful create' do
      let(:request_exec) { post :create, params: { followed_id: nil }, xhr: true }

      it "doesn't create the @interrelationship" do
        expect{ request_exec }.to_not change{ Interrelationship.count }
      end

      it "renders 'follow' template with an alert flash" do
        request_exec
        expect(response).to render_template('interrelationships/create')
      end

      it "doesn't notify followed user" do
        expect(notification).to_not receive(:new)
        request_exec
      end
    end
  end

  describe "DELETE #destroy" do
    let(:user) { create(:user) }
    let(:relationship) { Interrelationship.last }
    let!(:interrelationship) { create(:interrelationship, followed: user, follower: current_user ) }
    let(:request_exec) { delete :destroy, params: { id: interrelationship.id }, xhr: true }

    context 'successful destroy' do

      it "destroys the requested @interrelationship" do
        expect{ request_exec }.to change{ Interrelationship.count }.by(-1)
        expect(assigns(:interrelationship).destroyed?).to eq(true)
      end

      it "render destroy interrelationship" do
        request_exec
        expect(response.content_type).to eq("text/javascript")
        expect(response).to render_template("interrelationships/destroy")
      end
    end

    context 'unsuccessful destroy' do
      before(:example) { allow_any_instance_of(Interrelationship).to receive(:destroy).and_return(false) }

      it "doesn't destroy the @interrelationship" do
        expect{ request_exec }.to_not change{ Interrelationship.count }
        expect(assigns(:interrelationship).destroyed?).to eq(false)
      end

      it "render destroy interrelationship" do
        request_exec
        expect(response).to render_template("interrelationships/destroy")
      end
    end
  end
end
