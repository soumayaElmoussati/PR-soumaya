<template>
  <div class="offer-farmer-location">
    <client-only>
      <l-map
        :zoom="zoom"
        :center="position"
        style="height: 100%; width: 100%;z-index: 1;"
      >
        <l-marker :lat-lng="position" />
        <l-tile-layer :url="url" />
      </l-map>
    </client-only>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  /**
   * @module component - OfferFarmerLocation
   */
  export default {
    name: 'ActivityFarmerLocation',
    data () {
      return {
        zoom: 8,
        url: process.env.MAPBOX_URL
      }
    },
    computed: {
      ...mapGetters([
        'getActivity'
      ]),
      position () {
        return [
          this.getActivity.activity_address.lat,
          this.getActivity.activity_address.lng
        ]
      }
    }
  }
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

  .offer-farmer-location{
    height: 470px;
    width: 520px;
    display: flex;
    flex-direction: column;
    align-items: center;
    align-self: center;
    justify-self: center;
    @media only screen and (max-width: $breakpoint-mobile-l) {
      width: 100%;
      padding: 20px;
    }
  }
</style>
