ActiveAdmin.register ExternalBooking do
  permit_params :uid, :start, :end, :source, :notes, :created_at, :updated_at

  index do
    selectable_column
    column :id
    column :offer do |external_booking|
      external_booking.offer
    end
    column :farmer do |external_booking|
      external_booking.offer.farmer
    end
    column :start
    column :end
    column :source
    column :notes
    column :created_at
    column :updated_at
    actions
  end

  show do
    panel "External Booking details" do
      attributes_table do
        row :id
        row :offer do |external_booking|
          external_booking.offer
        end
        row :farmer do |external_booking|
          external_booking.offer.farmer
        end
        row :uid
        row :start
        row :end
        row :source
        row :notes
        row :created_at
        row :updated_at
      end
    end
  end

  csv do
    column :id
    column(:offer) { |external_booking| external_booking.offer.name unless external_booking.offer.nil? }
    column :start
    column :end
    column :uid
    column :source
    column :notes
    column :created_at
    column :updated_at
  end

end
