<template>
  <div v-if="attrs[0].dates.length > 0">
    <h3 class="content-title">
      {{ $t("offer.titles.available") }}
    </h3>
    <div class="divider" />
    <v-calendar
      v-if="attrs[0].dates.length > 0"
      :columns="$screens({ default: 1, lg: 2 })"
      :attributes="attrs"
      :min-date="new Date()"
      color="red"
      @dayclick="onDayClick"
    />
    <h2
      v-else
      class="content-title">
      {{ $t("offer.titles.noReservation") }}
    </h2>
  </div>
</template>

<script>
export default {
  props: {
    date: {
      type: Array,
      default: function () {
        return []
      }
    }
  },
  data () {
    return {
      days: [],
      attrs: [
        {
          highlight: {
            start: { fillMode: 'outline' },
            base: { fillMode: 'light' },
            end: { fillMode: 'outline' }
          },
          dates: []
        }
      ]
    }
  },
  computed: {
    // dates () {
    //   return this.days.map(day => day.date)
    // },
    // attributes () {
    //   return this.dates.map(date => ({
    //     highlight: true,
    //     dates: date
    //   }))
    // }
  },
  mounted () {
    this.loadDates()
  },
  methods: {
    onDayClick (day) {
      const idx = this.days.findIndex(d => d.id === day.id)
      if (idx >= 0) {
        this.days.splice(idx, 1)
      } else {
        this.days.push({
          id: day.id,
          date: day.date
        })
      }
    },
    loadDates () {
      this.date.forEach(e => {
        this.attrs[0].dates.push({ start: e.start, end: e.end })
      })
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
.content-title {
  text-transform: uppercase;
  color: #476458;
  font-size: 21px;
  font-weight: 900;
}

.divider {
  height: 1px;
  background-color: rgba(black, 0.3);
  margin-top: 16px;
  margin-bottom: 16px;
}
</style>
