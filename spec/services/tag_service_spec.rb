require 'rails_helper'

RSpec.describe TagService do
  describe "#notify" do
    shared_examples 'check tags validation' do |tags_invalid_count:, tags_valid_count:|
      context "for valid tags count #{tags_valid_count} with ivalid tags count #{tags_invalid_count}" do
        subject { described_class.new(tags) }
        let(:valid_tags) { tags_valid_count.times.map { FactoryGirl.attributes_for(:tag)[:content] } }

        let(:invalid_format_tags) { tags_invalid_count.
                                    times.map { FactoryGirl.attributes_for(:invalid_format_tag)[:content] } }
        let(:invalid_length_tags) { tags_invalid_count.
                                    times.map { FactoryGirl.attributes_for(:invalid_length_tag)[:content] } }

        context 'create new tags' do
          let(:tags) { valid_tags + invalid_format_tags + invalid_length_tags }
          it 'return only valid tags' do
            expect(subject.tags.map(&:content)).to match_array(valid_tags)
            expect(subject.tags.count).to eq(tags_valid_count)
          end
        end

        context 'update existing tags' do
          let(:existing_tags_count) { 5 }
          let!(:subject_wtih_tags) { create(:photo_with_tags, tags_count: existing_tags_count) }
          let(:existing_tags) { subject_wtih_tags.tags.map(&:content) }
          let(:tags) { valid_tags + invalid_format_tags + invalid_length_tags + existing_tags }
          let(:common_tags_count) { Tag.count}

          it 'update only correct tags' do
            begin_tags_count = Tag.count
            expect(subject.tags.map(&:content)).to match_array(valid_tags + existing_tags)
            expect(subject.tags.count).to eq(tags_valid_count + existing_tags_count)
            expect(common_tags_count).to eq(begin_tags_count + tags_valid_count)
          end
        end

        context 'update duplicates tags' do
          let(:existing_tags_count) { tags_valid_count }
          let!(:subject_wtih_tags) { create(:photo_with_tags, tags_count: existing_tags_count) }
          let(:existing_tags) { subject_wtih_tags.tags.map(&:content) }
          let(:valid_tags) { existing_tags }
          let(:tags) { valid_tags + invalid_format_tags + invalid_length_tags + existing_tags }

          it 'do not create new tags' do
            begin_tags_count = Tag.count
            expect(subject.tags.map(&:content)).to match_array(existing_tags)
            expect(subject.tags.count).to eq(existing_tags_count)
            expect(begin_tags_count).to eq(begin_tags_count)
          end
        end
      end
    end
  include_examples 'check tags validation', tags_invalid_count: 10, tags_valid_count: 3
  include_examples 'check tags validation', tags_invalid_count: 5, tags_valid_count: 0
  include_examples 'check tags validation', tags_invalid_count: 0, tags_valid_count: 7
  include_examples 'check tags validation', tags_invalid_count: 0, tags_valid_count: 0
  end
end


