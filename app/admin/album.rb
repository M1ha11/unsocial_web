ActiveAdmin.register Album do
  permit_params :title, :description
  includes :user, :tags

  index do
    selectable_column
    id_column
    column :user
    column :title
    column :description
    column "Tags" do |album|
      album.tags.map do |tag|
        link_to tag.content, admin_tag_path(tag.id)
      end.join(', ').html_safe
    end
    column :created_at
    column :updated_at
    actions
  end

  filter :user
  filter :title
  filter :description
  filter :tags

  form do |f|
    f.inputs "Album" do
      f.input :title
      f.input :description, input_html: { rows: 3 }
    end
    f.actions
  end
end
