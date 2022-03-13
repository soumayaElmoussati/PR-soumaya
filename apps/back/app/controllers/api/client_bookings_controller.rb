class Api::ClientBookingsController < ApiController
  protect_from_forgery prepend: true

  before_action :set_client, only: [:index]

  def index
    if params[:status]
      @bookings = Booking.where(client_id: @client.id, status: params[:status]).order(created_at: :desc)
    else
      @bookings = Booking.where(client_id: @client.id).order(created_at: :desc)
    end

    @bookings.each do |booking|
      if booking.status == "confirmed"
        check_payment(booking)
        check_unpaid(booking)
      elsif booking.status == "pending"
        check_expired(booking)
      end
    end

    respond_to do |format|
      format.json { render template: 'bookings/index', status: :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:client_id])
    end

    def check_expired(booking)
      
      if (booking.created_at + 5.days) < Date.today
        booking.update(status: "expired")
      end

    end

    def check_unpaid(booking)
      
      if (booking.created_at + 2.days) < Date.today
        booking.update(status: "unpaid")
      end

    end

    def check_payment(booking)

      if Rails.env != "production"
        api_key = 'sk_test_Rn5msomXPxHV2Y5ynnVopH3t'
      else
        api_key = 'sk_live_5yu6ZXc5hWG25fp2PXCJ7eDu004rx8VS3Q'
      end

      if Rails.env == "development"
        success = "http://localhost:8080/booking/#{booking.id.to_s}" 
        failure = 'http://localhost:8080/dashboard/client-bookings'
      elsif Rails.env == "staging"
        success = "https://www.staging.agrivillage.fr/booking/#{booking.id.to_s}"
        failure = 'https://www.staging.agrivillage.fr/dashboard/client-bookings'
      elsif Rails.env == "production"
        success = "https://www.agrivillage.fr/booking/#{booking.id.to_s}" 
        failure = 'https://www.agrivillage.fr/dashboard/client-bookings'
      end

      Stripe.api_key = api_key

      lodging = "Logement: " + (booking.lodging_cost / 100).to_s + "€,"
      breakfast = "Petit Déjeuner: " + (booking.breakfast_total / 100).to_s + "€,"
      linens = "Linge de lit: " + (booking.linens_total / 100).to_s + "€,"
      cleaning = "Ménage: " + (booking.cleaning_total / 100).to_s + "€,"
      services = "Services: " + (booking.total_services / 100).to_s + "€,"
      if booking.service_fee != 0
        frais = "Frais: " + (booking.service_fee / 100).to_s + "€,"
      else
        frais = "Frais: Aucun"
      end
      tax = "Taxe: " + (booking.occupancy_tax / 100).to_s + "€,"
      total = "Total: " + (booking.total / 100).to_s + "€,"
      people = "Pour " + booking.people_count.to_s + " personnes,"
      dates = "Du " + booking.arrival_date.strftime("%d/%m/%Y") + " au " + booking.departure_date.strftime("%d/%m/%Y")

      agrivillage_fees =  (booking.commission_fee + booking.service_fee + booking.occupancy_tax)

      if booking.stripe_token != nil

        payment_state = Stripe::Checkout::Session.retrieve(
          booking.stripe_token
        )

        if payment_state.payment_status == "paid"
          booking.update(status: "payed")
        elsif payment_state.payment_status == "unpaid" && booking.status == "confirmed"

          if booking.offer.manager

            session = Stripe::Checkout::Session.create({
              payment_method_types: ['card'],
              line_items: [{
                name: booking.offer.name,
                amount: booking.total,
                currency: 'eur',
                quantity: 1,
                description: lodging + ' ' + breakfast + ' ' + linens + ' ' + cleaning + ' ' + services + ' ' + frais + ' ' + tax + ' ' + total + ' ' + people + ' ' + dates
              }],
              mode: 'payment',
              success_url: success,
              cancel_url: failure,
            })

          else
              
            session = Stripe::Checkout::Session.create({
              payment_method_types: ['card'],
              line_items: [{
                name: booking.offer.name,
                amount: booking.total,
                currency: 'eur',
                quantity: 1,
                description: lodging + ' ' + breakfast + ' ' + linens + ' ' + cleaning + ' ' + services + ' ' + frais + ' ' + tax + ' ' + total + ' ' + people + ' ' + dates
              }],
              payment_intent_data: {
                application_fee_amount: agrivillage_fees,
                transfer_data: {
                  destination: booking.offer.farmer.stripe_user_id,
                },
              },
              success_url: success,
              cancel_url: failure,
            })


          end

          booking.update(stripe_token: session.id)

        end

      else

        if booking.offer.manager

          session = Stripe::Checkout::Session.create({
            payment_method_types: ['card'],
            line_items: [{
              name: booking.offer.name,
              amount: booking.total,
              currency: 'eur',
              quantity: 1,
              description: lodging + ' ' + breakfast + ' ' + linens + ' ' + cleaning + ' ' + services + ' ' + frais + ' ' + tax + ' ' + total + ' ' + people + ' ' + dates
            }],
            mode: 'payment',
            success_url: success,
            cancel_url: failure,
          })
  
        else
            
          session = Stripe::Checkout::Session.create({
            payment_method_types: ['card'],
            line_items: [{
              name: booking.offer.name,
              amount: booking.total,
              currency: 'eur',
              quantity: 1,
              description: lodging + ' ' + breakfast + ' ' + linens + ' ' + cleaning + ' ' + services + ' ' + frais + ' ' + tax + ' ' + total + ' ' + people + ' ' + dates
            }],
            payment_intent_data: {
              application_fee_amount: agrivillage_fees,
              transfer_data: {
                destination: booking.offer.farmer.stripe_user_id,
              },
            },
            success_url: success,
            cancel_url: failure,
          })
  
  
        end

        booking.update(stripe_token: session.id)

      end

    end

end
