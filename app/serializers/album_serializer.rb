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

class AlbumSerializer < ApplicationSerializer
  attributes :object_type, :title, :description, :author

  def author
    user = object.user
    user.first_name + " " + user.last_name
  end
end
