<template>

  <div class="inbox-container">
    <inbox/>
  </div>

</template>

<script>
import { mapGetters } from 'vuex'
import Inbox from '@/components/InboxFarmer.vue'

export default {
  name: 'ChatRoomFarmer',
  middleware: 'auth',
  components: {
    Inbox
  },
  fetch ({ store, app, route, error }) {
    return Promise.all([
      app.$axios.get(`/offers/${route.params.id}`),
      app.$axios.get(`/bookings/${route.params.booking}`)
    ])
      .then(values => {
        if (values[0].status === 200) {
          store.dispatch('setOffer', values[0].data)
        }
        if (values[1].status === 200) {
          store.dispatch('setBooking', values[1].data)
        }
      })
      .catch(() => {
        error({
          statusCode: 404,
          message: "Cette offre n'existe pas ou plus"
        })
      })
  },
  computed: {
    ...mapGetters(['getOffer', 'getBooking'])
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
@import "@/assets/scss/_mixins.scss";

.inbox-container {
  height: 70vh;
  margin: 15vh;
  @media only screen and (max-width: $breakpoint-tablet) {
    margin: 2vh;
    margin-top: 20vw;
  }
}

#talkjs-container {
  height: 70vh;
}
</style>
