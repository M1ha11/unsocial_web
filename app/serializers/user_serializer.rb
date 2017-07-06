class UserSerializer < ApplicationSerializer
  attributes :object_type, :full_name, :avatar

  def avatar
    object.avatar.url
  end

  def full_name
    object.first_name + " " + object.last_name
  end
end
