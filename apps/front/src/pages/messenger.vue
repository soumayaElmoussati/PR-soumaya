<template>
  <div class="inbox-container">
    <messaging />
  </div>
</template>

<script>
import Messaging from '@/components/Messaging.vue'

export default {
  name: 'Messenger',
  middleware: 'auth',
  components: {
    Messaging
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
