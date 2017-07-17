ActiveAdmin.register Tag do
  permit_params :content

  index do
    selectable_column
    id_column
    column :content
    actions
  end

  filter :content

  form do |f|
    f.inputs "Tag Details" do
      f.input :content
    end
    f.actions
  end
end
