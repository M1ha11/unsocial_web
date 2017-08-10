require 'rails_helper'

RSpec.describe Notifications::NotifyFollower do
  include Rails.application.routes.url_helpers
  describe '#notify' do
    let(:interrelationship) { create(:interrelationship) }
    subject { described_class.new(interrelationship) }
    let(:receiver) { interrelationship.followed }
    let(:transmitter) { interrelationship.follower }
    let(:channel) { class_double("ActivityChannel").as_stubbed_const }
    let(:mailer) { class_double("EventsMailer").as_stubbed_const }
    before(:each) { allow(mailer).to receive_message_chain(:follower_mail, :deliver_later) { 'test' } }
    let(:transmitter_params) { { name: transmitter.display_name,
                                 avatar: transmitter.avatar.url,
                                 text: 'Now following you',
                                 url: user_path(transmitter) } }
    context 'new valid interrelationship created' do
      it 'sends a notification over ActionCable' do
        expect(channel).to receive(:broadcast_to).with(receiver, transmitter_params)
        subject.notify
      end

      it 'sends an email notification' do
        expect(mailer).to receive(:follower_mail).with(transmitter, receiver)
        expect(mailer).to receive_message_chain(:follower_mail, :deliver_later)
        subject.notify
      end
    end

    context 'new invalid interrelationship created' do
      before(:each) { interrelationship.follower = interrelationship.followed }

      it 'do not sends a notification over ActionCable' do
        expect(channel).to_not receive(:broadcast_to).with(receiver, transmitter_params)
        subject.notify
      end

      it 'do not sends an email notification' do
        expect(mailer).to_not receive(:follower_mail).with(transmitter, receiver)
        subject.notify
      end
    end
  end
end

