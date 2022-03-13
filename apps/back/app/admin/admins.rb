ActiveAdmin.register User, as: 'Admin' do
  config.filters = false

  controller do
    def scoped_collection
      end_of_association_chain.includes(:admin).where.not(admins: {id: nil})
    end
  end

  before_create do |admin|
    generated_password = Devise.friendly_token.first(8)
    admin.password = generated_password
  end
  
  index do
    selectable_column
    column :id
    column :first_name
    column :last_name
    column :email
    actions
  end

  show do
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :email
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password, :type => :password
      f.input :password_confirmation, :type => :password
      f.inputs for: [:admin, f.object.admin || Admin.new] do |admin|
        admin.input :id, :as => :hidden
      end
      f.actions
    end
  end
end