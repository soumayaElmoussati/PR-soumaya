export default {
  setErrors ({ commit }, errors) {
    commit('SET_VALIDATION_ERRORS', errors)
  },
  clearErrors ({ commit }) {
    commit('SET_VALIDATION_ERRORS', {})
  },
  setCurrentOffer ({ commit }, offer) {
    commit('SET_CURRENT_OFFER', offer)
  },
  setCurrentActivity ({ commit }, activity) {
    commit('SET_CURRENT_ACTIVITY', activity)
  },
  setCurrentFarmer ({ commit }, farmer) {
    commit('SET_CURRENT_FARMER', farmer)
  },
  setCurrentReview ({ commit }, review) {
    commit('SET_CURRENT_REVIEW', review)
  },
  setCurrentFarmerReview ({ commit }, farmerReview) {
    commit('SET_CURRENT_FARMER_REVIEW', farmerReview)
  },
  setOffer ({ commit }, offer) {
    commit('SET_OFFER', offer)
  },
  setBooking ({ commit }, booking) {
    commit('SET_BOOKING', booking)
  },
  setTinyBooking ({ commit }, booking) {
    commit('SET_TINY_BOOKING', booking)
  },
  setActivity ({ commit }, activity) {
    commit('SET_ACTIVITY', activity)
  },
  setFarmer ({ commit }, farmer) {
    commit('SET_FARMER', farmer)
  },
  setActivities ({ commit }, activities) {
    commit('SET_ACTIVITIES', activities)
  },
  setOffers ({ commit }, offers) {
    commit('SET_OFFERS', offers)
  },
  setActivitiesMeta ({ commit }, meta) {
    commit('SET_ACTIVITIES_META', meta)
  },
  setOffersMeta ({ commit }, meta) {
    commit('SET_OFFERS_META', meta)
  },
  setAllOffers ({ commit }, allOffers) {
    commit('SET_ALL_OFFERS', allOffers)
  },
  setHostOffers ({ commit }, hostOffers) {
    commit('SET_HOST_OFFERS', hostOffers)
  },
  setAllActivities ({ commit }, allActivities) {
    commit('SET_ALL_ACTIVITIES', allActivities)
  },
  pushOffers ({ commit }, offers) {
    commit('PUSH_OFFERS', offers)
  },
  pushActivities ({ commit }, activities) {
    commit('PUSH_ACTIVITIES', activities)
  },
  setBookingPeopleCount ({ commit }, peopleCount) {
    commit('SET_BOOKING_PEOPLE_COUNT', peopleCount)
  },
  setBookingAdultCount ({ commit }, adultCount) {
    commit('SET_BOOKING_ADULT_COUNT', adultCount)
  },
  setBookingChildCount ({ commit }, childCount) {
    commit('SET_BOOKING_CHILD_COUNT', childCount)
  },
  setBookingPromocode ({ commit }, promocode) {
    commit('SET_BOOKING_PROMOCODE', promocode)
  },
  setBookingBreakfastOpt ({ commit }, breakfastopt) {
    commit('SET_BOOKING_BREAKFAST_OPT', breakfastopt)
  },
  setBookingLinensOpt ({ commit }, linensopt) {
    commit('SET_BOOKING_LINENS_OPT', linensopt)
  },
  setBookingCleaningOpt ({ commit }, cleaningopt) {
    commit('SET_BOOKING_CLEANING_OPT', cleaningopt)
  },
  setBookingFromDate ({ commit }, from) {
    commit('SET_BOOKING_FROM_DATE', from)
  },
  setBookingToDate ({ commit }, to) {
    commit('SET_BOOKING_TO_DATE', to)
  },
  setSearchQuery ({ commit }, SearchQuery) {
    commit('SET_SEARCH_QUERY', SearchQuery)
  },
  setSearchParams ({ commit }, SearchParams) {
    commit('SET_SEARCH_PARAMS', SearchParams)
  },
  fetchCurrentOfferBookings ({ commit }, bookings) {
    commit('SET_CURRENT_OFFER_BOOKINGS', bookings)
  },
  fetchCurrentActivityBookings ({ commit }, bookings) {
    commit('SET_CURRENT_ACTIVITY_BOOKINGS', bookings)
  },
  resetOffers ({ commit }) {
    commit('RESET_OFFERS', [])
  },
  setFilterDataModal ({ commit }, data) {
    commit('SET_FILTER_DATA_MODAL', data)
  },
  retrieveMetrics ({ commit }) {
    return this.$axios.get('/v2/metrics')
      .then(res => {
        commit('SET_METRICS', res.data)
      })
  },
  retrieveOffers ({ dispatch }, params) {
    return this.$axios.get('/v2/offers', {
      params
    })
      .then(res => {
        dispatch('setOffers', res.data.offers)
        dispatch('setOffersMeta', res.data.meta)

        return res
      })
  },
  fetchIncomes ({ commit }, data) {
    commit('SET_INCOMES', data)
  },
  isLoadingFalse ({ commit }) {
    commit('SET_LOADING_FALSE')
  },
  isLoadingTrue ({ commit }) {
    commit('SET_LOADING_TRUE')
  },
  fetchBookings ({ commit }, data) {
    commit('SET_BOOKINGS', data)
  },
  fetchExpenses ({ commit }, data) {
    commit('SET_EXPENSES', data)
  }
}
