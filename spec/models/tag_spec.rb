# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Tag, type: :model do
  subject { build(:tag) }
  let(:existing_tag) { create(:tag) }

  let(:tag_with_invalid_length) { build(:invalid_length_tag) }
  let(:tag_with_invalid_format) { build(:invalid_format_tag) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  include_examples "invalid without attributes", :content

  it "is invalid with content longer than 20" do
    expect(tag_with_invalid_length).to_not be_valid
  end

  shared_examples "invalid with characters" do |chars|
    context "characters in content" do
      chars.each do |char|
        it "content is invalid with #{char}" do
          subject.content += char
          expect(subject).to_not be_valid
        end
      end
    end
  end

  include_examples "invalid with characters", %w(. , ?  " ' | [ ] \\ / { }  ( ) & % $ @ # ^ - + = № ; : * ! ~)

  it "is invalid without # at the beginning" do
    expect(tag_with_invalid_format).to_not be_valid
  end

  it "invalid with duplicates content" do
    subject.content = existing_tag.content
    expect(subject).to_not be_valid
  end

  describe '#display_name' do
    it "returns content as a string" do
      expect(subject.display_name).to eql(subject.content)
    end
  end
end

