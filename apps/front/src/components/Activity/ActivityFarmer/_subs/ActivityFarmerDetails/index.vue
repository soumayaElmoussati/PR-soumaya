<template>
  <div class="offer-farmer-details">

    <div class="farmer-infos">

      <nuxt-link
        :to="{
          name: 'FarmerProfile',
          params: {
            id: getActivity.farmer.id,
            slug: `hote-${getActivity.farmer.user.first_name}`
          }
        }"

      >
        <div class="farmer-image">
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

        <p class="farmer-name">{{ getActivity.farmer.user.first_name }}</p>
        <p
          v-if="getActivity.farmer.description"
          class="farmer-text"
        >
          {{ getActivity.farmer.description }}
        </p>
        <p
          v-else-if="getActivity.description.farmer"
          class="farmer-text"
        >
          {{ getActivity.description.farmer }}
        </p>

      </div>

    </div>

    <activity-rules v-if="getActivity.settlement" />

  </div>
</template>

<script>
  import { mapGetters } from 'vuex'
  import Cloudinary from '@/components/Cloudinary'
  import ActivityRules from '@/components/Activity/ActivityRules'

  /**
   * @module component - OfferFarmerDetails
   */
  export default {
    name: 'ActivityFarmerDetails',
    components: {
      Cloudinary,
      ActivityRules
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
      }
    }
  }
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

  .farmer-infos {
    display: grid;
    grid-template-columns: 100px 330px;
    grid-gap: 20px;
    @media only screen and (max-width: $breakpoint-mobile-l) {
      grid-template-columns: auto auto;
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

</style>
