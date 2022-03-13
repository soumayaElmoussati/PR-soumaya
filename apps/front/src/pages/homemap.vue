<template>
  <div
    class="home container"
  >
    <home-map />
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'
  import HomeMap from '@/components/Home/HomeMap'
  export default {
    components: {
      HomeMap
    },
    head () {
      return {
        title: this.$t('home.meta.title'),
        titleTemplate: 'AgriVillage - %s',
        meta: [
          { hid: 'description', name: 'description', content: 'Trouvez l’offre qu’il vous faut n’importe où en France' }
        ]
      }
    },

    computed: {
      ...mapGetters([
        'getOffers'
      ])
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";
  .home{
    margin-top: 0px;
    .wrap{
      @media only screen and (max-width: $breakpoint-tablet) {
        padding: 0 16px;
      }
    }
  }
  .no-wrap {
    margin: 0px !important;
    padding: 0px !important;
    width: 100% !important;
  }
  .pagin {
    text-align: center;
  }
</style>
