<template>
  <div class="chat-room">

    <div
      id="talkjs-container"
      style="width: 100%; height: 500px"><i>{{ $t("bookingTiny.buttons.loading") }}</i></div>

  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Talk from 'talkjs'

export default {
  name: 'InboxFarmer',
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
      'getOffer',
      'getBooking'
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
    var myname = this.$auth.user.first_name
    var myemail = this.$auth.user.email
    var myid = (this.$auth.user.id).toString()
    var mypicture = 'https://www.agrivillage.fr/_nuxt/img/ad5ea91.svg'

    var adminid = (2013).toString()
    var adminname = 'Agrivillage'
    var adminemail = 'contact@agrivillage.fr'
    var adminpicture = 'https://www.agrivillage.fr/icon.png'

    var clientid = (this.getBooking.client.user.id).toString()
    var clientname = this.getBooking.client.user.first_name + ' ' + this.getBooking.client.user.last_name
    var clientemail = this.getBooking.client.user.email
    var clientpicture = 'https://www.staging.agrivillage.fr/_nuxt/img/3cee3d0.svg'

    var convurl = '<https://www.agrivillage.fr/offer/' + this.getOffer.id + '/' + this.residenceTypeAdress + '/' + this.getOffer.address.city + '>'
    var convsubject = convurl
    var convpicture = 'https://agrivillage.fr/icon.png'

    var chatid = (this.$auth.user.id).toString() + (this.getOffer.farmer.user.id).toString() + '|' + (this.getOffer.id).toString() + '/' + this.getBooking.id

    Talk.ready.then(function () {
      var me = new Talk.User({ id: myid, name: myname, email: myemail, photoUrl: mypicture, role: 'farmer' })

      var talkSession = new Talk.Session({
        appId: '0VMwLv0U',
        me: me
      })

      var other = new Talk.User({ id: clientid,
        name: clientname,
        email: clientemail,
        photoUrl: clientpicture,
        role: 'client'
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
}
</style>
