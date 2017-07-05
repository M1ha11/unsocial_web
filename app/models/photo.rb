# == Schema Information
#
# Table name: photos
#
#  id          :integer          not null, primary key
#  image       :string
#  name        :string
#  description :text
#  album_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'elasticsearch/model'

class Photo < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :album
  has_many :comments, dependent: :destroy
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  mount_uploader :image, PictureUploader
  validates_integrity_of  :image
  validates_processing_of :image

  validates :description, presence: true, length: { maximum: 140 }

  settings index: { number_of_shards: 1 } do
    mappings dynamic: "false" do
      indexes :description
      indexes :tags, type: "nested" do
        indexes :content
      end
    end
  end
end


Photo.import force: true
