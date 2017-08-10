require 'rails_helper'

RSpec.describe Notifications::NotifyComment do
  include Rails.application.routes.url_helpers
  describe '#notify' do
    let(:comment) { create(:comment) }
    subject { described_class.new(comment) }
    let(:receiver) { comment.photo.album.user }
    let(:transmitter) { comment.user }
    let(:channel) { class_double("ActivityChannel").as_stubbed_const }
    let(:transmitter_params) { { name: transmitter.display_name,
                                 avatar: transmitter.avatar.url,
                                 text: 'Comment your photo',
                                 url: user_album_photo_path(receiver, comment.photo.album, comment.photo) } }
    context 'new valid comment created' do
      it 'sends a notification over ActionCable' do
        expect(channel).to receive(:broadcast_to).with(receiver, transmitter_params)
        subject.notify
      end
    end

    context 'new invalid comment created' do
      before(:each) { comment.photo.album.user = comment.user }

      it 'do not sends a notification over ActionCable' do
        expect(channel).to_not receive(:broadcast_to).with(receiver, transmitter_params)
        subject.notify
      end
    end
  end
end

