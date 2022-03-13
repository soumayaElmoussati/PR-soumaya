<template>
  <div class="offer-farmer-details">

    <h3 class="content-title">
      {{ $t("offer.titles.yourFarmer") }}
    </h3>

    <div class="divider" />

    <div class="farmer-infos">

      <nuxt-link
        :to="{
          name: 'FarmerProfile',
          params: {
            id: getOffer.farmer.id,
            slug: `hote-${getOffer.farmer.user.first_name}`
          }
        }"
        class="profile-link"
      >

        <div class="farmer-image">
          <cloudinary
            v-if="getOffer.farmer.farmerpictures.length"
            :public-id="getOffer.farmer.farmerpictures[0].public_id"
            :transformations="{
              w: 65,
              h: 65,
              c: 'fill',
              f: 'jpg',
              fl: 'progressive'
            }"
            :alt="getOffer.farmer.user.first_name"
            class="profile-cloudinary"
          />
          <div v-else>
            <img
              src="~assets/img/user/farmer.svg"
              class="default-profile"
              alt="profile">
            <img
              v-if="isAmbassador"
              alt="ambassadeur"
              src="@/assets/img/offer/ambassadeur.png"
              class="badge-ambassador"
              width="30"
              height="37">
          </div>
        </div>

      </nuxt-link>

      <div class="farmer-desc">

        <nuxt-link
          :to="{
            name: 'FarmerProfile',
            params: {
              id: getOffer.farmer.id,
              slug: `hote-${getOffer.farmer.user.first_name}`
            }
          }"
        >
          <p class="farmer-name">{{ getOffer.farmer.user.first_name }}</p>
        </nuxt-link>
        <p class="farmer-name">{{ getOffer.address.city }}</p>
        <p
          v-if="getOffer.farmer.description"
          class="farmer-text"
        >
          {{ getOffer.farmer.description }}
        </p>
        <p
          v-else-if="getOffer.description.farmer"
          class="farmer-text"
        >
          {{ getOffer.description.farmer }}
        </p>

      </div>

    </div>

  </div>
</template>

<script>
  import { mapGetters } from 'vuex'
  import Cloudinary from '@/components/Cloudinary'
  import OfferRules from '@/components/Offer/OfferRules'

  /**
   * @module component - OfferFarmerDetails
   */
  export default {
    name: 'OfferFarmerDetails',
    components: {
      Cloudinary,
      OfferRules
    },
    computed: {
      ...mapGetters([
        'getOffer'
      ]),
      isAmbassador () {
        // NOTE: L'Agriculteur est un ambassadeur
        if (this.getOffer.farmer.user.ambassador === true) {
          return true
        } else {
          return false
        }
      }
    }
  }
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

  .divider {
    height: 1px;
    background-color: rgba(black, 0.3);
    margin-top: 16px;
    margin-bottom: 16px;
  }

  .content-title {
    text-transform: uppercase;
    color: #476458;
    font-size: 21px;
    font-weight: 900;
  }

  .farmer-infos {
    display: grid;
    grid-template-columns: auto auto;
    grid-gap: 10px;
    @media only screen and (max-width: $breakpoint-tablet) {
      display: flex;
    }
  }

  .farmer-image {
    align-self: center;
    justify-self: center;
  }

  .default-profile {
    width: 100px;
    height: 100px;
    border-radius: 100%;
  }

  .farmer-name {
    font-size: 14px;
    font-weight: bold;
    color: #476458;
  }

  .badge-ambassador {
    position: absolute;
    margin-top: 60px;
    left: 250px;
    @media only screen and (max-width: $breakpoint-mobile-l) {
      left: 0px;
    }
  }

  .farmer-text {
    color: #476458;
    font-size: 14px;
  }

  .profile-cloudinary {
    width: 100px;
    height: 100px;
    border-radius: 100%;
  }

  .profile-link {
    @media only screen and (max-width: $breakpoint-mobile-l) {
      margin: auto;
    }
  }

</style>
