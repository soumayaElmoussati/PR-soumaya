<template>
  <div
    v-if="$auth.loggedIn"
    class="app-header-user">
    <div class="app-header-user__infos">
      <app-avatar
        :user="$auth.user"
      />
    </div>
    <nav class="app-header-user__menu">
      <ul>
        <li v-if="$auth.loggedIn && isFarmer">
          <img
            src="@/assets/img/user/farmer.svg"
            height="17"
            alt="profil"
            title="profil">
          <nuxt-link
            v-if="isFarmer"
            :to="{
              name: 'FarmerProfile',
              params: {
                id: $auth.user.farmer.id,
                slug: `hote-${$auth.user.first_name}`
              }
            }"
          >
            {{ $t("global.header.profil") }}
          </nuxt-link>
        </li>
        <li v-if="$auth.loggedIn && isClient">
          <img
            src="@/assets/img/nav/mail.svg"
            height="17"
            alt="messenger"
            title="messenger">
          <nuxt-link
            :to="'/messenger'"
            exact
          >
            {{ $t('global.header.subnav.messenger') }}
          </nuxt-link>
        </li>
        <li v-if="$auth.loggedIn && isFarmer">
          <img
            src="@/assets/img/nav/faq.png"
            height="17"
            alt="faq"
            title="faq">
          <a
            href="https://blog.agrivillage.fr/faq-agriculteurs"
            target="_blank"
          >
            {{ $t('global.header.subnav.faq') }}
          </a>
        </li>
        <li v-if="$auth.loggedIn && isClient">
          <img
            src="@/assets/img/nav/booking.svg"
            height="17"
            alt="bookings"
            title="bookings">
          <nuxt-link
            :to="'/dashboard/client-bookings'"
            exact
          >
            {{ $t('global.header.subnav.my_bookings') }}
          </nuxt-link>
        </li>
        <li>
          <img
            src="@/assets/img/nav/logout.svg"
            height="17"
            alt="signout"
            title="signout">
          <nuxt-link
            v-if="$auth.loggedIn"
            :to="{
              name: 'Index'
            }"
            @click.native="logout"
          >
            {{ $t('global.header.subnav.disconect') }}
          </nuxt-link>
        </li>
      </ul>
    </nav>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'
  import AppAvatar from '@/components/Global/AppAvatar'

  export default {
    name: 'AppHeaderUserHome',
    components: {
      AppAvatar
    },
    computed: {
      ...mapGetters(['isFarmer', 'isClient'])
    },
    methods: {
      logout () {
        this.$auth.logout()
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .app-header-user{
    display: flex;
    position: relative;
    width: 200px;

    &__menu {
      display: none;
      position: absolute;
      background-color: white;
      top: 70px;
      right: 0;

      min-width: 200px;

      box-shadow: 0 5px 24px rgba(black, 0.12);
      padding: 16px;

      ul, li{
        margin: 0;
        padding: 0;
        list-style-type: none;
      }

      a {
        display: inline-block;
        text-decoration: none;
        color: $primary-text;
        font-style: none;
        white-space: nowrap;
        line-height: 30px;
      }
    }

    &__infos {
      display: flex;
      margin: auto;
    }

    &:hover {
      .app-header-user__menu {
        display: block !important;
      }
    }

    &__name{
      text-transform: capitalize;
    }

    &__name, .app-avatar{
      margin: auto 10px;
      color: black;
    }

    .app-avatar{
      margin-right: 16px;
      color: black;
    }
  }
</style>
