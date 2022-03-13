<template>
  <header
    :class="{ scrolled: scrolled, farmer: isFarmer }"
    class="app-header">
    <div class="wrap">
      <nuxt-link
        :to="'/'"
        class="app-header-logo">
        <img
          v-if="scrolled == false"
          id="logoWhite"
          src="@/assets/img/logo/logo_blanc.png"
          height="30"
          width="160"
          alt="logo"
          title="logo"
          @click="init"
        >
        <img
          v-if="scrolled == false"
          id="logoBlack"
          src="@/assets/img/logo/logo-nav-white.png"
          height="40"
          width="180"
          alt="logo"
          title="logo"
          @click="init"
        >
        <img
          v-if="scrolled == true"
          src="@/assets/img/logo/logo-nav.png"
          height="40"
          width="180"
          alt="logo"
          title="logo"
          @click="init"
        >
      </nuxt-link>
      <div class="app-header__mobile-nav">
        <button
          class="app-header__mobile-nav__button"
          @click="mobileOpen = !mobileOpen"
        >
          <i
            :class="{ 'farmer-material': isFarmer }"
            class="material-icons"
            aria-hidden="true"
          >{{ mobileOpen ? "close" : "menu" }}</i
          >
        </button>

        <div
          v-if="mobileOpen"
          class="app-header__mobile-nav__content">
          <div class="wrap">
            <div
              v-if="$auth.loggedIn"
              class="user-name">
              {{ $t("global.header.space_of") }} {{ $auth.user.first_name }}
            </div>
            <ul>
              <li>
                <nuxt-link
                  v-if="!isFarmer"
                  :to="{ name: 'OffersAll' }"
                  class="link"
                  @click.native="mobileFalse"
                >
                  {{ $t("global.header.stay") }}
                </nuxt-link>
              </li>
              <li>
                <nuxt-link
                  v-if="!isFarmer"
                  :to="{ name: 'Glamping' }"
                  class="link"
                  @click.native="mobileFalse"
                >
                  Glamping
                </nuxt-link>
              </li>

              <!-- Pages Tiny -->
              <li>
                <nuxt-link
                  v-if="!isFarmer"
                  :to="{ name: 'HomeTiny' }"
                  exact
                  class="link"
                  @click.native="mobileBtn"
                >
                  {{ $t("global.header.tinyHouse") }}
                </nuxt-link>
                <!--  <nuxt-link
                  v-if="!isFarmer"
                  :to="{ name: 'TinyConcept' }"
                  exact
                  class="link"
                  @click.native="mobileBtn"
                >
                  {{ $t("global.header.concept") }}
                </nuxt-link>
                <nuxt-link
                  v-if="!isFarmer"
                  :to="{ name: 'Materiaux' }"
                  exact
                  class="link"
                  @click.native="mobileBtn"
                >
                  {{ $t("global.header.materiaux") }}
                </nuxt-link> -->
              </li>
              <li>
                <nuxt-link
                  v-if="$auth.loggedIn && isFarmer"
                  :to="{ name: 'DashboardOffers' }"
                  exact
                  class="link"
                >
                  {{ $t("global.header.subnav.my_stays") }}
                </nuxt-link>
              </li>
              <li>
                <nuxt-link
                  v-if="$auth.loggedIn && isFarmer"
                  :to="{ name: 'DashboardActivities' }"
                  exact
                  class="link"
                >
                  {{ $t("global.header.subnav.my_activities") }}
                </nuxt-link>
              </li>
              <li>
                <nuxt-link
                  v-if="$auth.loggedIn && isFarmer"
                  :to="{ name: 'DashboardBookings' }"
                  exact
                  class="link"
                >
                  {{ $t("global.header.subnav.my_bookings") }}
                </nuxt-link>
              </li>
              <li>
                <nuxt-link
                  v-if="$auth.loggedIn && isClient"
                  :to="{ name: 'DashboardClientBookings' }"
                  exact
                  class="link"
                >
                  {{ $t("global.header.subnav.my_bookings") }}
                </nuxt-link>
              </li>
              <li>
                <nuxt-link
                  v-if="$auth.loggedIn && isClient"
                  :to="'/messenger'"
                  exact
                  class="link"
                  @click.native="mobileBtn"
                >
                  {{ $t("global.header.subnav.messenger") }}
                </nuxt-link>
              </li>
              <li v-if="!$auth.loggedIn">
                <nuxt-link
                  :to="{ name: 'Cadeaux' }"
                  class="link"
                  target="_blank"
                >
                  {{ $t("global.header.gift_box") }}

                  <img
                    alt="coffret"
                    title="coffret"
                    src="@/assets/img/home/coffret.png"
                    width="20"
                    height="20"
                  >
                </nuxt-link>
              </li>
              <li v-if="!$auth.loggedIn">
                <nuxt-link
                  :to="{ name: 'Blog' }"
                  class="link"
                  target="_blank">
                  {{ $t("global.header.blog") }}
                </nuxt-link>
              </li>
              <li>
                <nuxt-link
                  v-if="$auth.loggedIn && isFarmer"
                  :to="{
                    name: 'FarmerProfile',
                    params: {
                      id: $auth.user.farmer.id,
                      slug: `hote-${$auth.user.first_name}`
                    }
                  }"
                  class="link"
                >
                  {{ $t("global.header.subnav.my_profile") }}
                </nuxt-link>
              </li>
              <li>
                <button
                  v-if="!$auth.loggedIn"
                  type="button"
                  class="btn btn-primary become-btn"
                  @click="showModal"
                >
                  {{ $t("global.header.becomeClient") }}
                </button>
              </li>
              <br >
              <li>
                <nuxt-link
                  v-if="!$auth.loggedIn"
                  :to="{
                    name: 'SignIn'
                  }"
                  class="btn btn-primary become-btn"
                  @click.native="mobileOpen = false"
                >
                  {{ $t("global.header.becomeHost") }}
                </nuxt-link>
              </li>
            </ul>

            <modal
              v-show="isModalVisible"
              @closeModal="close" />

            <nuxt-link
              v-if="$auth.loggedIn"
              :to="{
                name: 'Index'
              }"
              class="btn btn-primary become-btn"
              @click.native="logout"
            >
              {{ $t("global.header.subnav.disconect") }}
            </nuxt-link>
          </div>
        </div>
      </div>
      <nav class="app-header-main-navigation">
        <ul>
          <li>
            <div class="app-header-menu">
              <div class="app-header-menu__infos">
                <nuxt-link
                  v-if="!isFarmer"
                  :to="{ name: 'OffersAll' }"
                  class="app-header-menu__title"
                >
                  {{ $t("global.header.stay") }}
                </nuxt-link>
                <nuxt-link
                  v-if="!isFarmer"
                  :to="{ name: 'Glamping' }"
                  class="link"
                >
                  Glamping
                </nuxt-link>
                <nuxt-link
                  v-if="isFarmer"
                  :to="'/dashboard/bookings'"
                  exact>
                  {{ $t("global.header.subnav.my_bookings") }}
                </nuxt-link>
                <nuxt-link
                  v-if="isFarmer"
                  :to="'/dashboard/offers'"
                  exact>
                  {{ $t("global.header.subnav.my_stays") }}
                </nuxt-link>
                <nuxt-link
                  v-if="isFarmer"
                  :to="'/messenger'"
                  exact>
                  {{ $t("global.header.subnav.messenger") }}
                </nuxt-link>

                <!-- Pages Tiny House -->

                <a class="app-header-menu__title dropdown">
                  <div class="dropbtn">
                    {{ $t("global.header.tinyHouse") }}
                    <i class="fas fa-bars" />
                  </div>
                  <div class="dropdown-content">
                    <nuxt-link
                      :to="{ name: 'HomeTiny' }"
                      style="width: 80%; font-size: 12px; color: black"
                    >
                      Le concept
                    </nuxt-link>
                    <nuxt-link
                      :to="{ name: 'OffersTinyHouse'}"
                      style="width: 80%; font-size: 12px; color: black">
                      Nos offres
                    </nuxt-link>
                  </div>
                </a>

                <nuxt-link
                  v-if="!isFarmer"
                  :to="{ name: 'Blog' }"
                  class="app-header-menu__title"
                  target="_blank"
                >
                  {{ $t("global.header.blog") }}
                </nuxt-link>
              </div>
            </div>
          </li>
        </ul>
      </nav>

      <app-header-subnav-home />
    </div>
  </header>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import AppHeaderSubnavHome from './_subs/AppHeaderSubnavHome'
