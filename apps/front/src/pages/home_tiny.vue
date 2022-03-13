<template>
  <div class="tiny-container">
    <tiny-hero />
    <tiny-explain />
    <tiny-heart />
    <tiny-join />
    <OffersFooter />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import TinyHero from '@/components/TinyHome/TinyHero'
import TinyExplain from '@/components/TinyHome/TinyExplain'
import TinyHeart from '@/components/TinyHome/TinyHeart'
import TinyFooter from '@/components/TinyHome/TinyFooter'
import TinyJoin from '@/components/TinyHome/TinyJoin'
import OffersFooter from '@/components/OffersList/OffersFooter'

export default {
  name: 'HomeTiny',
  components: {
    TinyHero,
    TinyExplain,
    TinyHeart,
    TinyFooter,
    TinyJoin,
    OffersFooter
  },
  head () {
    return {
      title: 'Offrez-vous un séjour dans une Tiny House',
      titleTemplate: '%s - AgriVillage'
    }
  },
  fetch ({ store, app, route }) {
    return app.$axios
      .get('/offers/tiny')
      .then(res => {
        if (typeof route.params.transition === 'undefined') {
          store.dispatch('setOffers', res.data.offers)
          store.dispatch('setOffersMeta', res.data.meta)
        }
      })
      .catch(err => {
        console.log('error', err)
      })
  },
  data () {
    return {}
  },
  computed: {
    ...mapGetters(['getOffersMeta'])
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.tiny-container {
  margin-top: 0 !important;
  @media only screen and (max-width: $breakpoint-tablet) {
    max-width: 100% !important;
  }
  .insta-tiny{
    margin-top: 85px !important;
    @media only screen and (max-width: 375px) {
      min-height: 220vh !important;
      }
  }
}
</style>
