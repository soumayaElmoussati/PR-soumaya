# frozen_string_literal: true

ActiveAdmin.register User, as: 'Farmer' do
  permit_params :password, :first_name, :last_name, :email, :phone, :cellphone, :birthdate, :ambassador, :created_at, :updated_at,
                farmer_attributes: [
                  :id,
                  :description,
                  :agriculteur_de_bretagne,
                  :stripe_user_id,
                  :stripe_link,
                  :payments_authorisation
                ],
                farmer_equipment_attributes: [
                  :id,
                  :farmer_id,
                  :english,
                  :spanish,
                  :german,
                  :italian,
                  :portuguese,
                  :russian,
                  :dutch,
                  :french
                ],
                farmer_organisation_attributes: [
                  :id,
                  :farmer_id,
                  :fairefrance,
                  :bbc,
                  :adb
                ],
                cloud_profile_pictures_attributes: %i[
                  _destroy
                  id
                  farmer_id
                  public_id
                  url
                  order
                ]

  controller do
    def scoped_collection
      end_of_association_chain.includes(:farmer).where.not(farmers: { id: nil })
    end
  end

  member_action :impersonate, method: :post do
    token_details = resource.create_new_auth_token('admin')

    redirect_to "#{ENV['FRONT_DOMAIN']}/impersonate-user?#{token_details.to_query}"
  end

  action_item :help, only: :show, priority: 0 do
    link_to 'Impersonate', impersonate_admin_farmer_path(farmer), method: :post
  end

  before_create do |farmer|
    generated_password = Devise.friendly_token.first(8)
    farmer.password = generated_password
  end

  index do
    selectable_column
    column :id
    column :first_name
    column :last_name
    column :ambassador
    column :agriculteur_de_bretagne do |user|
      user.farmer.agriculteur_de_bretagne unless user.farmer.nil?
    end
    column :email
    column :phone
    column :cellphone
    column :stripe_user_id do |user|
      user.farmer.stripe_user_id unless user.farmer.nil?
    end
    column :stripe_link do |user|
      user.farmer.stripe_link unless user.farmer.nil?
    end
    column :payments_authorisation do |user|
      user.farmer.payments_authorisation unless user.farmer.nil?
    end
    column :created_at
    column :updated_at
    actions
  end


  show do
    panel "User Details" do

      attributes_table do
        row :id
        row :first_name
        row :last_name
        row :ambassador
        row :email
        row :phone
        row :cellphone
        row :birthdate
        row :agriculteur_de_bretagne do |user|
          user.farmer.agriculteur_de_bretagne unless user.farmer.nil?
        end
        row :stripe_user_id do |user|
          user.farmer.stripe_user_id unless user.farmer.nil?
        end
        row :stripe_link do |user|
          user.farmer.stripe_link unless user.farmer.nil?
        end
        row :payments_authorisation do |user|
          user.farmer.payments_authorisation unless user.farmer.nil?
        end
        row :description do |user|
          user.farmer.description unless user.farmer.nil?
        end
        row :created_at
        row :updated_at
      end

    end

    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :ambassador
      f.input :email
      f.input :phone
      f.input :cellphone
      f.input :birthdate
      f.input :password, type: :password
      f.input :password_confirmation, type: :password
      f.inputs 'Farmer', for: [:farmer, f.object.farmer || Farmer.new] do |farmer|
        farmer.input :id, as: :hidden
        farmer.input :description
        farmer.input :stripe_user_id
        farmer.input :stripe_link
      end
      f.actions
    end
  end

  csv do
    column :id
    column :first_name
    column :last_name
    column :ambassador
    column :email
    column :phone
    column :cellphone
    column :birthdate
    column :created_at
  end
end
