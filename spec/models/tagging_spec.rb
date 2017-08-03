# == Schema Information
#
# Table name: taggings
#
#  id            :integer          not null, primary key
#  taggable_type :string
#  taggable_id   :integer
#  tag_id        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_taggings_on_tag_id                         (tag_id)
#  index_taggings_on_taggable_type_and_taggable_id  (taggable_type,taggable_id)
#

require 'rails_helper'

RSpec.describe Tagging, type: :model do
  subject                  { build(:album_tagging) }
  let(:existing_tagging)   { create(:album_tagging) }
  let(:tagging_with_photo) { build(:photo_tagging) }

  context "tagging with album" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
  end

  context "tagging with photo" do
    it "is valid with valid attributes" do
      expect(tagging_with_photo).to be_valid
    end
  end

  include_examples "invalid without attributes", :tag, :taggable

  it "invalid with duplicates tagging" do
    subject.taggable = existing_tagging.taggable
    subject.tag = existing_tagging.tag
    expect(subject).to_not be_valid
  end
end







