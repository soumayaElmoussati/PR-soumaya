<template>
  <nuxt-link
    :to="{
      name: 'Offer',
      params: {
        id: offer.id,
        slug: offer.slug,
        domaine: residenceType
      }
    }"
    class="offer-card"
    target="_blank"
  >
    <div class="offer-card-image">
      <nuxt-link
        v-if="!isManaged"
        :to="{ name: 'EditOfferOffer', params: { id: offer.id } }"
        class="btn btn-agri"
        style="box-shadow: none !important"
      >
        {{ $t("global.crud.edit") }}
      </nuxt-link>

      <nuxt-link
        :to="{ name: 'EditOfferCalendar', params: { id: offer.id } }"
        class="btn btn-agri space-card"
        style="box-shadow: none !important"
      >
        {{ $t("global.crud.calendar") }}
      </nuxt-link>

      <div style="display: flex;">
        <div>
          <nuxt-link
            v-if="isManaged"
            :to="{
              name: 'Expenses',
              params: { id: offer.id, slug: offer.slug, domaine: residenceType }
            }"
            class="btn btn-agri"
            style="box-shadow: none !important"
          >
            {{ $t("global.crud.expense") }}
          </nuxt-link>
        </div>
      </div>

      <cloudinary
        v-if="offer.pictures.length"
        :public-id="offer.pictures[0].public_id"
        :itemkey="offer.id.toString()"
        :transformations="{
          w: 214,
          h: 260,
          c: 'fill',
          f: 'jpg',
          fl: 'progressive'
        }"
        :alt="offer.name"
      />
      <div
        v-else
        class="offer-card-image__empty">
        <span>
          {{ $t("offer.titles.no_images") }}
        </span>
      </div>
    </div>

    <div class="offer-card-informations">
      <div class="infos-secondary">
        {{ residenceType }}, ,
        {{ $tc("search.card.people", people, { number: people }) }} -
        <b>{{ stateType }}</b>
      </div>

      <div class="infos-title">
        {{ offer.name }}
      </div>

      <div class="infos-price">
        <p>
          {{ $t("search.card.from") }}
          <span
            class="price"
          >{{ getBasePrice | currency }}
            {{ $t("search.card.per_night") }}</span
            >
        </p>
      </div>
    </div>
  </nuxt-link>
</template>

<script>
import moment from 'moment'
import Cloudinary from '@/components/Cloudinary'

export default {
  name: 'OfferCardPrivate',
  components: {
    Cloudinary
  },
  props: {
    offer: {
      type: Object,
      default: null
    }
  },
  computed: {
    getBasePrice () {
      // NOTE: Price per night and person
      return this.offer.price_per_person
    },
    people () {
      // NOTE: Sleeps of Offer
      return this.offer.sleeps_count
    },
    // NOTE: Residence type in French
    residenceType () {
      switch (this.offer.residence_type) {
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
          return 'LogementEnImmersion'
      }
    },
    // NOTE: Offer state in French
    stateType () {
      switch (this.offer.state) {
        case 'draft':
          return 'Brouillon'
        case 'pending_validation':
          return 'En attente de validation'
        case 'published':
          return 'Publiée'
      }
    },
    // NOTE: Check if Offer have a promotion
    hasPromotion () {
      var l = this.offer.promotions.length - 1
      if (l === -1) {
        return false
      } else {
        return true
      }
    },
    // NOTE: Farmer is ambassador member
    isAmbassador () {
      if (this.offer.farmer.user.ambassador === true) {
        return true
      } else {
        return false
      }
    },
    // NOTE: Check if Offer is managed
    isManaged () {
      if (this.offer.manager === true) {
        return true
      } else {
        return false
      }
    },
    // NOTE: Offer is certificated
    isCertified () {
      if (this.offer.certificated === true) {
        return true
      } else {
        return false
      }
    },
    // NOTE: Get the offer promotion
    getPromotion () {
      return this.offer.promotions[0]
    },
    // NOTE: Start date of the promotion
    getStartDate () {
      return moment(this.offer.promotions[0].start_date).format('DD/MM')
    },
    // NOTE: End date of the promotion
    getEndDate () {
      return moment(this.offer.promotions[0].end_date).format('DD/MM')
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.space-card {
  margin-left: 11vw;
  @media only screen and (max-width: $breakpoint-mobile-large) {
    margin-left: 40vw;
  }
}

.edit-calendar {
  background-color: white;
  width: 30px;
  height: 30px;
  text-align: center;
  border-radius: 100%;
  position: absolute;
  margin-left: 30vh;
}

.edit-icon {
  vertical-align: middle;
}

.promotion-box {
  position: absolute;

  background-color: #efce4a;
  padding: 0px 10px;
  box-shadow: 0px 0px 10px black;

  display: grid;
  grid-template-columns: auto auto;
  justify-content: space-around;

  border-radius: 10px;
  margin-left: 10vh;
  margin-top: 2vh;
}

.promotion-text {
  color: black;
  text-transform: uppercase;
  font-weight: bold;
  font-size: 11px;
}

.promotion-amount {
  color: $agri-green;
}

.badge-ambassador {
  position: absolute;
}

.price {
  text-transform: uppercase;
  font-size: 11px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  font-weight: 800;
}

.offer-card {
  display: flex;
  flex-direction: column;
  text-decoration: none;
  width: 214px;
  height: 352px;
  box-shadow: 0 8px 6px -6px black;
  width: 100%;

  &-image {
    display: flex;
    background-color: lighten(#d1d1d1, 10%);
    height: 100%;
    width: 100%;
    border-top-left-radius: 6px;
    border-top-right-radius: 6px;
    // margin-bottom: 6px;
    width: 100%;

    .cloudinary {
      display: flex;
      width: 100%;
      height: 100%;
      object-fit: cover;
      border-top-left-radius: 6px;
      border-top-right-radius: 6px;
      overflow: hidden;

      background-color: $agri-grey;
    }

    &__empty {
      display: flex;
      flex-direction: column;
      color: rgba(black, 0.5);
      margin: auto;
    }
  }

  &-informations {
    background-color: $agri-green;
    width: 100%;
    height: 103px;

    border-bottom-left-radius: 6px;
    border-bottom-right-radius: 6px;

    .infos {
      &-secondary {
        font-size: 12px;
        font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
          Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
        color: white;
        margin-top: 12px;
        text-align: center;
      }

      &-title {
        font-size: 14px;
        font-weight: 800;
        font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
          Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
        text-transform: uppercase;
        color: white;
        margin-top: 12px;
        text-align: center;
      }

      &-third {
        color: white;
        font-size: 8px;
        font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
          Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
        font-weight: 800;
        text-align: center;

        display: grid;
        grid-template-columns: 25% 58%;
      }

      &-price {
        color: white;
        font-size: 8px;
        margin-top: 12px;
        font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
          Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
        font-weight: 800;
        text-align: center;
      }
    }
  }
}
</style>
