<template>
  <div class="containerArray">
    <h3>{{ $t("expenses.arraylocation.title") }}</h3>
    <table>
      <thead>
        <tr>
          <th scope="col">{{ $t("expenses.tables.satut") }}</th>
          <th scope="col">{{ $t("expenses.tables.client") }}</th>
          <th scope="col">{{ $t("expenses.tables.startDate") }}</th>
          <th scope="col">{{ $t("expenses.tables.endDate") }}</th>
          <th scope="col">{{ $t("expenses.tables.residencePrice") }}</th>
        </tr>
      </thead>
      <div v-if="data">
        <tbody>

          <div
            v-for="(booking, k) in getBookings"
            :key="k">

            <tr v-if="booking.arrival_date > data.start_date && booking.arrival_date < data.end_date">
              <td data-label="Satut">{{ $t("global.status." + booking.status) }}</td>
              <td data-label="Client">{{ booking.client.user.first_name }} {{ booking.client.user.last_name }}</td>
              <td data-label="Date de début">
                {{ formatDate(booking.arrival_date) }}
              </td>
              <td data-label="Date de fin">{{ formatDate(booking.departure_date) }}</td>
              <td data-label="Prix du logement">{{ monetize(booking.sub_total - 4500).toFixed(2) }}€</td>
            </tr>

          </div>

        </tbody>
      </div>
      <div v-else>
        <tbody>
          <tr>
            <td data-label="Satut">{{ $t("expenses.tables.noRevenue") }}</td>
          </tr>
        </tbody>
      </div>
    </table>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'ArrayLocation',
  props: {
    data: {
      type: Object,
      default: null
    }
  },
  computed: {
    ...mapGetters(['getBookings'])
  },
  methods: {
    formatDate (value) {
      let date = value.split('T')
      let clear = date[0]
      let final = clear.split('-')
      let renderDate = final[2] + '/' + final[1] + '/' + final[0]
      return renderDate
    },
    monetize (amount) {
      let newAmout = amount / 100
      return newAmout
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
.containerArray {
  margin: 35px 0 0 0;
  padding: 0;
  background-color: $agri-green;
  height: 500px !important;
  border-radius: 50px;
  h3 {
    text-align: center;
    margin: 0;
    font-size: 36px;
    padding: 25px 0 0 0;
    color: $agri-white;
  }
  p {
    text-align: center;
    margin: 0 0 15px 0;
    font-size: 30px;
    padding: 0;
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
    height: 300px;
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
