class ApplicationSerializer < ActiveModel::Serializer
  def object_type
    object.class.name
  end
end
