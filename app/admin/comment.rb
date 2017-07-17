ActiveAdmin.register Comment do
  permit_params :user_id, :photo_id, :content
  includes :user, :photo

  index do
    selectable_column
    id_column
    column :content
    column :user
    column :photo
    actions
  end

  filter :content
  filter :user
  filter :photo

  form do |f|
    f.inputs "Comment Details" do
      f.input :content, input_html: { rows: 3 }
      f.input :photo
      f.input :user
    end
    f.actions
  end
end
