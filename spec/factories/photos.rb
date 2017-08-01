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

FactoryGirl.define do
  factory :photo do
    image                 { Rack::Test::UploadedFile.new(File.join(Rails.root, '/spec/fixtures/1x1.png'), 'image/png') }
    description           { Faker::Coffee.notes }

    association :album, strategy: :build

    factory :photo_with_tags do
      transient do
        tags_count 5
      end

      after(:build) do |photo, evaluator|
        photo.tags = build_list(:tag, evaluator.tags_count, photo: photo)
      end
    end
  end
end
