<template>
  <div class="offer-farmer-location">
    <client-only>
      <l-map
        :zoom="zoom"
        :center="position"
        style="height: 100%; width: 100%;z-index: 1;"
      >
        <l-marker :lat-lng="position">
          <l-popup class="marker-card">
            <nuxt-link
              :to="{
                name: 'FarmerProfile',
                params: {
                  id: getOffer.farmer.id,
                  slug: `hote-${getOffer.farmer.user.first_name}`
                }
              }"
              target="_blank"
              class="marker-text"
            >
              <div v-if="getOffer.pictures.length">
                <img
                  v-for="picture in getOffer.pictures.slice(0, 1)"
                  :key="picture.public_id"
                  :src="address + picture.public_id"
                  :alt="getOffer.name"
                  style="width: 100%"
                >
              </div>
              {{ getOffer.name }}<br >
              <p class="marker-location">À {{ getOffer.address.city }}</p>
            </nuxt-link>
          </l-popup>
        </l-marker>
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
    name: 'OfferFarmerLocation',
    data () {
      return {
        zoom: 8,
        url: process.env.MAPBOX_URL,
        address:
          'https://res.cloudinary.com/agrivillage/image/upload/w_430,h_270,c_fill,f_jpg,fl_progressive/'
      }
    },
    computed: {
      ...mapGetters([
        'getOffer'
      ]),
      position () {
        return [
          this.getOffer.address.lat,
          this.getOffer.address.lng
        ]
      }
    }
  }
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

  .marker-text {
    color: black;
    text-align: center;
    text-decoration: none;
    font-size: 12px;
    font-weight: 800;
    text-transform: uppercase;
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  }

  .marker-location {
    font-size: 10px;
    margin: auto;
  }

  .offer-farmer-location{
    height: 470px;
    // width: 520px;
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    align-self: center;
    justify-self: center;
    @media only screen and (max-width: $breakpoint-mobile-large) {
      width: 100%;
      padding: 20px;
    }
  }
</style>
