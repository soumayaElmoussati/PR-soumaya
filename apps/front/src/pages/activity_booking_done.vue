<template>
  <div class="offer-booking-done">
    <div class="wrap">
      <div class="content">
        <h1 class="title">
          {{ $t('activity.titles.congratz') }}
        </h1>
        <p class="body-1">
          {{ $t('activity.titles.congratz_success') }}
        </p>
        <p class="body-1">
          {{ $t('activity.paragraphs.bookinWait') }}
        </p>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'ActivityBookingDone'
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .offer-booking-done{
    min-height: 100vh;

    .content{
      text-align: center;
      width: 50%;
      margin: auto;
      padding-top: 32px;

      @media only screen and (max-width: $breakpoint-tablet) {
        width: 100%;
      }

      @media only screen and (max-width: $breakpoint-mobile-l) {
        padding: 32px 16px 0 16px;
      }
    }

    h1{
      font-size: 32px;
      font-weight: 400;
      color: $primary;
    }

    b{
      color: $primary;
      font-weight: 500;
    }
  }
</style>
