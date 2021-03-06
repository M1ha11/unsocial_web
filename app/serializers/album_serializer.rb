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

class AlbumSerializer < ApplicationSerializer
  attributes :object_type, :url, :title, :author

  def author
    user = object.user
    user.first_name + " " + user.last_name
  end

  def url
    user_album_path(object.user, object)
  end
end
