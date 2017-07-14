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

class PhotoSerializer < ApplicationSerializer
  attributes :object_type, :tags, :image

  def tags
    object.tags.map { |tag| tag.content }
  end

  def image
    object.image.thumb.url
  end
end
