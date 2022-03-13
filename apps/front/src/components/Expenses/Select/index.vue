<template>
  <div class="container">
    <nuxt-link
      :to="{
        name: 'NewExpense',
        params: { id: getOffer.id, slug: getOffer.slug, domaine: residenceType }
      }"
      class="btn expense-link"
      style="box-shadow: none !important, margin-left: 1px!important"
    >
      {{ $t("global.crud.new_expense") }}
    </nuxt-link>
    <h3>{{ getOffer.name }}</h3>
    <select
      id="period"
      v-model="period"
      name="period"
      @change="selected()">
      <option
        disabled
        value="">Choisissez une période</option>
      <option
        v-for="date in getIncomes"
        :key="date.id"
        :value="date"
      >{{ date.period_name }}</option
      >
    </select>
  </div>
</template>

<script>
export default {
  name: 'Select',
  props: {
    getIncomes: {
      type: Array,
      default: function () {
        return []
      }
    },
    getOffer: {
      type: Array,
      default: function () {
        return []
      }
    }
  },
  data: function () {
    return {
      period: '',
      incomeSelected: ''
    }
  },
  computed: {
    residenceType () {
      // NOTE: Type de logement
      switch (this.getOffer.residence_type) {
      case 'entire_house':
        return 'LogementEntier'
      case 'private_room':
        return 'ChambrePrivee'
      case 'guest_room':
        return 'ChambreDHote'
      case 'unusual_room':
        return 'LogementInsolite'
      case 'tiny_house':
        return 'TinyHouse'
      case 'immersive_house':
        return 'LogementEnImmersion'
      }
    }
  },
  methods: {
    selected () {
      this.$emit('period', this.period)
    },
    formatDate (date) {
      let newDate = date.split('-')
      let renderDate = newDate[2] + '/' + newDate[1] + '/' + newDate[0]
      return renderDate
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
.expense-link {
  text-transform: uppercase;
  background-color: $agri-yellow;
  color: black;
  border-radius: 50px;
  box-shadow: 1px 1px 12px #555;
  height: 50px;
  font-size: 15px;
  width: 90%;
  margin-top: 2vh;
  margin-left: 1vh;
}
.container {
  height: 100%;
  width: 20% !important;
  background-color: $agri-green;
  h3 {
    color: $agri-white;
    text-align: center;
  }
  select {
    display: block;
    margin: auto;
  }
}
</style>
