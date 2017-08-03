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

FactoryGirl.define do
  factory :album_tagging, class: Tagging do
    association :tag, factory: :tag
    association :taggable, factory: :album
  end

  factory :photo_tagging, class: Tagging do
    association :tag, factory: :tag
    association :taggable, factory: :photo
  end
end

