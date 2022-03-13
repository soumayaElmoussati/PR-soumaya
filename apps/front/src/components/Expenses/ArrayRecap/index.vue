<template>
  <div class="containerArray">
    <h3>{{ $t("expenses.arrayrecap.title") }}</h3>
    <table class="recapArray">
      <thead>
        <tr>
          <th scope="col">{{ $t("expenses.tables.totalRevenue") }}</th>
        </tr>
      </thead>
      <tbody class="recapArray">
        <tr>
          <td
            scope="row"
            data-label="Nombre de séjours">
            {{ $t("expenses.tables.stay") }}
          </td>
          <td data-label="Total">{{ countBookings() }}</td>
        </tr>
        <tr>
          <td
            scope="row"
            data-label="Nombre total de nuitées louées">
            {{ $t("expenses.tables.nights") }}
          </td>
          <td data-label="Total">{{ countNights() }}</td>
        </tr>
        <tr>
          <td data-label="Total des dépenses">
            {{ $t("expenses.tables.totalExpense") }}
          </td>
          <td
            v-if="data.expenses_balance"
            data-label="Total">{{ (data.expenses_balance / 100).toFixed(2) }}€</td>
          <td
            v-else
            data-label="Total">0 €</td>
        </tr>
        <tr>
          <td data-label="Total des revenus de l'offre">
            {{ $t("expenses.tables.totalLodging") }}
          </td>
          <td
            v-if="data.total_offer_income"
            data-label="Total">{{ (data.total_offer_income / 100).toFixed(2) }}€</td>
          <td
            v-else
            data-label="Total">0 €</td>
        </tr>
        <tr>
          <td data-label="Total des revenus pour l’agriculteur pour l’hébergement">
            {{ $t("expenses.tables.totalFarmer") }}
          </td>
          <td
            v-if="data.farmer_balance"
            data-label="Total">{{ (data.farmer_balance / 100).toFixed(2) }}€</td>
          <td
            v-else
            data-label="Total">0 €</td>
        </tr>
        <tr>
          <td data-label="Total des frais payés par l'agriculter">
            {{ $t("expenses.tables.totalExpenseAgri") }}
          </td>
          <td
            data-label="Total">{{ (data.farmer_expenses / 100).toFixed(2) }}€</td>
        </tr>
        <tr>
          <td
            scope="row"
            data-label="Revenu Ménage">
            {{ $t("expenses.tables.revenue") }}
          </td>
          <td data-label="Nombre">{{ (data.housework_income_balance / 100).toFixed(2) }}€</td>
        </tr>
        <tr>
          <td data-label="Total dû par AgriVillage pour la période">
            {{ $t("expenses.tables.totalAgrivillage") }}
          </td>
          <td
            v-if="data.total_farmer_balance"
            data-label="Total">{{ (data.total_farmer_balance / 100).toFixed(2) }}€</td>
          <td
            v-else
            data-label="Total">0 €</td>
        </tr>
        <tr>
          <td
            scope="row"
            data-label="Revenus liée au service">
            {{ $t("expenses.tables.serviceRevenue") }}
          </td>
          <td data-label="Payeur">{{ (data.annexes_incomes_balance / 100).toFixed(2) }}€</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import differenceInDays from 'date-fns/difference_in_days'

export default {
  name: 'ArrayRecap',
  props: {
    data: {
      type: Object,
      default: null
    }
  },
  data () {
    return {
      expenseTotal: 0,
      bookings: 0,
      housework: 0
    }
  },
  computed: {
    ...mapGetters(['getIncomes', 'getBookings'])
  },
  mounted () {
    this.exportAll()
    this.countBookings()
    this.countNights()
  },
  methods: {
    exportAll () {
      this.getIncomes.forEach(element => {
        let total = 0
        total += element.expenses_balance
        total = (total / 100).toFixed(2)
        this.expenseTotal = total
      })
    },
    countNights () {
      let found = []
      this.getBookings.forEach(element => {
        if ((element.status === 'payed' || element.status === 'finished' || element.status === 'allSet') && element.arrival_date > this.data.start_date && element.arrival_date < this.data.end_date) {
          let nights = Math.abs(differenceInDays(element.arrival_date, element.departure_date))
          found.push(nights)
        }
      })
      return found.reduce((a, b) => a + b, 0)
    },
    countBookings () {
      let found = []
      this.getBookings.forEach(element => {
        if ((element.status === 'payed' || element.status === 'finished' || element.status === 'allSet') && element.arrival_date > this.data.start_date && element.arrival_date < this.data.end_date) {
          found.push(element)
        }
      })
      return found.length
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.recapArray {
  height: 370px !important;
}

.containerArray {
  margin: 35px 0 0 0;
  padding: 0;
  background-color: $agri-green;
  height: 550px !important;
  border-radius: 50px;
  h3 {
    text-align: center;
    margin: 0 0 25px 0;
    font-size: 36px;
    padding: 25px 0 0 0;
    color: $agri-white;
  }
  table {
    border: 1px solid #ccc;
    border-collapse: collapse;
    margin: 0 auto;
    padding: 0;
    width: 80%;
    table-layout: fixed;
  }

  table caption {
    font-size: 1.5em;
    margin: 0.5em 0 0.75em;
  }

  table tbody {
    display: block;
    height: 195px;
    overflow: auto;
  }

  table tr {
    background-color: #f8f8f8;
    border: 1px solid #ddd;
    padding: 0.35em;
  }

  table th,
  table td {
    padding: 0.625em;
    text-align: center;
  }

  table th {
    font-size: 0.85em;
    letter-spacing: 0.1em;
    text-transform: uppercase;
    background-color: #e8e8e8;
    border: solid 3px $agri-green;
  }
  table td {
    border: solid 1px $agri-green;
  }
  thead,
  tbody tr {
    display: table;
    width: 100%;
    table-layout: fixed; /* even columns width , fix width of table too*/
  }
  thead {
    width: 100%;
  }
}

@media screen and (max-width: 600px) {
  table {
    border: 0;
  }

  table caption {
    font-size: 1.3em;
  }

  table thead {
    border: none;
    clip: rect(0 0 0 0);
    height: 1px;
    margin: -1px;
    overflow: hidden;
    padding: 0;
    position: absolute;
    width: 1px;
  }

  table tr {
    border-bottom: 3px solid #ddd;
    display: block;
    margin-bottom: 0.625em;
  }

  table td {
    border-bottom: 1px solid #ddd;
    display: block;
    font-size: 0.8em;
    text-align: right;
  }

  table td::before {
    /*
    * aria-label has no advantage, it won't be read inside a table
    content: attr(aria-label);
    */
    content: attr(data-label);
    float: left;
    font-weight: bold;
    text-transform: uppercase;
  }

  table td:last-child {
    border-bottom: 0;
  }
}
</style>
