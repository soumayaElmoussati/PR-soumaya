ActiveAdmin.register ActivityBooking do
  permit_params :status, :people_count, :arrival_date, :departure_date, :promo_code, :created_at, :updated_at

  index do
    selectable_column
    column :id
    column :status
    column :client do |activity_booking|
      link_to(activity_booking.client.full_name, admin_client_path(activity_booking.client.user)) unless activity_booking.client.user.nil?
    end
    column :activity
    column :people_count
    column :arrival_date
    column :departure_date
    column :promo_code
    column :comission_fee
    column :total
    column :created_at
    column :updated_at
    actions
  end

  show do
    panel "Booking details" do
      attributes_table_for activity_booking do
        row :id
        row :status
        row :client do |activity_booking|
          link_to(activity_booking.client.full_name, admin_client_path(activity_booking.client.user)) unless activity_booking.client.user.nil?
        end
        row :activity
        row :people_count
        row :arrival_date
        row :departure_date
        row :promo_code
        row :comission_fee
        row :total
        row :created_at
        row :updated_at
      end
    end
  end

end
