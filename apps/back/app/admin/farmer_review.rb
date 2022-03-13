ActiveAdmin.register FarmerReview do
  permit_params :full_name, :state, :first_name, :last_name, :cleanliness, :communication, :respect, :experience, :welcome, :state, :comment, :created_at, :updated_at

  index do
    selectable_column
    column :id
    column :full_name
    column :booking
    column :welcome
    column :state
    column :created_at
    column :updated_at
    actions
  end

  show do
    panel "Farmer Review details" do
      attributes_table_for farmer_review do
        row :id
        row :full_name
        row :booking
        row :state
        row :cleanliness
        row :communication
        row :respect
        row :experience
        row :welcome
        row :comment
        row :created_at
        row :updated_at
      end
    end

  end

  csv do
    column :id
    column :full_name
    column :booking
    column :state
    column :cleanliness
    column :communication
    column :respect
    column :experience
    column :welcome
    column :comment
    column :created_at
    column :updated_at
  end

end
