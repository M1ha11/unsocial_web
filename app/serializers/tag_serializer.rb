# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TagSerializer < ApplicationSerializer
  attributes :id, :content

  def id
    object.content
  end
end
