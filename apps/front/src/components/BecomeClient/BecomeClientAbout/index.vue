<template>
  <div class="become-host-about">
    <h2 class="title">
      {{ $t('becomeClient.titles.about') }}
    </h2>
    <div class="become-host-about__reasons">
      <div class="reason">
        <h3 class="subtitle">
          {{ $t('becomeClient.titles.discovery') }}
        </h3>
        <p class="body-1">
          {{ $t('becomeClient.paragraphes.agritourism') }}
        </p>
      </div>
      <div class="reason">
        <h3 class="subtitle">
          {{ $t('becomeClient.titles.platform') }}
        </h3>
        <p class="body-1">
          {{ $t('becomeClient.paragraphes.platform') }}
        </p>
      </div>
      <div class="reason">
        <h3 class="subtitle">
          {{ $t('becomeClient.titles.gain') }}
        </h3>
        <p class="body-1">
          {{ $t('becomeClient.paragraphes.contribution') }}
        </p>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'BecomeClientAbout'
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .become-host-about{
    padding: 64px 0;

    .title{
      text-align: center;
      margin-bottom: 32px;
    }

    &__reasons{
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      grid-gap: 16px;

      @media only screen and (max-width: $breakpoint-laptop-m) {
        grid-template-columns: 1fr;
      }
    }
  }
</style>
