<template>
  <div class="offer">
    <div class="wrap offer-content">
      <div class="main-content">
        <booking-form
          class="booking-form"
        />
      </div>
      <div class="aside-content">
        <offer-booking
          v-sticky="{ stickyTop: 120, zIndex: 5 }"
          ref="offerBooking"
        />
      </div>
    </div>
  </div>
</template>

<script>
  import OfferPictures from '@/components/Offer/OfferPictures'
  import OfferBooking from '@/components/Offer/OfferBooking'
  import BookingForm from '@/components/Offer/BookingForm'

  export default {
    name: 'Offer',
    components: {
      OfferPictures,
      OfferBooking,
      BookingForm
    },
    validate ({ store }) {
      return !store.getters.isFarmer
    },
    fetch ({ store, app, route }) {
      return app.$axios.get(`/offers/${route.params.id}`)
        .then((res) => {
          if (res.status === 200) {
            store.dispatch('setOffer', res.data)
          }
        })
        .catch((err) => {
          console.log('error occured', err)
        })
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .wrap {
    width: 90% !important;
  }

  .offer{
    &-content{
      padding-top: 50px;
      display: grid;
      grid-template-columns: 6fr 5fr;
      padding-bottom: 120px;

      @media only screen and (max-width: $breakpoint-tablet) {
        grid-template-columns: 1fr;
      }

      @media only screen and (max-width: $breakpoint-mobile-l) {
        padding: 0 16px;
        display: block;
      }
    }

    .side-content{
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      grid-gap: 16px;
    }
  }
</style>
