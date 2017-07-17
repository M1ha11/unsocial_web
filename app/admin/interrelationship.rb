ActiveAdmin.register Interrelationship do
  permit_params :follower_id, :followed_id
  includes :follower, :followed

  index do
    selectable_column
    id_column
    column :follower
    column :followed
    actions
  end

  filter :follower
  filter :followed

  form do |f|
    f.inputs "Interrelationship Details" do
      f.input :follower
      f.input :followed
    end
    f.actions
  end
end
