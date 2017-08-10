require 'rails_helper'

RSpec.describe Notifications::AbstractNotification do
  describe '#notify' do
    let(:notification) { described_class.new }
    it 'raises NotImplementedError' do
      expect { notification.notify }.to raise_error(NotImplementedError)
    end
  end
end
