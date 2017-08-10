# == Schema Information
#
# Table name: albums
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_albums_on_user_id                 (user_id)
#  index_albums_on_user_id_and_created_at  (user_id,created_at)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Album, type: :model do

  subject { build(:album) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  include_examples "invalid without attributes", :title, :user

  include_examples "invalid attributes length", { param: :title, length: 50 },
                                                { param: :description, length: 140 }

  include_examples "valid without attributes", :description

  describe 'album validity' do
    shared_examples 'check album validity' do |validity:, photo_count:|
      context "for album with #{photo_count} photos" do
        subject { build(:album_with_photos, photos_count: photo_count) }
        it "is #{validity}" do
          expect(subject.valid?).to eq(validity)
        end
      end
    end

    include_examples 'check album validity', validity: true, photo_count: 0
    include_examples 'check album validity', validity: true, photo_count: 50
    include_examples 'check album validity', validity: false, photo_count: 51
  end

  describe "#tags=" do
    let(:call) { subject.tags = [] }
    it "calls index_document on elasticsearch" do
      expect(subject).to receive_message_chain(:__elasticsearch__, :index_document).and_return("test")
      expect(call).to eq([])
    end
  end

  context 'elasticsearch index' do
    before(:each) { create(:album, title: 'unknow') }
    it 'be indexed' do
      described_class.__elasticsearch__.refresh_index!
      expect(described_class.__elasticsearch__.search('unknow').records.length).to eq(1)
    end
  end
end
