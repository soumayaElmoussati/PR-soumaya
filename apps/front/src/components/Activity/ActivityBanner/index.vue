<template>

  <div class="offer-banner">

    <nuxt-link
      :to="{
        name: 'FarmerProfile',
        params: {
          id: getActivity.farmer.id,
          slug: `hote-${getActivity.farmer.user.first_name}`
        }
      }"
      class="offer-link-banner"
      target="_blank"
    >

      <div class="offer-card-image">

        <cloudinary
          v-if="getActivity.farmer.farmerpictures.length"
          :public-id="getActivity.farmer.farmerpictures[0].public_id"
          :transformations="{
            w: 65,
            h: 65,
            c: 'fill',
            f: 'jpg',
            fl: 'progressive'
          }"
          :alt="getActivity.farmer.user.first_name"
          class="banner-cloudinary"
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
            width="20"
            height="25">
        </div>
        <p class="farmer-name">{{ getActivity.farmer.user.first_name }}</p>
      </div>

    </nuxt-link>

    <div class="offer-banner-infos">

      <div class="offer-banner-infos-title">
        {{ getActivity.name }}
      </div>

      <p class="offer-banner-infos-desc">{{ getActivity.activity_address.state || getActivity.activity_address.city }}</p>

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
  name: 'ActivityBanner',
  components: {
    Cloudinary
  },
  computed: {
    ...mapGetters([
      'getActivity'
    ]),
    isAmbassador () {
      // NOTE: L'Agriculteur est un ambassadeur
      if (this.getActivity.farmer.user.ambassador === true) {
        return true
      } else {
        return false
      }
    },
    farmType () {
      var farmTypesIndex = this.getActivity.farm_type
      var farmTypes = []
      for (var prop in farmTypesIndex) {
        if (farmTypesIndex[prop] && prop !== 'id') {
          farmTypes.push(prop)
        }
      }
      return [...(farmTypes || [])]
        .filter(v => v.length > 1)
        .map((v) => {
          return this.$t(`activity.farmTypes.${v}`)
        })
        .join(' - ')
    },
    agricultureType () {
      var agricultureTypesIndex = this.getActivity.agriculture_type
      var agricultureTypes = []
      for (var prop in agricultureTypesIndex) {
        if (agricultureTypesIndex[prop] && prop !== 'id') {
          agricultureTypes.push(prop)
        }
      }
      return [...(agricultureTypes || [])]
        .filter(v => v.length > 1)
        .map((v) => {
          return this.$t(`activity.agricultureTypes.${v}`)
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
  top: 45vh;

  display: grid;
  grid-template-columns: 115px 85vh 55vh;
  grid-column-gap: 20px;

  color: white;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  @media only screen and (max-width: $breakpoint-tablet) {
    grid-template-columns: auto;
    top: 30vh;
  }
}

// AVATAR BOX

.offer-card-image {
  align-self: center;
  justify-self: center;
}

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
    font-size: 15px;
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
  font-size: 14px;
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
}
</style>
