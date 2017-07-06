class AlbumSerializer < ApplicationSerializer
  attributes :object_type, :title, :description, :author

  def author
    user = object.user
    user.first_name + " " + user.last_name
  end
end
