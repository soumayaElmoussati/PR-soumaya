class BookingMailer < ApplicationMailer

    def booking_details_client
      @booking = params[:booking]
      @client = params[:client]

      mail(to: "#{@client.full_name} <#{@client.user.email}>", subject: "🌺 Votre demande de réservation du #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")} a été prise en compte ! 🌺") do |format|
        format.text
        format.mjml
      end
    end

    def booking_details_farmer
      @booking = params[:booking]
      @client = params[:client]

      mail(to: "#{@booking.offer.farmer.full_name} <#{@booking.offer.farmer.user.email}>", subject: "👉Une demande de réservation du #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")} est en attente de validation ! Merci de l’accepter ou de la refuser 👈") do |format|
        format.text
        format.mjml
      end
    end

    def booking_confirmed_client
      @booking = params[:booking]
      @client = params[:client]

      mail(to: "#{@client.full_name} <#{@client.user.email}>", subject: "👏 Votre demande de réservation est acceptée du #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")} ! Allez vite payer pour valider la réservation  👏") do |format|
        format.text
        format.mjml
      end
    end

    def booking_confirmed_farmer
      @booking = params[:booking]
      @client = params[:client]

      mail(to: "#{@booking.offer.farmer.full_name} <#{@booking.offer.farmer.user.email}>", subject: "👏 Vous venez d’accepter une demande de réservation du #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")} ! 👏") do |format|
        format.text
        format.mjml
      end
    end

    def booking_declined_farmer
      @booking = params[:booking]
      @client = params[:client]

      mail(to: "#{@booking.offer.farmer.full_name} <#{@booking.offer.farmer.user.email}>", subject: "⛔️ Refus de la réservation pour #{@booking.offer.name} du #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")} ⛔️") do |format|
        format.text
        format.mjml
      end
    end

    def booking_declined_client
      @booking = params[:booking]
      @client = params[:client]

      mail(to: "#{@client.full_name} <#{@client.user.email}>", subject: "😾 Votre demande de réservation du #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")} a été refusé par #{@booking.offer.farmer.full_name} ! Je suis certain qu’une autre offre vous plaira 😺") do |format|
        format.text
        format.mjml
      end
    end

    def booking_payed_client
      @booking = params[:booking]
      @client = params[:client]

      mail(to: "#{@client.full_name} <#{@client.user.email}>", subject: "🥳 Réservation confirmée pour #{@booking.offer.name} du #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")} #{@booking.people_count} personnes et paiement reçu 🥳") do |format|
        format.text
        format.mjml
      end
    end

    def booking_payed_farmer
      @booking = params[:booking]
      @client = params[:client]

      mail(to: "#{@booking.offer.farmer.full_name} <#{@booking.offer.farmer.user.email}>", subject: "🥳 Réservation confirmée pour #{@booking.offer.name} du #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")} #{@booking.people_count} personnes et paiement bien reçu🥳") do |format|
        format.text
        format.mjml
      end
    end

    def booking_unpaid_client
      @booking = params[:booking]
      @client = params[:client]

      mail(to: "#{@client.full_name} <#{@client.user.email}>", subject: "👎 Quel dommage, votre demande de réservation du #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")} a expiré ! 👎") do |format|
        format.text
        format.mjml
      end
    end

    def booking_unpaid_farmer
      @booking = params[:booking]
      @client = params[:client]

      mail(to: "#{@booking.offer.farmer.full_name} <#{@booking.offer.farmer.user.email}>", subject: " 👎 Annulation de la demande de réservation de #{@client.full_name} du #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")} 👎") do |format|
        format.text
        format.mjml
      end
    end

    def stay_reminder_client
      @booking = params[:booking]
      @client = params[:client]

      mail(to: "#{@client.full_name} <#{@client.user.email}>", subject: "Votre séjour AgriVillage du #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")} arrive ! 🤩") do |format|
        format.text
        format.mjml
      end
    end

    def stay_reminder_farmer
      @booking = params[:booking]
      @client = params[:client]

      mail(to: "#{@booking.offer.farmer.full_name} <#{@booking.offer.farmer.user.email}>", subject: "#{@client.full_name} arrive le #{@booking.arrival_date.strftime("%d/%m/%Y")}, tenez vous prêt 🤩") do |format|
        format.text
        format.mjml
      end
    end

    def booking_expired_client
      @booking = params[:booking]
      @client = params[:client]

      mail(to: "#{@client.full_name} <#{@client.user.email}>", subject: "👎 Votre réservation Pour #{@booking.offer.name} du #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")} est expiré 👎") do |format|
        format.text
        format.mjml
      end
    end

    def booking_cancelled_farmer
      @booking = params[:booking]
      @client = params[:client]

      mail(to: "#{@booking.offer.farmer.full_name} <#{@booking.offer.farmer.user.email}>", subject: "⚠️ Réservation pour : #{@booking.offer.name} #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")} // ANNULÉE   ⚠️") do |format|
        format.text
        format.mjml
      end
    end

    def booking_other_booking_paid_farmer
      @booking = params[:booking]
      @client = params[:client]

      mail(to: "#{@booking.offer.farmer.full_name} <#{@booking.offer.farmer.user.email}>", subject: "😺 Réservation pour : #{@booking.offer.name} #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")} // n'est plus VALIDE   😺") do |format|
        format.text
        format.mjml
      end
    end

    def stay_finished_client
      @booking = params[:booking]
      @client = params[:client]

      mail(to: "#{@client.full_name} <#{@client.user.email}>", subject: "Comment s’est passé votre séjour chez #{@booking.offer.farmer.full_name} à #{@booking.offer.address.city} du #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")} ? Partagez votre avis sur AgriVillage") do |format|
        format.text
        format.mjml
      end
    end

    def stay_finished_farmer
      @booking = params[:booking]
      @client = params[:client]

      mail(to: "#{@booking.offer.farmer.full_name} <#{@booking.offer.farmer.user.email}>", subject: "Donnez votre retour sur le séjour de #{@client.full_name} du #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")}") do |format|
        format.text
        format.mjml
      end
    end

    def stay_withdraw_client_client
      @booking = params[:booking]
      @client = params[:client]

      mail(to: "#{@client.full_name} <#{@client.user.email}>", subject: "❌ Votre séjour chez #{@booking.offer.farmer.full_name} pour #{@booking.offer.name} du #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")} a été retiré ❌") do |format|
        format.text
        format.mjml
      end
    end

    def stay_withdraw_client_farmer
      @booking = params[:booking]
      @client = params[:client]

      mail(to: "#{@booking.offer.farmer.full_name} <#{@booking.offer.farmer.user.email}>", subject: "❌ Le séjour de : #{@client.full_name} pour #{@booking.offer.name} du #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")} vient d'être retiré ❌") do |format|
        format.text
        format.mjml
      end
    end

    def stay_withdraw_farmer_client
      @booking = params[:booking]
      @client = params[:client]

      mail(to: "#{@client.full_name} <#{@client.user.email}>", subject: "❌ Votre séjour chez #{@booking.offer.farmer.full_name} pour #{@booking.offer.name} du #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")} a été retiré ❌") do |format|
        format.text
        format.mjml
      end
    end

    def stay_withdraw_farmer_farmer
      @booking = params[:booking]
      @client = params[:client]

      mail(to: "#{@booking.offer.farmer.full_name} <#{@booking.offer.farmer.user.email}>", subject: "❌ Le séjour de : #{@client.full_name} pour #{@booking.offer.name} du #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")} vient d'être retiré ❌") do |format|
        format.text
        format.mjml
      end
    end

    def manager_confirmed_client
      @booking = params[:booking]
      @client = params[:client]
  
      mail(to: "#{@client.full_name} <#{@client.user.email}>", subject: "🥳 Votre réservation pour #{@booking.offer.name} du #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")} a été acceptée 🥳") do |format|
        format.text
        format.mjml
      end
    end
    
    def manager_payed_client
      @booking = params[:booking]
      @client = params[:client]
  
      mail(to: "#{@client.full_name} <#{@client.user.email}>", subject: "🤩 Vous avez réservé un séjour dans l'hebergement #{@booking.offer.name} du #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")} 🤩") do |format|
        format.text
        format.mjml
      end
    end
    
    def manager_payed_farmer
      @booking = params[:booking]
      @client = params[:client]
      @bookings = Booking.where(offer_id: @booking.offer.id, status: "payed").order(arrival_date: :asc)
  
      mail(to: "#{@booking.offer.farmer.full_name} <#{@booking.offer.farmer.user.email}>", subject: "🤩 Nouvelle réservation pour la Tiny House #{@booking.offer.name} du #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")} 🤩") do |format|
        format.text
        format.mjml
      end
    end

    def external_payed_client
      @booking = params[:booking]
      @client = params[:client]

      mail(to: "#{@client.full_name} <#{@client.user.email}>", subject: "🤩 Vous avez réservé un séjour dans l'hebergement #{@booking.offer.name} du #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")} 🤩") do |format|
        format.text
        format.mjml
      end
    end
  
    def manager_allSet_client
      @booking = params[:booking]
      @client = params[:client]
  
      mail(to: "#{@client.full_name} <#{@client.user.email}>", subject: "👈 Vous avez réservé un ou plusieurs services annexes lors de votre séjour à #{@booking.offer.name} du #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")} 👈") do |format|
        format.text
        format.mjml
      end
    end
  
    def manager_allSet_farmer
      @booking = params[:booking]
      @client = params[:client]
  
      mail(to: "#{@booking.offer.farmer.full_name} <#{@booking.offer.farmer.user.email}>", subject: "👈 #{@client.user.first_name} aimerait réserver un ou plusieurs service(s) annexe(s) du #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")} dans la tiny house #{@booking.offer.name} 👈") do |format|
        format.text
        format.mjml
      end
    end
  
    def manager_cancelled_farmer
      @booking = params[:booking]
      @client = params[:client]
  
      mail(to: "#{@booking.offer.farmer.full_name} <#{@booking.offer.farmer.user.email}>", subject: "❌ #{@client.user.first_name} vient malheureusement d'annuler sa réservation du #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")} ❌") do |format|
        format.text
        format.mjml
      end
    end
  
    def manager_in_progress_client
      @booking = params[:booking]
      @client = params[:client]
  
      mail(to: "#{@client.full_name} <#{@client.user.email}>", subject: "😎 J-5 avant votre séjour AgriVillage du #{@booking.arrival_date.strftime("%d/%m/%Y")} au #{@booking.departure_date.strftime("%d/%m/%Y")} ! 😎") do |format|
        format.text
        format.mjml
      end
    end
  
    def manager_in_progress_farmer
      @booking = params[:booking]
      @client = params[:client]
  
      mail(to: "#{@booking.offer.farmer.full_name} <#{@booking.offer.farmer.user.email}>", subject: "🎉 J-5 avant l'arrivée de #{@client.user.first_name} 🎉") do |format|
        format.text
        format.mjml
      end
    end

  end
