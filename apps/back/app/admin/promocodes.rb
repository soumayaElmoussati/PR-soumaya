ActiveAdmin.register Promocode do
  permit_params :name, :amount, :state, :code, :count, :max_usage, :created_at, :updated_at

  index do
    selectable_column
    column :id
    column :state
    column :name
    column :code
    column :amount
    column :count
    column :max_usage
    column :created_at
    column :updated_at
    actions
  end

  show do
    panel "Promocode details" do
      attributes_table_for promocode do
        row :id
        row :state
        row :name
        row :code
        row :amount
        row :count
        row :max_usage
        row :created_at
        row :updated_at
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :name
      f.input :code
      f.input :amount
      f.input :state
      f.input :max_usage
      f.actions
    end
  end

end
