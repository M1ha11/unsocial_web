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
require 'elasticsearch/model'

class Album < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 140 }

  # def self.search(query)
  #   __elasticsearch__.search(
  #     {
  #       query: {
  #         multi_match: {
  #           query: query,
  #           type: "phrase_prefix",
  #           fields: ['title'],
  #         }
  #       }
  #     }
  #   )
  # end

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :title, analyzer: 'english'
    end
  end
end

Album.import force: true
