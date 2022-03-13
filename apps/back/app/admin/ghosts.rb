# frozen_string_literal: true

ActiveAdmin.register User, as: 'Ghosts' do
  permit_params :password, :first_name, :last_name, :email, :phone, :cellphone, :birthdate, :created_at, :updated_at

  controller do
    def scoped_collection
      end_of_association_chain.includes(:client, :farmer).where(clients: { id: nil }, farmers: { id: nil })
    end
  end

  index do
    selectable_column

    column :id

    column :first_name

    column :last_name

    column :email

    column :phone

    column :cellphone

    column :created_at

    column :updated_at

    actions
  end

  show do
    attributes_table do
      row :id

      row :first_name

      row :last_name

      row :email

      row :phone

      row :cellphone

      row :birthdate

      row :created_at

      row :updated_at
    end

    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :first_name

      f.input :last_name

      f.input :email

      f.input :phone

      f.input :cellphone

      f.input :birthdate

      f.input :password, type: :password

      f.input :password_confirmation, type: :password

      f.actions
    end
  end
end
