<template>
  <div
    id="talkjs-container"
    style="width: 100%; height: 500px"><i>{{ $t("bookingTiny.buttons.loading") }}</i></div>
</template>

<script>
import { mapGetters } from 'vuex'
import Talk from 'talkjs'

export default {
  name: 'InboxActivity',
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
      'getActivity'
    ])
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

    var farmerid = (this.getActivity.farmer.user.id).toString()
    var farmername = this.getActivity.farmer.user.first_name
    var farmeremail = this.getActivity.farmer.user.email
    var farmerpicture = 'https://www.agrivillage.fr/_nuxt/img/ad5ea91.svg'

    var convurl = '<https://www.agrivillage.fr/activity/' + this.getActivity.id + '/' + this.getActivity.slug + '|' + this.getActivity.name + '>'
    var convsubject = convurl
    var convpicture = 'https://agrivillage.fr/icon.png'

    var chatid = (this.$auth.user.id).toString() + (this.getActivity.farmer.user.id).toString() + '|' + (this.getActivity.id).toString() + '/' + this.getActivity.slug

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
        email: adminemail
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
</style>
