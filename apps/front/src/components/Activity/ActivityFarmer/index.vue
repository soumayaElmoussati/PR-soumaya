<template>
  <div class="offer-farmer">
    <activity-farmer-details />
    <activity-farmer-location />
  </div>
</template>

<script>
  import ActivityFarmerLocation from './_subs/ActivityFarmerLocation'
  import ActivityFarmerDetails from './_subs/ActivityFarmerDetails'

  /**
   * @module component - OfferFarmer
   */
  export default {
    name: 'ActivityFarmer',
    components: {
      ActivityFarmerLocation,
      ActivityFarmerDetails
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";
  .offer-farmer{
    display: grid;
    grid-template-columns: auto auto;
    @media only screen and (max-width: $breakpoint-mobile-l) {
      grid-template-columns: auto;
      padding-right: 0vw;
      padding-left: 0vw;
    }

    background-color: #F6F5F5;

    padding-right: 10vw;
    padding-left: 10vw;
    padding-top: 70px;
    padding-bottom: 70px;
  }
</style>
