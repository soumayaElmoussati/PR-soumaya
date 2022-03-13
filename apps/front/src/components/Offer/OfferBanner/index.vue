<template>

  <div class="offer-banner">
    <nuxt-link
      :to="{
        name: 'FarmerProfile',
        params: {
          id: getOffer.farmer.id,
          slug: `hote-${getOffer.farmer.user.first_name}`
        }
      }"
      class="offer-link-banner"
      target="_blank"
    >

      <div class="offer-card-image">
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
          class="banner-cloudinary"
        />
        <div v-else>
          <img
            src="~assets/img/user/farmer-banner.png"
            class="default-profile"
            alt="profile">
          <img
            v-if="isAmbassador"
            alt="ambassadeur"
            src="@/assets/img/offer/ambassadeur.png"
            class="badge-ambassador"
            width="20"
            height="25">
        </div>
        <p class="farmer-name">{{ getOffer.farmer.user.first_name }}</p>
      </div>

    </nuxt-link>

    <div class="offer-banner-infos">

      <div class="offer-banner-infos-title">

        <h1 class="banner-title">{{ getOffer.address.state || getOffer.address.city }} - {{ $t('global.labels.housingType.'+getOffer.residence_type) }}</h1>

        <img
          v-if="isCertified"
          alt="certificated"
          src="@/assets/img/offer/certifie.png"
          class="badge-certificated"
          width="27"
          height="34">

      </div>

    </div>

    <div class="offer-organisations">

      <img
        v-if="isBbc"
        alt="bleu-blanc-coeur"
        src="@/assets/img/logo/bleublanccoeur.png"
        class="badge-bbc"
        width="84"
        height="84">

      <img
        v-if="isAdb"
        alt="agriculteurs-de-bretagne"
        src="@/assets/img/offer/adb-badge.png"
        class="badge-adb"
        width="160"
        height="50">

      <img
        v-if="isFairefrance"
        alt="faire-france"
        src="@/assets/img/logo/faire-france.png"
        class="badge-bbc"
        width="84"
        height="84">

    </div>

    <p class="offer-banner-agricultures">
      {{ farmType }}

      <br>

      {{ agricultureType }}
    </p>

  </div>

</template>

<script>
import { mapGetters } from 'vuex'
import Cloudinary from '@/components/Cloudinary'

export default {
  name: 'OfferBanner',
  components: {
    Cloudinary
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
    },
    isCertified () {
      // NOTE: L'Offre est certifier
      if (this.getOffer.certificated === true) {
        return true
      } else {
        return false
      }
    },
    isBbc () {
      // NOTE: L'Agriculteur est un membre de Bleu Blanc Coeur
      if (!!this.getOffer.farmer.organisation && this.getOffer.farmer.organisation.bbc === true) {
        return true
      } else {
        return false
      }
    },
    isFairefrance () {
      // NOTE: L'Agriculteur est un membre de Bleu Blanc Coeur
      if (!!this.getOffer.farmer.organisation && this.getOffer.farmer.organisation.fairefrance === true) {
        return true
      } else {
        return false
      }
    },
    isAdb () {
      // NOTE: L'Agriculteur est un membre de Bleu Blanc Coeur
      if (!!this.getOffer.farmer.organisation && this.getOffer.farmer.organisation.adb === true) {
        return true
      } else {
        return false
      }
    },
    farmType () {
      var farmTypesIndex = this.getOffer.farm_type
      var farmTypes = []
      for (var prop in farmTypesIndex) {
        if (farmTypesIndex[prop] && prop !== 'id') {
          farmTypes.push(prop)
        }
      }
      return [...(farmTypes || [])]
        .filter(v => v.length > 1)
        .map((v) => {
          return this.$t(`offer.farmTypes.${v}`)
        })
        .join(' - ')
    },
    agricultureType () {
      var agricultureTypesIndex = this.getOffer.agriculture_type
      var agricultureTypes = []
      for (var prop in agricultureTypesIndex) {
        if (agricultureTypesIndex[prop] && prop !== 'id') {
          agricultureTypes.push(prop)
        }
      }
      return [...(agricultureTypes || [])]
        .filter(v => v.length > 1)
        .map((v) => {
          return this.$t(`offer.agricultureTypes.${v}`)
        })
        .join(' - ')
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
@import "@/assets/scss/_mixins.scss";

// BANNER

.offer-banner {
  background-color: rgba(71, 100, 88, .5);
  width: 100%;
  position: absolute;
  top: 43vh;
  height: 16vh;
  display: grid;
  grid-template-columns: auto auto auto auto;
  grid-column-gap: 20px;

  color: white;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  @media only screen and (max-width: $breakpoint-tablet) {
    grid-template-columns: auto auto;
    top: 37vh;
    height: 25vh;
  }
  @media only screen and (max-width: $breakpoint-mobile-large) {
    position: relative;
    height: 15vh;
    top: 0vh;
    background-color: rgba(71, 100, 88, .9);
    grid-template-columns: auto auto auto auto;
    grid-column-gap: 5px;
  }
}

.offer-banner-infos-title {
  display: grid;
  grid-template-columns: auto;
}

.banner-title {
  font-size: 14px;
  color: white;
}

// AVATAR BOX

.default-profile {
  width: 65px;
  height: 65px;
  border-radius: 100%;

  @media only screen and (max-width: $breakpoint-mobile-l) {
    width: 38px;
    height: 38px;
  }
}

.farmer-name {
  font-size: 14px;
  text-align: center;
  color: white;
  text-decoration: none;
  margin-top: auto;
}

.badge-ambassador {
  position: absolute;
  bottom: 50px;
  left: 90px;
  @media only screen and (max-width: $breakpoint-mobile-l) {
    bottom: 100px;
  }
}

// OFFER INFOS

.offer-banner-infos {

  @media only screen and (max-width: $breakpoint-mobile-l) {
    line-height: 100%;
    align-self: center;
    justify-self: center;
  }
}

.offer-banner-infos-title {
  text-transform: uppercase;
  color: white;
  font-weight: bold;
  font-size: 14px;
  @media only screen and (max-width: $breakpoint-mobile-l) {
    font-size: 9px;
  }
}

.offer-banner-infos-desc {
  color: white;
  font-size: 14px;
  @media only screen and (max-width: $breakpoint-mobile-l) {
    font-size: 10px;
  }
}

.offer-banner-agricultures {
  color: white;
  font-size: 16px;
  justify-self: center;
  @media only screen and (max-width: $breakpoint-mobile-l) {
    font-size: 10px;
  }
}

.banner-cloudinary {
  width: 65px;
  height: 65px;
  border-radius: 100%;
  margin: auto;
}

.offer-link-banner {
  align-self: center;
  justify-self: center;
  @media only screen and (max-width: $breakpoint-tablet) {
    align-self: stretch;
    justify-self: start;
  }
}
</style>
