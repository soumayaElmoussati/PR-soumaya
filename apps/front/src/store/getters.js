import differenceInDays from 'date-fns/difference_in_days'

export default {
  authenticatedUser (state) {
    return state.loggedIn
  },
  userLoggedIn (state) {
    return state.user
  },
  isFarmer (state, getters, rootState) {
    return rootState.auth.user && !!rootState.auth.user.farmer
  },
  isClient (state, getters, rootState) {
    return rootState.auth.user && !!rootState.auth.user.client
  },
  getOffer (state) {
    return state.offer
  },
  getBooking (state) {
    return state.booking
  },
  getTinyBooking (state) {
    return state.tinybooking
  },
  getOffers (state) {
    return state.offers
  },
  getOffersMeta (state) {
    return state.offers_meta
  },
  getActivity (state) {
    return state.activity
  },
  getActivities (state) {
    return state.activities
  },
  getActivtiesMeta (state) {
    return state.activities_meta
  },
  getFarmer (state) {
    return state.farmer
  },
  getAllOffers (state) {
    return state.all_offers
  },
  getHostOffers (state) {
    return state.hostOffers
  },
  getAllActivties (state) {
    return state.all_activities
  },
  getBookingPeopleCount (state) {
    return state.booking.peopleCount
  },
  getBookingAdultCount (state) {
    return state.booking.adultCount
  },
  getBookingChildCount (state) {
    return state.booking.childCount
  },
  getBookingId (state) {
    return state.booking.id
  },
  getBookingPromocode (state) {
    return state.booking.promocode
  },
  getBookingBreakfastOpt (state) {
    return state.booking.breakfastopt
  },
  getBookingLinensOpt (state) {
    return state.booking.linensopt
  },
  getBookingCleaningOpt (state) {
    return state.booking.cleaningopt
  },
  getBookingFromDate (state) {
    return state.booking.from
  },
  getBookingToDate (state) {
    return state.booking.to
  },
  getBookingDaysOffset (state) {
    return Math.abs(differenceInDays(state.booking.to, state.booking.from))
  },
  getCurrentOffer (state) {
    return state.currentOffer
  },
  getCurrentActivity (state) {
    return state.currentActivity
  },
  getCurrentReview (state) {
    return state.currentReview
  },
  getCurrentFarmerReview (state) {
    return state.currentFarmerReview
  },
  getCurrentActivityBookings (state) {
    let activityBookings = state.currentActivityBookings

    if (activityBookings) {
      activityBookings = activityBookings.activity_bookings.concat(activityBookings.external_activity_bookings)
    } else {
      activityBookings = []
    }

    return activityBookings
  },
  getCurrentOfferBookings (state) {
    let bookings = state.currentOfferBookings

    if (bookings) {
      bookings = bookings.bookings.concat(bookings.external_bookings)
    } else {
      bookings = []
    }
    return bookings
  },
  getCurrentFarmer (state) {
    return state.currentFarmer
  },
  getSearchQuery (state) {
    return state.SearchQuery
  },
  getSearchParams (state) {
    return state.SearchParams
  },
  getDataModalSearch (state) {
    return state.dataModal
  },
  getMetrics: state => state.metrics,
  getIncomes (state) {
    return state.incomes
  },
  getExpenses (state) {
    return state.expenses
  },
  getBookings (state) {
    return state.bookings
  },
  getLoading (state) {
    return state.isLoading
  }
}
