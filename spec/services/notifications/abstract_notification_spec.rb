require 'rails_helper'

RSpec.describe Notifications::AbstractNotification do
  describe '#notify' do
    let(:notifications_service) { described_class.new }
    it 'raises NotImplementedError' do
      expect { notifications_service.notify }.to raise_error(NotImplementedError)
    end
  end
end
