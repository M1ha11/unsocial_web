ActiveAdmin.register Photo do
  permit_params :image, :description, :album_id
  includes :tags, :album, :taggings

  index do
    selectable_column
    id_column
    column "Image" do |photo|
      photo
    end
    column :album
    column :description
    column "Tags" do |photo|
      photo.tags.map do |tag|
        link_to tag.content, admin_tag_path(tag.id)
      end.join(', ').html_safe
    end
    actions
  end

  filter :description
  filter :tags
  filter :album

  form do |f|
    f.inputs "Photo" do
      f.input :image
      f.input :description, input_html: { rows: 3 }
    end
    f.actions
  end
end

