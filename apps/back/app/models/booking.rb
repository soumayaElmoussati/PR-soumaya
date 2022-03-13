require 'slack-notifier'

class Booking < ApplicationRecord
  belongs_to :client
  belongs_to :offer
  has_many :reviews, dependent: :destroy
  has_many :farmer_reviews, dependent: :destroy


  COMMISSION = 0.05
  SERVICE_FEE = 0.12

  enum status: [
    :pending,
    :confirmed,
    :declined,
    :cancelled,
    :finished,
    :payed,
    :withdraw,
    :unpaid,
    :expired,
    :other_booking_paid,
    :withdraw_agri,
    :withdraw_client,
    :allSet,
    :in_progress
  ]

  validate :min_days
  validates :client, presence: true
  validates :offer, presence: true
  validates :people_count, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1
  }

  scope :to_display, -> { where(status: [:confirmed, :payed, :finished, :expired, :allSet]) }

  scope :available, ->(arrival_date, departure_date){ 
    outside_of(arrival_date, departure_date).not_pending(arrival_date, departure_date) 
  }

  scope :outside_of, ->(arrival_date, departure_date){ 
    where("arrival_date <= ? and departure_date >= ?", arrival_date, departure_date) 
  }

  scope :not_pending, ->(arrival_date, departure_date){ 
    where.not("arrival_date >= ? and departure_date <= ? and status != ?", arrival_date, departure_date, 0)
  }

  before_create :update_calculus, :update_stripe

  after_create :notify_slack, :send_booking_details, :check_external_channel

  before_update :update_stripe, :notify_slack_update
  
  before_update :send_booking_confirmed,
    :if => proc { status_changed? && status_was == "pending" && status == "confirmed" }
  before_update :update_stripe,
    :if => proc { status_changed? && status_was == "pending" && status == "confirmed" }
  before_update :send_booking_declined,
    :if => proc { status_changed? && status_was == "pending" && status == "declined" }
  before_update :send_booking_cancelled_farmer,
    :if => proc { status_changed? && status_was == "pending" && status == "cancelled"}
  before_update :send_booking_expired,
    :if => proc { status_changed? && status_was == "pending" && status == "expired"}
  before_update :send_booking_other_booking_paid,
    :if => proc { status_changed? && status_was == "pending" && status == "other_booking_paid"},
    :if => proc { status_changed? && status_was == "confirmed" && status == "other_booking_paid" }
  before_update :send_booking_unpaid,
    :if => proc { status_changed? && status_was == "confirmed" && status == "unpaid" }
  before_update :send_booking_payed, :count_promo, :stay_reminder,
    :if => proc { status_changed? && status_was == "confirmed" && status == "payed" }
  before_update :send_withdraw_farmer,
    :if => proc { status_changed? && status_was == "confirmed" && status == "withdraw_agri" }
  before_update :send_withdraw_farmer,
    :if => proc { status_changed? && status_was == "payed" && status == "withdraw_agri" }
  before_update :send_withdraw_client,
    :if => proc { status_changed? && status_was == "payed" && status == "withdraw_client" }
  before_update :send_withdraw_client,
    :if => proc { status_changed? && status_was == "allSet" && status == "withdraw_client" }
  before_update :send_stay_finished,
    :if => proc { status_changed? && status_was == "payed" && status == "finished" }
  before_update :send_stay_manager_finished,
    :if => proc { status_changed? && status_was == "allSet" && status == "finished"}
  before_update :add_booking_into_event,
    :if => proc { status_changed? && status_was == "pending" && status == "confirmed" }

  # MANAGED OFFER BOOKING NOTIFICATION
  before_update :send_manager_confirmed,
    :if => proc { status_changed? && status_was == "pending" && status == "confirmed"}
  before_update :send_manager_payed,
    :if => proc { status_changed? && status_was == "confirmed" && status == "payed"}
  before_update :send_manager_allSet,
    :if => proc { status_changed? && status_was == "payed" && status == "allSet"}
  before_update :send_cancelled,
    :if => proc { status_changed? && status_was == "payed" && status == "cancelled"}
  before_update :send_manager_cancelled,
    :if => proc { status_changed? && status_was == "allSet" && status == "cancelled"}

  # Increment promocode count if a promo is used
  def count_promo
    if self.promo_code != nil && self.status == "payed"
      @promotion = Promocode.find_by(code: self.promo_code.upcase, state: true)
      if @promotion
        @promotion.increment!(:count)
        if @promotion.count >= @promotion.max_usage
          @promotion.update(state: false)
        end
      end
    end 
  end

  # Booking added by external channel/platform
  def check_external_channel
    if self.managed
      self.update(status: "payed")
      BookingMailer.with(booking: self, client: self.client).manager_payed_farmer.deliver_later
      BookingMailer.with(booking: self, client: self.client).external_payed_client.deliver_later
    end
  end

  # Booking details on unmanaged booking
  def send_booking_details
    if self.offer.manager == false
      SmsJob.perform_later("
        #Réservation AgriVillage#
        Bonjour, un client a réservé votre hébergement! Rdv sur votre page pour accepter ou refuser:
        https://bit.ly/34BwmJu
        A très vite sur AgriVillage", self.offer.farmer.user.cellphone)
      BookingMailer.with(booking: self, client: self.client).booking_details_farmer.deliver_later
    end
    if self.managed == false
      BookingMailer.with(booking: self, client: self.client).booking_details_client.deliver_later
    end
  end

  # Unmanaged booking confirmed notifications
  def send_booking_confirmed
    if self.offer.manager == false
      BookingMailer.with(booking: self, client: self.client).booking_confirmed_farmer.deliver_later
      BookingMailer.with(booking: self, client: self.client).booking_confirmed_client.deliver_later
    end
    SmsJob.perform_later("
      #Réservation AgriVillage#
      Bonjour, votre hôte a validé votre demande ! Vous avez 24h pour procéder au paiement. Sans cela votre demande sera annulée. Rdv sur https://bit.ly/3nCPjmC", self.contact_number||self.client.user.cellphone)
  end

  # Unmanaged booking declined notifications
  def send_booking_declined
    if self.offer.manager == false
      BookingMailer.with(booking: self, client: self.client).booking_declined_farmer.deliver_later
    end
    SmsJob.perform_later("
      #Annulation AgriVillage#
      Bonjour, le logement que vous avez réservé est indisponible. Il existe surement d’autres offres!
      https://bit.ly/3rhPnui
      A très vite sur AgriVillage", self.contact_number||self.client.user.cellphone)
    BookingMailer.with(booking: self, client: self.client).booking_declined_client.deliver_later
  end

  # Unmanaged booking payed notifications
  def send_booking_payed
    if self.offer.manager == false
      SmsJob.perform_later("
        #Réservation AgriVillage# 
        Bonjour, votre visiteur a validé et payé sa réservation! Nous vous avons envoyé un mail avec tout le détail de son séjour ainsi que ses coordonées.", self.offer.farmer.user.cellphone)
      BookingMailer.with(booking: self, client: self.client).booking_payed_farmer.deliver_later
      BookingMailer.with(booking: self, client: self.client).booking_payed_client.deliver_later
    end
  end

  # Unmanaged booking unpaid notifications
  def send_booking_unpaid
    if self.offer.manager == false
      SmsJob.perform_later("
        #Réservation AgriVillage#
        Bonjour, le visiteur n'a pas effectué le paiement pour valider sa réservation. Elle a donc été annulée.", self.offer.farmer.user.cellphone)
      BookingMailer.with(booking: self, client: self.client).booking_unpaid_farmer.deliver_later
    end
    SmsJob.perform_later("
      #Réservation AgriVillage#
      Bonjour, vous n'avez pas validé votre réservation. Elle a donc été annulée pour que le logement ne soit pas bloqué inutilement. Si vous souhaitez tout de même partir dans une ferme, merci de refaire une demande de réservation.", self.contact_number||self.client.user.cellphone)
    BookingMailer.with(booking: self, client: self.client).booking_unpaid_client.deliver_later
  end

  # Reminder before client stay begin
  def stay_reminder
    waiting_time = (self.arrival_date - 2.days).to_i
    hours_range = (waiting_time - Time.zone.now.to_i) / 3600

    if hours_range.negative?

      BookingMailer.with(booking: self, client: self.client).stay_reminder_farmer.deliver_later
      SmsJob.perform_later("
        #Séjour AgriVillage#
        Bonjour, vos visiteurs arrivent dans quelques jours ! Heure d’arrivée, activité, itinéraire…n’hésitez pas à le contacter!
        A très vite sur AgriVillage", self.offer.farmer.user.cellphone)
      BookingMailer.with(booking: self, client: self.client).stay_reminder_client.deliver_later
      SmsJob.perform_later("
        #Séjour AgriVillage#
        Bonjour, votre départ approche! N’hésitez pas à contacter l’hôte pour confirmer l’heure d’arrivée et poser des questions.
        Bon séjour!
        A très vite sur AgriVillage", self.contact_number||self.client.user.cellphone)
    
    else

      BookingMailer.with(booking: self, client: self.client).stay_reminder_farmer.deliver_later(wait_until: hours_range.hours.from_now)
      SmsJob.set(wait_until: hours_range.hours.from_now).perform_later("
        #Séjour AgriVillage#
        Bonjour, vos visiteurs arrivent dans quelques jours ! Heure d’arrivée, activité, itinéraire…n’hésitez pas à le contacter!
        A très vite sur AgriVillage", self.offer.farmer.user.cellphone)
      BookingMailer.with(booking: self, client: self.client).stay_reminder_client.deliver_later(wait_until: hours_range.hours.from_now)
      SmsJob.set(wait_until: hours_range.hours.from_now).perform_later("
        #Séjour AgriVillage#
        Bonjour, votre départ approche! N’hésitez pas à contacter l’hôte pour confirmer l’heure d’arrivée et poser des questions.
        Bon séjour!
        A très vite sur AgriVillage", self.contact_number||self.client.user.cellphone)

    end

  end

  # Booking expired notification
  def send_booking_expired
      SmsJob.perform_later("
        #Réservation AgriVillage# Bonjour, votre hôte n’a pas répondu à votre demande de réservation. Elle a donc été annulée. Il existe sûrement d’autres offres! https://bit.ly/3rhPnui A très vite sur AgriVillage", self.contact_number||self.client.user.cellphone)
      BookingMailer.with(booking: self, client: self.client).booking_expired_client.deliver_later
  end

  # Booking unmanaged cancelled notification
  def send_booking_cancelled_farmer
    if self.offer.manager == false
      SmsJob.perform_later("
        Bonjour #{self.offer.farmer.full_name}, #{self.client.full_name} a finalement annulé sa demande de réservation. Elle n'est donc plus effective et sera effacée de votre espace personnel AgriVillage", self.offer.farmer.user.cellphone)
      BookingMailer.with(booking: self, client: self.client).booking_cancelled_farmer.deliver_later
    end
  end

  # Booking unmanaged notification if another booking for this stay is paid
  def send_booking_other_booking_paid
    if self.offer.manager == false
      BookingMailer.with(booking: self, client: self.client).booking_other_booking_paid_farmer.deliver_later
    end
  end

  # Booking notification when the stay is done
  def send_stay_finished
    # SmsJob.perform_later("
    #   #Réservation AgriVillage#
    #   Bonjour, nous espérons que l'accueil de votre visiteur AgriVillages s'est déroulé au mieux ! Nous vous avons envoyé une petit enquête par mail pour avoir votre retour ;) Merci de nous aider à grandir", self.offer.farmer.user.cellphone)
    BookingMailer.with(booking: self, client: self.client).stay_finished_farmer.deliver_later
    SmsJob.perform_later("#Réservation AgriVillage#
      Bonjour #{self.client.full_name}, Vous pouvez désormais donner
      votre avis via une enquête de satisfaction très rapide.
      Pour partager votre expérience chez #{self.offer.farmer.full_name} du #{self.arrival_date.strftime("%d/%m/%Y")} à #{self.departure_date.strftime("%d/%m/%Y")}, c’est par ici: https://www.agrivillage.fr/#{self.id}/new-review
      Merci de nous aider à grandir ! A bientôt chez AgriVillage !", self.contact_number||self.client.user.cellphone)
    BookingMailer.with(booking: self, client: self.client).stay_finished_client.deliver_later
  end

  def send_stay_manager_finished
    SmsJob.perform_later("
      #Réservation AgriVillage#
      Bonjour, nous espérons que l'accueil de votre visiteur AgriVillages s'est déroulé au mieux ! Nous vous avons envoyé une petit enquête par mail pour avoir votre retour ;) Merci de nous aider à grandir", self.offer.farmer.user.cellphone)
    BookingMailer.with(booking: self, client: self.client).stay_finished_farmer.deliver_later
    SmsJob.perform_later("
      #Réservation AgriVillage#
      Bonjour, nous éspérons que votre séjour AgriVillage vous a mis des étoiles plein les yeux ! Nous vous avons envoyé une petite enquête par mail pour avoir votre retour ;) Merci de nous aider à grandir", self.contact_number||self.client.user.cellphone)
    BookingMailer.with(booking: self, client: self.client).stay_finished_client.deliver_later
  end

  # Booking withdraw if client cancel the booking
  def send_withdraw_client
    SmsJob.perform_later("
      #AgriVillage#
      Bonjour, un visiteur a dû annuler sa réservation. Nous nous chargerons du remboursement. Nous mettrons aussi votre hébergement en avant.
      A très vite sur AgriVillage", self.offer.farmer.user.cellphone)
    BookingMailer.with(booking: self, client: self.client).stay_withdraw_client_farmer.deliver_later
    BookingMailer.with(booking: self, client: self.client).stay_withdraw_client_client.deliver_later
  end

  # Booking withdraw if farmer cancel the booking
  def send_withdraw_farmer
    if self.offer.manager == false
      BookingMailer.with(booking: self, client: self.client).stay_withdraw_farmer_farmer.deliver_later
    end
    SmsJob.perform_later("
      #AgriVillage#
      Bonjour, quel dommage l'agriculteur a dû annuler la réservation. Nous vous rembourserons le paiement sous 2 jours. D'autres offres existent! https://bit.ly/3rhPnui
      A très vite sur AgriVillage", self.contact_number||self.client.user.cellphone)
    BookingMailer.with(booking: self, client: self.client).stay_withdraw_farmer_client.deliver_later
  end

  # MANAGED BOOKING NOTIFICATION

  def send_manager_confirmed
    if self.offer.manager == true
      BookingMailer.with(booking: self, client: self.client).manager_confirmed_client.deliver_later
    end
  end

  def send_manager_payed
    if self.offer.manager == true
      BookingMailer.with(booking: self, client: self.client).manager_payed_client.deliver_later
      BookingMailer.with(booking: self, client: self.client).manager_payed_farmer.deliver_later
    end
  end

  def send_manager_allSet
    if self.annexe_services_total > 0 && self.offer.manager == true
      BookingMailer.with(booking: self, client: self.client).manager_allSet_client.deliver_later
      BookingMailer.with(booking: self, client: self.client).manager_allSet_farmer.deliver_later
    end
  end

  def send_cancelled
    BookingMailer.with(booking: self, client: self.client).manager_cancelled_farmer.deliver_later
  end

  def send_manager_cancelled
    if self.offer.manager == true
      BookingMailer.with(booking: self, client: self.client).manager_cancelled_farmer.deliver_later
    end
  end
  
  # Create event on Offer calendar if the booking is payed
  def add_booking_into_event
    offer = Offer.find(self.offer_id)
    offer.events.create(arrival_date: self.arrival_date , departure_date: self.departure_date - 1.day, booking_id: self.id, status: 'booked')
  end

  # BOOKING CALCULUS

  # Returns the total price
  def total_calculus

    if self.promo_code != nil
      @promotion = Promocode.find_by(code: self.promo_code.upcase, state: true)
    end

    if @promotion != nil
        final_price = (self.service_fee + self.occupancy_tax_calculus + self.sub_total_calculus) - (@promotion.amount * 100)
        if final_price.negative?
          final_price = 0
        end
    else
      final_price = (self.service_fee + self.occupancy_tax_calculus + self.sub_total_calculus)
    end
    return final_price
  end

  # Returns the sum of all the periods for the booking
  def offer_period_price_calculus
    period_price = 0

    if !self.offer.offer_price_periods.nil? && self.offer.offer_price_periods.count > 0
      self.offer.offer_price_periods.each do |period|
        overlap_with_dates = (period.start_date.to_date..period.end_date.to_date).overlaps?(self.arrival_date.to_date..self.departure_date.to_date)
        if overlap_with_dates
          period_days = (period.start_date.to_date..period.end_date.to_date).to_a
          booking_days = (self.arrival_date.to_date..self.departure_date.to_date).to_a
          overlap_days = (period_days & booking_days).count

          period_price += overlap_days * period.price_period
        end
      end
    end

    return period_price
  end

  # Check if Booking is inside price period
  def check_season

    self.offer.offer_price_periods.each do |saison|
      overlap = (saison.start_date.to_date..saison.end_date.to_date).overlaps?(arrival_date.to_date..departure_date.to_date)
      if overlap == true
        return saison
      end
    end

  end

  # Returns either the offer price or the price with the price periods
  def offer_base_price_calculus
    if offer_period_price_calculus != 0
      # If there are price periods in the offer
      if check_season
        period_days = (check_season.start_date.to_date..check_season.end_date.to_date).to_a
        booking_days = (arrival_date.to_date..departure_date.to_date).to_a
        overlap_days = ((period_days & booking_days).count) - 1
        if self.days_offset - overlap_days > 0
          price = ((overlap_days * check_season.price_period) + ((self.days_offset - overlap_days) * self.offer.price_per_person)) / self.days_offset
        else
          price = (overlap_days * check_season.price_period)  / self.days_offset
        end
        return price
      else
        return self.offer.price_per_person
      end
    else
      return self.offer.price_per_person
    end
  end

  # Returns the offer price according to the number of peoples for the booking
  def lodging_cost_calculus
    base_price = self.offer_base_price_calculus * self.days_offset

    if self.people_count > self.offer.people_count
      # If the booking people count is greater than the maximum people count of the offer
      # We apply the special additional_traveler_price for the exceeding people count
      exceeding_people_count = self.people_count - self.offer.people_count
      extra_people_price = exceeding_people_count * self.offer.additional_traveler_price * self.days_offset

      return base_price + extra_people_price + self.weekend_price_calculus
    else
      return base_price + self.weekend_price_calculus
    end
  end

  # Basic commission fee = 5% (French Taxe de séjour)
  def commission_calculus
    discounts = self.offer.offer_price_discounts
    if discounts.count > 0
      com = ((self.lodging_cost_calculus - self.discount_price_calculus) * COMMISSION).to_i
    else
      com = (self.lodging_cost_calculus * COMMISSION).to_i
    end
    if self.offer.manager
      return 0
    else
      return com
    end
  end

  # Basic service fee is 12% (AgriVillage commission)
  def service_fee_calculus
    if self.offer.manager
      return 0
    else
      return (self.sub_total_calculus * SERVICE_FEE).to_i
    end
  end

  # Returns the occupancy tax (per people per day)
  def occupancy_tax_calculus
    if !self.offer.tourist_tax.nil? && self.offer.tourist_tax != 0 && self.offer.manager
      return self.offer.tourist_tax * self.people_count * self.days_offset
    else
      return 0
    end
  end

  # Returns the discount price according to the offer's discounts
  def discount_price_calculus

    # Check if the booking is in price period
    has_dates_in_price_period = false
    allow_discount = true
    if !self.offer.offer_price_periods.nil? && self.offer.offer_price_periods.count > 0
      self.offer.offer_price_periods.each do |period|
        overlap_with_dates = (period.start_date.to_date..period.end_date.to_date).overlaps?(self.arrival_date.to_date..self.departure_date.to_date)
        if overlap_with_dates
          has_dates_in_price_period = true
          if !period.use_discount
            allow_discount = false
          end
        end
      end
    end

    # Check if the price period allow discount
    if has_dates_in_price_period && !allow_discount
      return 0
    end

    # Find the discount how is the nearest of days offset
    discounts = self.offer.offer_price_discounts

    available_discounts  = []

    if discounts.count > 0

      self.offer.offer_price_discounts.each do |discount|

        if discount.min_nights != nil && discount.min_nights <= self.days_offset

          available_discounts << discount.min_nights
          
        end

      end

      if available_discounts.any?
        final_discount = OfferPriceDiscount.find_by(offer: self.offer, min_nights: available_discounts.max)
        return (self.lodging_cost_calculus * final_discount.percentage_discount) / 100
      else
        return 0
      end

    else
      return 0
    end
  end


  # Returns the total price for the services for every people
  def services_price_calculus
    if !self.offer.offer_service.nil?
      if self.offer.offer_service.breakfast?
        if self.offer.offer_service.breakfastopt?
          if self.breakfast_opt? && self.offer.offer_service.breakfast_price.present?
            total_breakfast = self.offer.offer_service.breakfast_price * self.people_count * self.days_offset
          else
            total_breakfast = 0
          end
        else
          total_breakfast = self.offer.offer_service.breakfast_price * self.people_count * self.days_offset
        end
      else
        total_breakfast = 0
      end
      if self.offer.offer_service.linens?
        if self.offer.offer_service.linensopt?
          if self.linens_opt? && self.offer.offer_service.linens_price.present?
            total_linens = self.offer.offer_service.linens_price * self.people_count
          else
            total_linens = 0
          end
        else
          total_linens = (self.offer.offer_service.linens_price * self.people_count) || 0
        end
      else
        total_linens = 0
      end
      if self.offer.offer_service.cleaning?
        if self.offer.offer_service.cleaningopt?
          if self.cleaning_opt? && self.offer.offer_service.cleaning_price.present?
            total_cleaning = self.offer.offer_service.cleaning_price
          else
            total_cleaning = 0
          end
        else
          total_cleaning = self.offer.offer_service.cleaning_price
        end
      else
        total_cleaning = 0
      end
      total_all = total_breakfast + total_linens + total_cleaning
      return total_all
    else
      return 0
    end
  end

  # Breakfast price calculus
  def breakfast_price_calculus
    if !self.offer.offer_service.nil?
      if self.offer.offer_service.breakfast?
        if self.offer.offer_service.breakfastopt?
          if self.breakfast_opt? && self.offer.offer_service.breakfast_price.present?
            total_breakfast = self.offer.offer_service.breakfast_price * self.people_count * self.days_offset
          else
            total_breakfast = 0
          end
        else
          total_breakfast = self.offer.offer_service.breakfast_price * self.people_count * self.days_offset
        end
      else
        total_breakfast = 0
      end
      return total_breakfast
    else
      return 0
    end
  end

  # Linens price calculus
  def linens_price_calculus
    if !self.offer.offer_service.nil?
      if self.offer.offer_service.linens?
        if self.offer.offer_service.linensopt?
          if self.linens_opt? && self.offer.offer_service.linens_price.present?
            total_linens = self.offer.offer_service.linens_price * self.people_count
          else
            total_linens = 0
          end
        else
          total_linens = (self.offer.offer_service.linens_price * self.people_count) || 0
        end
      else
        total_linens = 0
      end
      return total_linens
    else
      return 0
    end
  end

  # Cleaning price calculus
  def cleaning_price_calculus
    if !self.offer.offer_service.nil?
      if self.offer.offer_service.cleaning?
        if self.offer.offer_service.cleaningopt?
          if self.cleaning_opt? && self.offer.offer_service.cleaning_price.present?
            total_cleaning = self.offer.offer_service.cleaning_price
          else
            total_cleaning = 0
          end
        else
          total_cleaning = self.offer.offer_service.cleaning_price
        end
      else
        total_cleaning = 0
      end
      return total_cleaning
    else
      return 0
    end
  end

  # Returns the total price for all the weekends if required by the offer
  def weekend_price_calculus
    if !self.offer.offer_price_weekend.nil?
      if !self.offer.offer_price_weekend.price.nil? && self.offer.offer_price_weekend.price > 0 && self.days_offset < 3
        days_offset = (self.arrival_date.to_datetime..self.departure_date.to_datetime).to_a.select { |date| date.on_weekend? }.count
        # Find the number of weekend days from the arrival to the departure
        sup_weekend = (((self.offer.offer_price_weekend.price * 100) * days_offset) - (days_offset * self.offer_base_price_calculus))
        if offer_period_price_calculus != 0
          # If there are price periods in the offer
          period = self.offer.offer_price_periods.last
          overlap = (period.start_date.to_date..period.end_date.to_date).overlaps?(arrival_date.to_date..departure_date.to_date)
          if overlap
            return 0
          else
            return sup_weekend
          end
        else
          return sup_weekend
        end
      else
        return 0
      end
    else
      return 0
    end
  end

  # Returns amount of farmer deposit
  def deposit_calculus
    return self.sub_total - self.commission_fee
  end

  # Calculus before taxes
  def sub_total_calculus
    return (self.lodging_cost_calculus - self.discount_price_calculus) + self.services_price_calculus
  end

  # Stripe checkout payment session 
  def create_session

    if Rails.env != "production"
      api_key = 'sk_test_Rn5msomXPxHV2Y5ynnVopH3t'
    else
      api_key = 'sk_live_5yu6ZXc5hWG25fp2PXCJ7eDu004rx8VS3Q'
    end

    Stripe.api_key = api_key

    if Rails.env == "development"
      success = "http://localhost:8080/booking/#{self.id.to_s}"
      failure = 'http://localhost:8080/dashboard/client-bookings'
    elsif Rails.env == "staging"
      success = "https://www.staging.agrivillage.fr/booking/#{self.id.to_s}" 
      failure = 'https://www.staging.agrivillage.fr/dashboard/client-bookings'
    elsif Rails.env == "production"
      success = "https://www.agrivillage.fr/booking/#{self.id.to_s}" 
      failure = 'https://www.agrivillage.fr/dashboard/client-bookings'
    end

    if self.offer.farmer.payments_authorisation.blank? || self.total <= 0

      return nil

    else

      lodging = "Logement: " + (self.lodging_cost / 100).to_s + "€,"
      breakfast = "Petit Déjeuner: " + (self.breakfast_total / 100).to_s + "€,"
      linens = "Linge de lit: " + (self.linens_total / 100).to_s + "€,"
      cleaning = "Ménage: " + (self.cleaning_total / 100).to_s + "€,"
      services = "Services: " + (self.total_services / 100).to_s + "€,"
      frais = "Frais: " + (self.service_fee / 100).to_s + "€,"
      tax = "Taxe: " + (self.occupancy_tax / 100).to_s + "€,"
      total = "Total: " + (self.total / 100).to_s + "€,"
      people = "Pour " + self.people_count.to_s + " personnes,"
      dates = "Du " + self.arrival_date.strftime("%d/%m/%Y") + " au " + self.departure_date.strftime("%d/%m/%Y")

      agrivillage_fees =  (self.commission_fee + self.service_fee + self.occupancy_tax)

      if self.offer.manager

        session = Stripe::Checkout::Session.create({
          payment_method_types: ['card'],
          line_items: [{
            name: self.offer.name,
            amount: self.total,
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
            name: self.offer.name,
            amount: self.total,
            currency: 'eur',
            quantity: 1,
            description: lodging + ' ' + breakfast + ' ' + linens + ' ' + cleaning + ' ' + services + ' ' + frais + ' ' + tax + ' ' + total + ' ' + people + ' ' + dates
          }],
          payment_intent_data: {
            application_fee_amount: agrivillage_fees,
            transfer_data: {
              destination: self.offer.farmer.stripe_user_id,
            },
          },
          success_url: success,
          cancel_url: failure,
        })


      end

      return session.id

    end

  end

  # Returns the number of days between the arrival date and the departure date
  def days_offset
    (self.departure_date - self.arrival_date).to_i / 86400
  end

  private

  def notify_slack
    CreateBookingJob.perform_later(self)
  end

  def notify_slack_update
    if self.status_changed?
      UpdateBookingJob.perform_later(self)
    end
  end

  def min_days
    if !self.managed

      min_days = self.offer.min_days
      # Loop through every price period to find the greater "min_days"
      # that match the selected period
      greatest_min_days = min_days
      if !self.offer.offer_price_periods.nil? && self.offer.offer_price_periods.count > 0
        self.offer.offer_price_periods.each do |period|
          overlap_with_dates = (period.start_date.to_date..period.end_date.to_date).overlaps?(self.arrival_date.to_date..self.departure_date.to_date)
          if overlap_with_dates
            greatest_min_days = greatest_min_days > period.min_days ? greatest_min_days : period.min_days
          end
        end
      end

      if days_offset < greatest_min_days
        errors.add(:arrival_date, "must have #{greatest_min_days} days between both dates")
        errors.add(:departure_date, "must have #{greatest_min_days} days between both dates")
      end

    end
  end

  def update_calculus
    if !self.managed
      self.commission_fee = commission_calculus
      self.service_fee = service_fee_calculus
      self.total_services = services_price_calculus
      self.breakfast_total = breakfast_price_calculus
      self.cleaning_total = cleaning_price_calculus
      self.linens_total = linens_price_calculus
      self.offer_price_per_night = offer_base_price_calculus
      self.lodging_cost = lodging_cost_calculus
      self.occupancy_tax = occupancy_tax_calculus
      self.sub_total = sub_total_calculus
      self.farmer_deposit = deposit_calculus
      self.total = total_calculus
    end
  end

  def update_stripe
    self.stripe_token = create_session
  end

end
