<template>
  <div class="edit-offer">
    <div class="wrap">
      <div class="edit-offer__menu">
        <nav>
          <ul>
            <li
              style="border"
              class="offer-name expl-name">
              {{ getCurrentOffer.name }}
              <div class="line" />
            </li>
            <li>
              <nuxt-link
                :to="{
                  name: 'EditOfferOffer'
                }"
              >
                {{ $t("offer.titles.yourResidence") }}
              </nuxt-link>
              <div class="lines" />
            </li>
            <li>
              <nuxt-link
                :to="{
                  name: 'EditOfferHousing'
                }"
              >
                {{ $t("offer.titles.featureResidence") }}
              </nuxt-link>
              <div class="lines" />
            </li>
            <li>
              <nuxt-link
                :to="{
                  name: 'EditOfferRules'
                }"
              >
                {{ $t("offer.titles.rules") }}
              </nuxt-link>
              <div class="lines" />
            </li>
            <li>
              <nuxt-link
                :to="{
                  name: 'EditOfferFarm'
                }"
              >
                {{ $t("offer.titles.operation") }}
              </nuxt-link>
              <div class="lines" />
            </li>
            <li>
              <nuxt-link
                :to="{
                  name: 'EditOfferService'
                }"
              >
                {{ $t("offer.titles.service") }}
              </nuxt-link>
              <div class="lines" />
            </li>
            <li>
              <nuxt-link
                :to="{
                  name: 'EditOfferPrice'
                }"
              >
                {{ $t("offer.titles.rate") }}
              </nuxt-link>
              <div class="lines" />
            </li>
            <li>
              <nuxt-link
                :to="{
                  name: 'EditOfferPictures'
                }"
              >
                {{ $t("offer.titles.picture") }}
              </nuxt-link>
              <div class="lines" />
            </li>
            <li>
              <nuxt-link
                :to="{
                  name: 'EditOfferAnnexes'
                }"
              >
                {{ $t("offer.titles.annexes") }}
              </nuxt-link>
              <div class="lines" />
            </li>
            <li>
              <nuxt-link
                :to="{
                  name: 'EditOfferCalendar'
                }"
              >
                {{ $t("offer.titles.calendar") }}
              </nuxt-link>
              <div class="lines" />
            </li>
          </ul>
        </nav>
      </div>
      <div class="side">
        <nuxt />
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

import Cloudinary from '@/components/Cloudinary'

export default {
  name: 'EditOffer',
  components: {
    Cloudinary
  },
  fetch ({ app, route, store }) {
    return app.$axios.get(`/offers/${route.params.id}`).then(res => {
      if (res.status === 200) {
        store.commit('SET_CURRENT_OFFER', res.data)
      }
    })
  },
  computed: {
    ...mapGetters(['getCurrentOffer'])
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
@import "@/assets/scss/_mixins.scss";
.edit-offer {
  .wrap {
    display: flex;
    width: 100%;
    max-width: none;
  }

  .side {
    width: 90%;
    @media screen and (max-width: 768px) {
      width: 100%;
    }
  }

  &__menu {
    background-color: #476458;
    width: 25%;
    @media screen and (max-width: 768px) {
      display: none;
    }

    ul,
    li {
      list-style-type: none;
      margin: 0;
      padding: 0;
    }

    li {
      padding: 20px;
      color: black !important;
      margin-top: 15px;
      .line {
        border-bottom: 1px solid black;
        margin-top: 1em;
      }
      .lines {
        border-bottom: 1px solid black;
        width: 70%;
        margin: 1em auto 0 auto;
      }
    }

    ul {
      display: flex;
      flex-direction: column;
    }

    a {
      color: white;
      text-transform: uppercase;
      font-size: 13px;
      text-decoration: none;
      text-align: center;
      font-weight: bold;
      font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
        Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    }

    .offer-name {
      color: white !important;
      text-transform: uppercase;
      font-size: 13px;
      text-decoration: none;
      text-align: center;
      font-weight: bold;
      font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
        Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    }
    .expl-name {
      font-size: 17px !important;
    }
  }
}

@media screen and (max-width: 768px) {
  .edit-offer {
    .side {
      width: 100%;
    }

    &__menu {
      display: none;
    }
  }
}
.router-link-active {
  color: $tiny-text !important;
}
</style>
