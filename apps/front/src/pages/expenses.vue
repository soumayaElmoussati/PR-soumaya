<template>
  <div class="container">
    <div class="contain">
      <!-- Composent avec menu déroulant -->
      <Select
        :getIncomes="getIncomes"
        :getOffer="getOffer"
        @period="selected"
      />
      <div class="arrays">
        <Spinner v-if="getLoading" />
        <div v-else>
          <ArrayLocation :data="data" />
          <ArrayExpenses :data="arrayFilterExpenses" />
          <ArrayRecap :data="data" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Select from '@/components/Expenses/Select'
import Spinner from '@/components/WiUI/SpinnerExpenses'
import { mapGetters, mapActions } from 'vuex'
import ArrayLocation from '@/components/Expenses/ArrayLocation'
import ArrayExpenses from '@/components/Expenses/ArrayExpenses'
import ArrayRecap from '@/components/Expenses/ArrayRecap'
export default {
  name: 'Expenses',
  middleware: 'auth',
  components: {
    Select,
    ArrayLocation,
    ArrayExpenses,
    ArrayRecap,
    Spinner
  },
  data () {
    return {
      select: '',
      data: '',
      // arrayFilterIncomes: [],
      arrayFilterExpenses: []
      // arrayFilterBookings: []
    }
  },
  computed: {
    ...mapGetters([
      'getIncomes',
      'getExpenses',
      'getBookings',
      'isFarmer',
      'getOffer',
      'getLoading'
    ])
  },
  fetch ({ app, store, route }) {
    return app.$axios.get(`/offers/${route.params.id}`).then(res => {
      store.dispatch('isLoadingTrue')
      if (res.status === 200) {
        store.dispatch('setOffer', res.data)
        return app.$axios
          .get(`/offers/${route.params.id}/farmer_incomes`)
          .then(values => {
            if (values.status === 200) {
              store.dispatch('fetchIncomes', values.data.incomes)
              store.dispatch('fetchExpenses', values.data.expenses)
              store.dispatch('fetchBookings', values.data.bookings)
              store.dispatch('isLoadingFalse')
            }
          })
          .catch(err => {
            return console.log('erorr occured', err)
          })
      }
    })
  },
  methods: {
    ...mapActions(['setOffer', 'fetchIncomes']),

    selected (value) {
      if (value) {
        this.data = value
        var dateCheckFrom = this.data.start_date.split('-')
        var dateCheckTo = this.data.end_date.split('-')
        let formatDateFrom = new Date(
          dateCheckFrom[0],
          parseInt(dateCheckFrom[1]) - 1,
          dateCheckFrom[2]
        ) // -1 because months are from 0 to 11
        let formatDateTo = new Date(
          dateCheckTo[0],
          parseInt(dateCheckTo[1]) - 1,
          dateCheckTo[2]
        ) // -1 because months are from 0 to 11
        this.arrayFilterExpenses = []
        this.getExpenses.forEach(expense => {
          var dateFrom = expense.expense_date
          var d1 = dateFrom.split('-')
          var from = new Date(d1[0], parseInt(d1[1]) - 1, d1[2]) // -1 because months are from 0 to 11
          if (from >= formatDateFrom && from <= formatDateTo) {
            this.arrayFilterExpenses.push(expense)
          }
        })
      }
    }
  }
}
</script>

<style lang="scss" scoped>
.container {
  min-height: 1900px;
  width: 100%;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  .contain {
    display: flex;
  }
  .arrays {
    width: 70%;
    margin: 0 auto;
  }
}
</style>
