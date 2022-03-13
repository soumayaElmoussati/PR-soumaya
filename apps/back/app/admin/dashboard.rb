ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Recent Bookings" do
          ul do
            Booking.last(10).map do |booking|
              li link_to(booking.client.full_name, admin_booking_path(booking))
            end
          end
        end
      end

      column do
        panel "Recent Offers" do
          ul do
            Offer.last(10).map do |offer|
              li link_to(offer.name, admin_offer_path(offer))
            end
          end
        end
      end

    end
  end # content
end