import Modal from '@/components/Modal.vue'

export default {
  name: 'AppHeaderHome',
  components: {
    AppHeaderSubnavHome,
    Modal
  },
  data () {
    return {
      mobileOpen: false,
      scrolled: false,
      isModalVisible: false
    }
  },
  computed: {
    ...mapGetters(['isFarmer', 'isClient', 'getOffers'])
  },
  created () {
    if (this.$route.path === '/' || this.$route.path === '/nos-offres') {
      window.addEventListener('scroll', this.handleScroll2)
    } else {
      this.scrolled = true
    }
    window.addEventListener('scroll', this.handleScroll2)
  },
  mounted () {
    if (this.$route.path === '/' || this.$route.path === '/nos-offres') {
      window.addEventListener('scroll', this.handleScroll2)
    } else {
      this.scrolled = true
    }
  },
  beforeDestroy () {
    // window.removeEventListener('scroll', this.handleScroll)
    window.addEventListener('scroll', this.handleScroll2)
  },
  methods: {
    ...mapActions(['resetOffers']),
    handleScroll2 () {
      this.scrolled = window.scrollY > 30
    },
    init () {
      this.$parent.expl = true
      this.scrolled = false
      this.resetOffers()
    },
    mobileBtn () {
      this.mobileOpen = false
      this.$parent.expl = false
      this.$store.commit('SET_SEARCH_QUERY', '/offers')
      this.$axios
        .get('/v2/offers')
        .then(res => {
          this.$store.dispatch('setOffers', res.data.offers)
          this.$store.dispatch('setOffersMeta', res.data.meta)
        })
        .catch(err => {
          console.log('error', err)
        })
    },
    logout () {
      this.$auth.logout()
      this.mobileOpen = false
    },
    mapBtn () {
      this.mobileOpen = false
      this.$parent.expl = false
    },
    showModal () {
      this.isModalVisible = true
    },
    close (value) {
      this.isModalVisible = value
      this.mobileOpen = true
    },
    mobileFalse () {
      this.mobileOpen = false
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
@import "@/assets/scss/_mixins.scss";

#logoWhite{
  display: none;
    @media only screen and (min-width: $breakpoint-laptop-generic) {
    display: block;
    margin-left: 8%;
  }
}
#logoBlack{
  display: block;
    @media only screen and (min-width: $breakpoint-laptop-generic) {
    display: none;
  }
}

.user-name {
  text-align: center;
  text-transform: uppercase;
  color: #79bc53;
  font-weight: bold;
}
.dropdown-content {
  visibility: hidden;
  display: flex;
  position: absolute;
  background-color: #f9f9f9;
  min-width: 160px;
  text-align: center;
  align-items: center;
  box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
  z-index: 1;
  flex-direction: column;
}
.dropdown:hover .dropdown-content {
  visibility: visible;
}
.dropdown:hover .fa-bars {
  transform: rotateX(45);
}

.gift {
  width: 20px;
  height: 20px;
}

.become-btn {
  background-color: white !important;
  color: #252223 !important;
  padding: 0px 15px;
  border-radius: 50px;
  font-size: 12px;
  width: 100%;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}
.dropdown:hover .dropdown-content {
  visibility: visible;
}
.dropbtn:hover .fa-bars {
  transform: rotate(90deg);
  -webkit-transition: all 500ms ease;
  -moz-transition: all 500ms ease;
  -ms-transition: all 500ms ease;
  -o-transition: all 500ms ease;
}
.dropbtn .fa-bars {
  -webkit-transition: all 500ms ease;
  -moz-transition: all 500ms ease;
  -ms-transition: all 500ms ease;
  -o-transition: all 500ms ease;
}

.material-icons {
  font-family: "Material Icons" !important;
  color: #79bc53;
}

.farmer-material {
  font-family: "Material Icons" !important;
  color: white;
}

.app-header {
  position: fixed;
  z-index: 1300;
  top: 0;
  left: 0;
  width: 100%;
  height: 70px;
  box-shadow: 0 0 24px rgba(black, 0.12);

  a {
    color: white;
  }
  &.scrolled {
    box-shadow: 0 0 24px rgba(black, 0.12);
    background-color: white;

    a {
      color: black;
      @media only screen and (max-width: $breakpoint-tablet) {
        color: white;
      }
    }
  }
  transition: all 1s ease-out;
  border-bottom: 1px solid rgba(black, 0.05);

  .wrap {
    display: flex;
    height: 100%;
  }

  &-logo {
    display: flex;
    margin: auto 0;
    height: 55px;
    outline: none;
    border-radius: 6px;

    img {
      margin: auto 0;
    }

    &:focus {
      @include shadow($primary);
    }

    @media only screen and (max-width: $breakpoint-tablet) {
      height: 40px;

      img {
        height: 40px;
      }
    }
  }

  &-main-navigation {
    flex: 1;
    margin-left: 20vh;

    .app-header-menu {
      display: flex;
      position: relative;
      .item-title {
        height: 100%;
        line-height: 36px;
        color: #6d8d4c;
        &:hover {
          color: #96b577 !important;
        }

        &:hover::after {
          height: 0px !important;
        }
      }
      &__title {
        cursor: default;
      }
      &__item {
        display: none;
        position: absolute;
        background-color: white;
        top: 70px;
        left: 0;

        box-shadow: 0 5px 24px rgba(black, 0.12);
        padding: 10px;

        ul,
        li {
          margin: 0;
          padding: 0;
          list-style-type: none;
        }

        a {
          height: 100%;
          display: inline-block;
          text-decoration: none;
          color: $primary-text;
          font-style: none;
          white-space: nowrap;
        }
      }

      &__infos {
        display: flex;
        margin: auto 0;
      }

      &:hover {
        .app-header-menu__item {
          display: block !important;
        }
      }
    }

    ul,
    li {
      display: flex;
      list-style-type: none;
      margin: 0;
      padding: 0;
      height: 100%;
    }

    li {
      margin: auto 0;
    }

    a {
      position: relative;
      text-decoration: none;
      font-size: 12px;
      font-weight: 500;
      // text-transform: capitalize;
      height: 70px;
      line-height: 70px;
      margin: auto 0;

      outline: none;
      border-radius: 6px;
      padding: 0 20px;

      font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
        Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;

      &::after {
        background-color: rgba(black, 0.2);
        position: absolute;
        content: " ";
        height: 0;
        width: 100%;
        bottom: 0px;
        left: 0;
        right: 0;
        margin: 0 auto;

        transition: height 200ms;
      }

      &:focus {
        @include shadow($primary);
      }

      &:hover,
      &.router-link-active {
        &::after {
          height: 3px;
        }
      }

      &.router-link-active {
        &::after {
          background-color: $primary;
        }
      }
    }
  }

  &__mobile-nav {
    display: none;

    &__button {
      appearance: none;
      background: transparent;
      border: none;
      cursor: pointer;
      z-index: 10;
      margin-left: 5px;
    }

    &__content {
      display: none;
      position: absolute;
      left: 0;
      top: 0;
      width: 100vw;
      height: 100vh;
      padding-top: 100px;

      background-color: #252223;

      ul,
      li {
        margin: 0;
        padding: 0;
        color: white;
        list-style-type: none;
      }

      ul {
        margin-bottom: 16px;

        a {
          display: flex;
          height: 45px;
          line-height: 45px;
          text-align: center;
          justify-content: center;
        }
      }

      .link {
        color: $primary-text;
        text-decoration: none;
        @media only screen and (max-width: $breakpoint-tablet) {
          color: white;
        }
      }

      .wrap {
        display: flex;
        flex-direction: column;
        justify-content: flex-start !important;
      }
    }
  }
  // @media only screen and (min-width: $breakpoint-laptop-m) {
  //   .app-header-main-navigation{
  //     margin-left: 45px;
  //   }
  //
  // }

  @media only screen and (max-width: $breakpoint-tablet) {
    .app-header__mobile-nav__button {
      margin-left: 35px !important;
    }
    &-main-navigation {
      display: none;
    }

    &-subnav {
      display: none;
    }

    &__mobile-nav {
      order: 0;
    }

    .wrap {
      justify-content: center;
    }
  }

  @media only screen and (max-width: $breakpoint-laptop-m) {
    &-subnav {
      display: none !important;
    }

    &__mobile-nav {
      display: flex;
      order: 1;

      &__content {
        display: flex;

        .wrap {
          padding: 0 16px;
        }
      }
    }
  }
}
.farmer {
  position: fixed;
  z-index: 1300;
  top: 0;
  left: 0;
  width: 100%;
  height: 70px;
  box-shadow: 0 0 24px rgba(black, 0.12);
  background-color: $agri-green;
  border-bottom: 1px solid rgba(black, 0.05);

  a {
    color: white;
  }

  .wrap {
    display: flex;
    height: 100%;
  }

  &-logo {
    display: flex;
    margin: auto 0;
    height: 55px;
    outline: none;
    border-radius: 6px;

    img {
      margin: auto 0;
    }

    &:focus {
      @include shadow($primary);
    }

    @media only screen and (max-width: $breakpoint-tablet) {
      height: 40px;

      img {
        height: 40px;
      }
    }
  }

  &-main-navigation {
    flex: 1;
    margin-left: 10vh;

    .app-header-menu {
      display: flex;
      position: relative;
      .item-title {
        height: 100%;
        line-height: 36px;
        color: #6d8d4c;
        &:hover {
          color: #96b577 !important;
        }

        &:hover::after {
          height: 0px !important;
        }
      }
      &__title {
        cursor: default;
      }
      &__item {
        display: none;
        position: absolute;
        background-color: white;
        top: 70px;
        left: 0;

        box-shadow: 0 5px 24px rgba(black, 0.12);
        padding: 10px;

        ul,
        li {
          margin: 0;
          padding: 0;
          list-style-type: none;
        }

        a {
          height: 100%;
          display: inline-block;
          text-decoration: none;
          color: $primary-text;
          font-style: none;
          white-space: nowrap;
        }
      }

      &__infos {
        display: flex;
        margin: auto 0;
      }

      &:hover {
        .app-header-menu__item {
          display: block !important;
        }
      }
    }

    ul,
    li {
      display: flex;
      list-style-type: none;
      margin: 0;
      padding: 0;
      height: 100%;
    }

    li {
      margin: auto 0;
    }

    a {
      position: relative;
      text-decoration: none;
      font-size: 12px;
      font-weight: 500;
      // text-transform: capitalize;
      height: 70px;
      line-height: 70px;
      margin: auto 0;

      outline: none;
      border-radius: 6px;
      padding: 0 20px;

      font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
        Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;

      &::after {
        background-color: rgba(black, 0.2);
        position: absolute;
        content: " ";
        height: 0;
        width: 100%;
        bottom: 0px;
        left: 0;
        right: 0;
        margin: 0 auto;

        transition: height 200ms;
      }

      &:focus {
        @include shadow($primary);
      }

      &:hover,
      &.router-link-active {
        &::after {
          height: 3px;
        }
      }

      &.router-link-active {
        &::after {
          background-color: $agri-yellow;
        }
      }
    }
  }

  &__mobile-nav {
    display: none;

    &__button {
      appearance: none;
      background: transparent;
      border: none;
      cursor: pointer;
      z-index: 10;
      margin-left: 5px;
    }

    &__content {
      display: none;
      position: absolute;
      left: 0;
      top: 0;
      width: 100vw;
      height: 100vh;
      padding-top: 100px;

      background-color: #252223;

      ul,
      li {
        margin: 0;
        padding: 0;
        list-style-type: none;
      }

      ul {
        margin-bottom: 16px;

        a {
          display: flex;
          height: 45px;
          line-height: 45px;
          text-align: center;
          justify-content: center;
        }
      }

      .link {
        color: $primary-text;
        text-decoration: none;
        @media only screen and (max-width: $breakpoint-tablet) {
          color: white;
        }
      }

      .wrap {
        display: flex;
        flex-direction: column;
        justify-content: flex-start !important;
      }
    }
  }
  // @media only screen and (min-width: $breakpoint-laptop-m) {
  //   .app-header-main-navigation{
  //     margin-left: 45px;
  //   }
  //
  // }

  @media only screen and (max-width: $breakpoint-tablet) {
    .app-header__mobile-nav__button {
      margin-left: 35px !important;
      color: white;
    }
    &-main-navigation {
      display: none;
    }

    &-subnav {
      display: none;
    }

    &__mobile-nav {
      order: 0;
    }

    .wrap {
      justify-content: center;
    }
  }

  @media only screen and (max-width: $breakpoint-laptop-m) {
    &-subnav {
      display: none !important;
    }

    &__mobile-nav {
      display: flex;
      order: 1;

      &__content {
        display: flex;

        .wrap {
          padding: 0 16px;
        }
      }
    }
  }
}
@media only screen and (max-width: $breakpoint-laptop-l) {
  .app-header-main-navigation {
    a {
      font-size: 15px;
    }
  }
}
@media only screen and (max-width: $breakpoint-laptop-m) {
  .app-header-main-navigation {
    a {
      padding: 0 9px;
      font-size: 12px;
    }
  }
}

@media only screen and (max-width: $breakpoint-laptop-generic) {
  .app-header-main-navigation {
    margin-left: 5vh;
  }
}
</style>
