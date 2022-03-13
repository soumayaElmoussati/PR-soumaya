<template>

  <div class="inbox-container">
    <inbox/>
  </div>

</template>

<script>
import { mapGetters } from 'vuex'
import Inbox from '@/components/Inbox.vue'

export default {
  name: 'ChatRoom',
  middleware: 'auth',
  components: {
    Inbox
  },
  fetch ({ store, app, route, error }) {
    return Promise.all([
      app.$axios.get(`/offers/${route.params.id}`)
    ])
      .then(values => {
        if (values[0].status === 200) {
          store.dispatch('setOffer', values[0].data)
        }
      })
      .catch(() => {
        error({
          statusCode: 404,
          message: "Cette offre n'existe pas ou plus"
        })
      })
    // return app.$axios.get(`/offers/${route.params.id}`)
    //   .then((res) => {
    //     if (res.status === 200) {
    //       store.dispatch('setOffer', res.data)
    //     }
    //   })
    //   .catch(() => {
    //     error({
    //       statusCode: 404,
    //       message: 'Cette offre n\'existe pas ou plus'
    //     })
    //   })
  },
  computed: {
    ...mapGetters(['getOffer'])
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
@import "@/assets/scss/_mixins.scss";

.inbox-container {
  height: 100vh;
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
