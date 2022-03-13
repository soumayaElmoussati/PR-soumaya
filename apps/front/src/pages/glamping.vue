<template>
  <div class="tiny-container">
    <glamping-hero />
    <glamping-explain />
    <glamping-heart />
    <!-- <glamping-join /> -->
    <OffersFooter />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import GlampingHero from '@/components/Glamping/GlampingHero'
import GlampingExplain from '@/components/Glamping/GlampingExplain'
import GlampingHeart from '@/components/Glamping/GlampingHeart'
import GlampingFooter from '@/components/Glamping/GlampingFooter'
import GlampingJoin from '@/components/Glamping/GlampingJoin'
import OffersFooter from '@/components/OffersList/OffersFooter'

export default {
  name: 'Glamping',
  components: {
    GlampingHero,
    GlampingExplain,
    GlampingHeart,
    GlampingFooter,
    GlampingJoin,
    OffersFooter
  },
  head () {
    return {
      title: 'Vivez une expérience de Glamping à la ferme',
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
