<template>

  <cloudinary
    v-if="isFarmer && farmer.farmerpictures.length"
    :public-id="farmer.farmerpictures[0].public_id"
    :transformations="{
      w: 40,
      h: 40,
      c: 'fill',
      f: 'jpg',
      fl: 'progressive'
    }"
    :alt="farmer.first_name"
    class="app-avatar-picture"
  />

  <div v-else>
    <img
      v-if="isFarmer"
      src="~assets/img/user/farmer.svg"
      class="default-profile"
      title="profile"
      alt="profile">
    <img
      v-else
      src="~assets/img/user/client-nav.svg"
      class="default-profile"
      title="profile"
      alt="profile">
  </div>

</template>

<script>
  import { mapGetters } from 'vuex'
  import Cloudinary from '@/components/Cloudinary'

  export default {
    name: 'AppAvatar',
    components: {
      Cloudinary
    },
    props: {
      user: {
        type: Object,
        required: true
      }
    },
    computed: {
      ...mapGetters(['isFarmer']),
      initials () {
        return `${this.user.first_name.charAt(0)}${this.user.last_name.charAt(0)}`
      },

      farmer () {
        return this.user.farmer
      }
    }
  }
</script>

<style lang="scss" scoped>

  .default-profile {
    width: 40px;
    height: 40px;
    border-radius: 100%;
    background-color: white;
  }

  .app-avatar{
    background-color: #EAEAEA;
    color: rgba(black, 0.86);
    border-radius: 100%;
    width: 40px;
    height: 40px;
    text-align: center;
    line-height: 40px;
    text-transform: uppercase;
  }

  .app-avatar-picture{
    width: 40px;
    height: 40px;
    border-radius: 100%;
  }
</style>
