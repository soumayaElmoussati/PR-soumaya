import { mapGetters, mapActions } from 'vuex'

export default {
  data () {
    return {
      showModal: false,
      filters: {
        price: [0, 100],
        housings: [],
        agricultures: [],
        animals: [],
        farmTypes: [],
        equipments: []
      }
    }
  },
  mounted () {
    this.resetFilter()
  },
  computed: {
    ...mapGetters(['getOffers', 'getMetrics'])
  },
  methods: {
    ...mapActions([
      'retrieveOffers'
    ]),
    toggleModal () {
      this.showModal = !this.showModal
    },
    resetFilter () {
      if (this.getMetrics) {
        const { min_price: min, max_price: max } = this.getMetrics
        this.filters.price = [
          min,
          max
        ]
      }
      this.filters.housings = []
      this.filters.agricultures = []
      this.filters.animals = []
      this.filters.equipments = []
      this.filters.farmTypes = []
    },
    filter (additionalParams = {}) {
      const animals = this.filters.animals.map(animal => animal.value)
      const residenceType = this.filters.housings.map(housing => housing.value)
      const agricultures = this.filters.agricultures.map(agriculture => agriculture.value)
      const farmTypes = this.filters.farmTypes.map(farmType => farmType.value)

      let params = {}
      if (animals.length) params.animals = animals.join(',')
      if (residenceType.length) params.residence_type = residenceType.join(',')
      if (agricultures.length) params.agriculture_types = agricultures.join(',')
      if (farmTypes.length) params.farm_types = farmTypes.join(',')
      if (this.filters.price[0]) params.min_price = this.filters.price[0]
      if (this.filters.price[1]) params.max_price = this.filters.price[1]

      /**
       * Append the rest of the query parameters if they are present
       * in the URL.
       */
      const {
        location,
        activity,
        min_price: minPrice,
        max_price: maxPrice,
        date_depart: dateDepart,
        date_arrive: dateArrive,
        people_count: peopleCount
      } = this.$route.query

      if (location) params.location = location
      if (activity) params.activities = activity
      if (dateDepart) params.departure_date = dateDepart
      if (dateArrive) params.departure_date = dateArrive
      if (peopleCount) params.people_count = peopleCount
      if (minPrice) params.min_price = minPrice
      if (maxPrice) params.max_price = maxPrice

      const settlements = this.filters.equipments
        .filter(v => ['animals_welcome', 'accessible'].includes(v))

      const equipments = this.filters.equipments
        .filter(v => ['fireplace', 'wifi', 'swimming_pool', 'parking', 'bbq'].includes(v))

      if (settlements.length) params.settlements = settlements.join(',')
      if (equipments.length) params.equipments = equipments.join(',')

      if (this.filters.equipments.includes('breakfast')) {
        params.services = 'breakfast'
      }

      params = {
        ...params,
        ...additionalParams
      }

      return this.retrieveOffers(params)
        .finally(() => {
          this.showModal = false
        })
    }
  }
}
