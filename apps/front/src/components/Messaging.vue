<template>
  <div
    id="talkjs-container"
    class="talkChat"
  ><i>{{ $t("bookingTiny.buttons.loading") }}</i></div>
</template>

<script>
import Talk from 'talkjs'

export default {
  name: 'Messaging',
  components: {
    Talk
  },
  props: {
    currentUser: {
      type: Object,
      required: true
    }
  },
  mounted: function () {
    var myname = this.$auth.user.first_name + ' ' + this.$auth.user.last_name
    var myemail = this.$auth.user.email
    var myid = (this.$auth.user.id).toString()
    var mypicture = 'https://www.staging.agrivillage.fr/_nuxt/img/3cee3d0.svg'

    Talk.ready.then(function () {
      var me = new Talk.User({ id: myid, name: myname, email: myemail, photoUrl: mypicture, welcomeMessage: 'Bonjour', role: 'client' })

      var talkSession = new Talk.Session({
        appId: '0VMwLv0U',
        me: me
      })

      var inbox = talkSession.createInbox()
      inbox.mount(document.getElementById('talkjs-container'))
    })
  }
}

</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
.talkChat {
  width: 100%;
  margin: 0px;
  height: 30vw;
  @media only screen and (max-width: $breakpoint-laptop-m) {
    height: 50vw;
  }
  @media only screen and (max-width: $breakpoint-tablet) {
    height: 70vw;
  }
}
</style>
