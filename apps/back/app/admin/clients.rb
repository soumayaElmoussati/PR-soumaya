# frozen_string_literal: true

ActiveAdmin.register User, as: 'Client' do
  permit_params :password, :first_name, :last_name, :email, :phone, :cellphone, :birthdate, :provider, :uid, :created_at, :updated_at,
                client_attributes: %i[

                  id solvent

                ]

  controller do
    def scoped_collection
      end_of_association_chain.includes(:client).where.not(clients: { id: nil })
    end
  end

  member_action :impersonate, method: :post do
    token_details = resource.create_new_auth_token('admin')
    redirect_to "#{ENV['FRONT_DOMAIN']}/impersonate-user?#{token_details.to_query}"
  end

  action_item :help, only: :show, priority: 0 do
    link_to 'Impersonate', impersonate_admin_client_path(client), method: :post
  end


  before_create do |client|
    generated_password = Devise.friendly_token.first(8)

    client.password = generated_password
  end

  index do
    selectable_column

    column :id

    column :first_name

    column :last_name

    column :email

    column :cellphone

    column :provider

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

      row :cellphone

      row :birthdate

      row :provider

      row :uid

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

      f.inputs for: [:client, f.object.client || Client.new] do |client|
        client.input :id, as: :hidden
      end

      f.actions
    end
  end
end
