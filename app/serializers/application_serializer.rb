class ApplicationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  def object_type
    object.class.name
  end
end
