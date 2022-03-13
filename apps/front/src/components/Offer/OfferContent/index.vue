<template>
  <div class="offer-content">
    <slot />
  </div>
</template>

<script>
 /**
  * @module component - OfferContent
  */
  export default {
    name: 'OfferContent'
  }
</script>

<style lang="scss" scoped>
   @import "@/assets/scss/_variables.scss";

  .offer-content{
    h2{
      font-size: 20px;
      font-weight: 400;
      color: $primary-text;
    }
  }
</style>
