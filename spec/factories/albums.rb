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

FactoryGirl.define do
  factory :album do
    title                 { Faker::Name.name }
    description           { Faker::Coffee.notes }

    association :user, strategy: :build

    factory :album_with_photos do
      transient do
        photos_count 5
      end

      after(:create) do |album, evaluator|
        album.photos = build_list(:photo, evaluator.photos_count, album: album)
      end

      factory :album_with_photos_and_tags do
        transient do
          tags_count 5
        end

        after(:create) do |album, evaluator|
          album.tags = create_list(:tag, evaluator.tags_count)
        end
      end
    end
  end
end


