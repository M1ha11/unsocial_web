# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ApplicationRecord
  has_many :taggings
  has_many :albums, through: :taggings, source: :taggable, source_type: 'Album', dependent: :destroy
  has_many :photos, through: :taggings, source: :taggable, source_type: 'Photo', dependent: :destroy

  validates :content, format: { with: /\A[a-zA-Z]{1,20}\z/ }, uniqueness: true
end
