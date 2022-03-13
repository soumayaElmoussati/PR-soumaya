<template>
  <div class="offer-farmer">
    <offer-farmer-details />
    <div>
      <offer-farmer-location />
    </div>
  </div>
</template>

<script>
  import OfferFarmerLocation from './_subs/OfferFarmerLocation'
  import OfferFarmerDetails from './_subs/OfferFarmerDetails'

  /**
   * @module component - OfferFarmer
   */
  export default {
    name: 'OfferFarmer',
    components: {
      OfferFarmerLocation,
      OfferFarmerDetails
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";
  .offer-farmer{
    display: grid;
    grid-template-columns: 55% 45%;
    @media only screen and (max-width: $breakpoint-tablet) {
      grid-template-columns: 100%;
      padding-right: 5vw;
      padding-left: 5vw;
      padding-top: 10px;
      padding-bottom: 4%;
    }

    background-color: #F6F5F5;

    padding-right: 2vw;
    padding-left: 5vw;
    padding-top: 70px;
    padding-bottom: 70px;
  }
</style>
