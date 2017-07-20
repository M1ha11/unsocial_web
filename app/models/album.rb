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

class Album < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 140 }

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :title
      indexes :description
      indexes :tags, type: "nested" do
        indexes :content
      end
    end
  end

  def as_indexed_json(_ = nil)
    as_json(include: { tags: { only: :content } }, except:  %i[id _id])
  end
end
