# == Schema Information
#
# Table name: photos
#
#  id          :integer          not null, primary key
#  image       :string
#  description :text
#  album_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_photos_on_album_id                 (album_id)
#  index_photos_on_album_id_and_created_at  (album_id,created_at)
#
# Foreign Keys
#
#  fk_rails_...  (album_id => albums.id)
#

require 'rails_helper'

RSpec.describe Photo, type: :model do

  subject { build(:photo) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  include_examples "invalid without attributes", :image, :album

  include_examples "invalid attributes length", { param: :description, length: 140 }

  include_examples "valid without attributes", :description

  describe '#display_name' do
    it "returns photo with id as a string" do
      expect(subject.display_name).to eql("photo ##{subject.id}")
    end
  end

  describe "#tags=" do
    let(:call) { subject.tags = [] }
    it "calls index_document on elasticsearch" do
      expect(subject).to receive_message_chain(:__elasticsearch__, :index_document).and_return("test")
      expect(call).to eq([])
    end
  end

  context 'elasticsearch index' do
    before(:each) { create(:photo, description: 'test_elastic') }
    it 'be indexed' do
      described_class.__elasticsearch__.refresh_index!
      expect(described_class.__elasticsearch__.search('test_elastic').records.length).to eq(1)
    end
  end
end
