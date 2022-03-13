ActiveAdmin.register Review do
  permit_params :full_name, :state, :first_name, :last_name, :star, :residence_type, :comment, :stay_date, :situation, :lodging, :activity, :services, :contact, :trip_note, :reference, :recipient, :street_name, :city, :postal_code, :country_code, :created_at, :updated_at,
  cloud_review_pictures_attributes: [
    :_destroy,
    :id,
    :review_id,
    :public_id,
    :url,
    :order
  ]

  index do
    selectable_column
    column :id
    column :full_name
    column :booking
    column :stay_date
    column :star
    column :state
    column :created_at
    column :updated_at
    actions
  end

  show do
    panel "Review details" do
      attributes_table_for review do
        row :id
        row :full_name
        row :booking
        row :state
        row :stay_date
        row :star
        row :residence_type
        row :situation
        row :lodging
        row :activity
        row :services
        row :contact
        row :process
        row :trip_note
        row :reference
        row :comment
        row :recipient
        row :street_name
        row :city
        row :postal_code
        row :country_code
        row :created_at
        row :updated_at
      end
    end

    panel "Review cloud pictures" do
        table_for review.cloud_review_pictures, sortable: :order do
          column :id
          column :order
          column :image do |image|
            cl_image_tag(image.public_id, :width => 140, :height => 90, :crop => :fill)
          end
        end
    end
  end

  csv do
    column :id
    column :state
    column :full_name
    column :booking
    column :stay_date
    column :star
    column :residence_type
    column :situation
    column :lodging
    column :activity
    column :services
    column :contact
    column :process
    column :trip_note
    column :reference
    column :comment
    column :recipient
    column :street_name
    column :city
    column :postal_code
    column :country_code
    column :created_at
    column :updated_at
  end

end
