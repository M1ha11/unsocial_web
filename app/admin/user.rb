ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :role, :first_name, :last_name

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :role
    column :sign_in_count
    column :created_at
    column :confirmed_at
    actions
  end

  filter :email
  filter :role
  filter :first_name
  filter :last_name

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :first_name
      f.input :last_name
      f.input :role, as: :check_boxes
    end
    f.actions
  end
end
