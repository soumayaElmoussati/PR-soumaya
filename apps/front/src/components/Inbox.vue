<template>
  <div class="chat-room">

    <div
      id="talkjs-container"
      class="chatTalk"
    ><i>{{ $t("bookingTiny.buttons.loading") }}</i></div>

    <nuxt-link
      :to="{
        name: 'OfferBooking',
        params: {
          id: getOffer.id,
          slug: getOffer.slug
        }
      }"
      style="width: 250px;"
      class="btn btn-agri-l">{{ $t("bookingTiny.buttons.bookNow") }}</nuxt-link>

  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Talk from 'talkjs'

export default {
  name: 'Inbox',
  components: {
    Talk
  },
  props: {
    currentUser: {
      type: Object,
      required: true
    }
  },
  computed: {
    ...mapGetters([
      'getOffer'
    ]),
    residenceTypeAdress () {
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
          return 'LogementImmersif'
      }
    }
  },
  mounted: function () {
    var myname = this.$auth.user.first_name + ' ' + this.$auth.user.last_name
    var myemail = this.$auth.user.email
    var myid = (this.$auth.user.id).toString()
    var mypicture = 'https://www.staging.agrivillage.fr/_nuxt/img/3cee3d0.svg'

    var adminid = (2013).toString()
    var adminname = 'Agrivillage'
    var adminemail = 'contact@agrivillage.fr'
    var adminpicture = 'https://www.agrivillage.fr/icon.png'

    var farmerid = (this.getOffer.farmer.user.id).toString()
    var farmername = this.getOffer.farmer.user.first_name
    var farmeremail = this.getOffer.farmer.user.email
    var farmerpicture = 'https://www.agrivillage.fr/_nuxt/img/ad5ea91.svg'

    var convurl = '<https://www.agrivillage.fr/offer/' + this.getOffer.id + '/' + this.residenceTypeAdress + '/' + this.getOffer.address.city + '>'
    var convsubject = convurl
    var convpicture = 'https://agrivillage.fr/icon.png'

    var chatid = (this.$auth.user.id).toString() + (this.getOffer.farmer.user.id).toString() + '|' + (this.getOffer.id).toString() + '/' + this.getOffer.slug

    Talk.ready.then(function () {
      var me = new Talk.User({ id: myid, name: myname, email: myemail, photoUrl: mypicture, welcomeMessage: 'Bonjour', role: 'client' })

      var talkSession = new Talk.Session({
        appId: '0VMwLv0U',
        me: me
      })

      var other = new Talk.User({ id: farmerid,
        name: farmername,
        email: farmeremail,
        photoUrl: farmerpicture,
        welcomeMessage: 'Bonjour, comment puis-je vous aider ?',
        role: 'farmer'
      })

      var admin = new Talk.User({
        id: adminid,
        name: adminname,
        photoUrl: adminpicture,
        email: adminemail,
        role: 'admin'
      })

      var conversation = talkSession.getOrCreateConversation(chatid)
      conversation.setParticipant(me)
      conversation.setParticipant(other)
      conversation.setParticipant(admin)
      conversation.setAttributes({
          subject: convsubject,
          photoUrl: convpicture
      })
      var inbox = talkSession.createInbox({ selected: conversation })
      inbox.mount(document.getElementById('talkjs-container'))
    })
  }
}

</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.chat-room {
  display: grid;
  grid-template-columns: auto;
  gap: 2em;
  margin: 1em;
  .chatTalk {
    width: 100%;
    height: 500px;
  }
}
</style>
