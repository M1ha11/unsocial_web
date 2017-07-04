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

class Tagging < ApplicationRecord
  belongs_to :tag
  belongs_to :taggable, polymorphic: true
end
