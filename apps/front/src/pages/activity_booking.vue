<template>
  <div class="offer">
    <div class="wrap offer-content">
      <div class="main-content">
        <booking-form
          class="booking-form"
        />
      </div>
      <div class="aside-content">
        <activity-booking
          v-sticky="{ stickyTop: 120, zIndex: 5 }"
          ref="activtyBooking"
        />
      </div>
    </div>
  </div>
</template>

<script>
  import ActivityPictures from '@/components/Activity/ActivityPictures'
  import ActivityBooking from '@/components/Activity/ActivityBooking'
  import BookingForm from '@/components/Activity/BookingForm'

  export default {
    name: 'Activity',
    components: {
      ActivityPictures,
      ActivityBooking,
      BookingForm
    },
    validate ({ store }) {
      return !store.getters.isFarmer
    },
    fetch ({ store, app, route }) {
      return app.$axios.get(`/activities/${route.params.id}`)
        .then((res) => {
          if (res.status === 200) {
            store.dispatch('setActivity', res.data)
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

  .offer{
    &-content{
      padding-top: 50px;
      display: grid;
      grid-template-columns: 6fr 5fr;
      padding-bottom: 50px;

      @media only screen and (max-width: $breakpoint-tablet) {
        grid-template-columns: 1fr;
      }

      @media only screen and (max-width: $breakpoint-mobile-l) {
        padding: 0 16px;
      }
    }

    .side-content{
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      grid-gap: 16px;
    }
  }
</style>
