<template>
  <div class="containerArray">
    <h3>{{ $t("expenses.arrayexpenses.title") }}</h3>
    <table>
      <thead>
        <tr>
          <th scope="col">{{ $t("expenses.tables.satut") }}</th>
          <th scope="col">{{ $t("expenses.tables.payer") }}</th>
          <th scope="col">{{ $t("expenses.tables.expense") }}</th>
          <th scope="col">{{ $t("expenses.tables.date") }}</th>
          <th scope="col">{{ $t("expenses.tables.expenseHt") }}</th>
          <th scope="col">{{ $t("expenses.tables.expenseTtc") }}</th>
          <th scope="col">{{ $t("expenses.tables.proof") }}</th>
        </tr>
      </thead>
      <tbody v-if="data.length">
        <tr
          v-for="d in data"
          :key="d.id">
          <td data-label="Satut">{{ stateType(d.state) }}</td>
          <td data-label="Payeur">{{ d.responsable }}</td>
          <td
            data-label="Type de dépenses"
            class="comment-expense">{{ d.comment }}</td>
          <td data-label="Date">{{ formatDate(d.expense_date) }}</td>
          <td data-label="Dépenses HT">{{ formatAmountHt(d.total_ht) }} €</td>
          <td data-label="Dépenses TTC">
            {{ formatAmountTtc(d.total_ttc) }} €
          </td>
          <td data-label="Preuve">
            <div class="cloudinary">

              <cloudinary
                v-if="d.pictures.length"
                :public-id="d.pictures[0].public_id"
                :transformations="{
                  w: 80,
                  h: 80,
                  c: 'fill',
                  f: 'jpg',
                  fl: 'progressive'
                }"
                :alt="d.comment"/>

            </div>

          </td>
        </tr>
      </tbody>
      <tbody v-else>
        <tr>
          <td data-label="Satut">{{ $t("expenses.tables.noExpense") }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import Cloudinary from '@/components/Cloudinary'

export default {
  name: 'ArrayExpenses',
  components: {
    Cloudinary
  },
  props: {
    data: {
      type: Object,
      default: null
    }
  },
  methods: {
    stateType (value) {
      switch (value) {
        case 'pending_validation':
          return 'En attente de validation'
        case 'validate':
          return 'Confirmé'
      }
    },
    formatDate (date) {
      if (date !== null && date !== '' && date !== undefined) {
        let newDate = date.split('-')
        let renderDate = newDate[2] + '/' + newDate[1] + '/' + newDate[0]
        return renderDate
      }
      return 'Error date'
    },
    formatAmountTtc (value) {
      let newAmount = (value / 100).toFixed(2)
      return newAmount
    },
    formatAmountHt (value) {
      let newAmount = (value / 100).toFixed(2)
      return newAmount
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.comment-expense {
  font-size: 12px;
}

.cloudinary {
  display: flex;
  width: 100%;
  height: 80px;
  object-fit: cover;
  overflow: hidden;
}

.containerArray {
  margin: 35px 0 0 0;
  padding: 0;
  background-color: $agri-green;
  height: 500px !important;
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
