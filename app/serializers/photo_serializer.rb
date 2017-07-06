class PhotoSerializer < ApplicationSerializer
  attributes :object_type, :tags, :image

  def tags
    object.tags.map { |tag| tag.content }
  end

  def image
    object.image.thumb.url
  end
end
