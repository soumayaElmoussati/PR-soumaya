export default {
  SET_VALIDATION_ERRORS (state, errors) {
    state.errors = errors
  },
  SET_CURRENT_OFFER (store, offer) {
    store.currentOffer = offer
  },
  SET_CURRENT_FARMER (store, farmer) {
    store.currentFarmer = farmer
  },
  SET_CURRENT_REVIEW (store, review) {
    store.currentReview = review
  },
  SET_CURRENT_FARMER_REVIEW (store, farmerReview) {
    store.currentFarmerReview = farmerReview
  },
  SET_REVIEW (store, review) {
    store.review = review
  },
  SET_OFFER (store, offer) {
    store.offer = offer
  },
  SET_BOOKING (store, booking) {
    store.booking = booking
  },
  SET_TINY_BOOKING (store, booking) {
    store.tinybooking = booking
  },
  SET_ACTIVITY (store, activity) {
    store.activity = activity
  },
  SET_CURRENT_ACTIVITY (store, activity) {
    store.currentActivity = activity
  },
  SET_ACTIVITIES (store, activities) {
    store.activities = activities
  },
  SET_ALL_ACTIVITIES (store, allActivities) {
    store.all_activities = allActivities
  },
  PUSH_ACTIVITIES (store, activities) {
    store.activities = [
      ...store.activities,
      ...activities
    ]
  },
  SET_ACTIVITIES_META (store, meta) {
    store.activities_meta = meta
  },
  SET_OFFERS (store, offers) {
    store.offers = offers
  },
  SET_ALL_OFFERS (store, allOffers) {
    store.all_offers = allOffers
  },
  SET_HOST_OFFERS (store, hostOffers) {
    store.hostOffers = hostOffers
  },
  PUSH_OFFERS (store, offers) {
    store.offers = [
      ...store.offers,
      ...offers
    ]
  },
  SET_OFFERS_META (store, meta) {
    store.offers_meta = meta
  },
  SET_FARMER (state, farmer) {
    state.farmer = farmer
  },
  SET_BOOKING_PEOPLE_COUNT (store, value) {
    store.booking.peopleCount = value
  },
  SET_BOOKING_ADULT_COUNT (store, value) {
    store.booking.adultCount = value
  },
  SET_BOOKING_CHILD_COUNT (store, value) {
    store.booking.childCount = value
  },
  SET_BOOKING_PROMOCODE (store, value) {
    store.booking.promocode = value
  },
  SET_BOOKING_BREAKFAST_OPT (store, value) {
    store.booking.breakfastopt = value
  },
  SET_BOOKING_LINENS_OPT (store, value) {
    store.booking.linensopt = value
  },
  SET_BOOKING_CLEANING_OPT (store, value) {
    store.booking.cleaningopt = value
  },
  SET_BOOKING_FROM_DATE (store, value) {
    store.booking.from = value
  },
  SET_BOOKING_TO_DATE (store, value) {
    store.booking.to = value
  },
  SET_SEARCH_QUERY (store, value) {
    store.SearchQuery = value
  },
  SET_SEARCH_PARAMS (store, value) {
    store.SearchParams = value
  },
  SET_CURRENT_OFFER_BOOKINGS (store, value) {
    store.currentOfferBookings = value
  },
  SET_CURRENT_ACTIVITY_BOOKINGS (store, value) {
    store.currentActivityBookings = value
  },
  ADD_UNAVAILABLE_EVENT_TO_CURRENT_OFFER_BOOKINGS (store, value) {
    store.currentOfferBookings.external_bookings.push(value)
  },
  ADD_UNAVAILABLE_EVENT_TO_CURRENT_ACTIVITY_BOOKINGS (store, value) {
    store.currentActivityBookings.external_activity_bookings.push(value)
  },
  SET_CURRENT_OFFER_ICALENDAR_URLS (store, value) {
    store.currentOffer.icalendar_urls = value
  },
  RESET_OFFERS (store, value) {
    store.offers = value
  },
  SET_FILTER_DATA_MODAL (store, value) {
    store.dataModal = value
  },
  SET_METRICS (store, metrics) {
    store.metrics = metrics
  },
  SET_INCOMES (store, value) {
    store.incomes = value
  },
  SET_LOADING_FALSE (store) {
    store.isLoading = false
  },
  SET_LOADING_TRUE (store) {
    store.isLoading = true
  },
  SET_EXPENSES (store, value) {
    store.expenses = value
  },
  SET_BOOKINGS (store, value) {
    store.bookings = value
  }
}
