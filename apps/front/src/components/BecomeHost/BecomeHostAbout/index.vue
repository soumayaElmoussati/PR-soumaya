<template>
  <div class="become-host-about">
    <h2 class="title">
      {{ $t('becomeHost.titles.about') }}
    </h2>
    <div class="become-host-about__reasons">
      <div class="reason">
        <h3 class="subtitle">
          {{ $t('becomeHost.titles.discovery') }}
        </h3>
        <p class="body-1">
          {{ $t('becomeHost.paragraphs.agritourism') }} <br>
          {{ $t('becomeHost.paragraphs.discovery') }}
        </p>
      </div>
      <div class="reason">
        <h3 class="subtitle">
          {{ $t('becomeHost.titles.platform') }}
        </h3>
        <p class="body-1">
          {{ $t('becomeHost.paragraphs.platform') }} <br>
          {{ $t('becomeHost.paragraphs.strengthen') }} <br>
          {{ $t('becomeHost.paragraphs.support') }}
        </p>
      </div>
      <div class="reason">
        <h3 class="subtitle">
          {{ $t('becomeHost.buttons.gain') }}
        </h3>
        <p class="body-1">
          {{ $t('becomeHost.paragraphs.contribution') }}
        </p>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'BecomeHostAbout'
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
