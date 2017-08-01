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

  include_examples "valid without attributes", :description

  describe '#display_name' do
    it "returns photo with id as a string" do
      expect(subject.display_name).to eql("photo ##{subject.id}")
    end
  end
end
