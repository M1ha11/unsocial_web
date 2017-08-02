# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :tag do
    content         { "##{Faker::Lorem.characters(10)}" }
  end

  factory :invalid_length_tag, class: Tag do
    content         { "##{Faker::Lorem.characters(21)}" }
  end

  factory :invalid_format_tag, class: Tag do
    content         { Faker::Lorem.characters(10) }
  end
end
