<template>
  <div class="offer-content">
    <h2>
      {{ mytitle }}
    </h2>
    <slot />
  </div>
</template>

<script>
 /**
  * @module component - OfferContent
  */
  export default {
    name: 'ActivityContent',
    props: {
      mytitle: {
        type: String,
        required: true
      }
    }
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
