class Api::Offer::FarmerIncomesController < ApiController

	def index
    @offer = Offer.find(params[:offer_id])
		@incomes = FarmerIncome.where(offer: @offer.id)
		@expenses = Expense.where(offer: @offer.id)
		@bookings = Booking.where(offer: @offer.id)

		render template: 'api/offer/farmer_incomes/index'
  end

end
