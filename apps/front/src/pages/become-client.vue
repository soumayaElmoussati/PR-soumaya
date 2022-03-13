<template>
  <div class="become-host">
    <div class="become-host__hero">
      <div class="wrap">
        <div class="become-host__hero__title">
          <h1 class="title">
            {{ $t("becomeClient.titles.visitFarm") }}
          </h1>
          <h2 class="headline">
            {{ $t("becomeClient.titles.join") }}
          </h2>
        </div>
        <become-client-sign-in />
      </div>
    </div>
    <div class="become-host__content">
      <div class="wrap">
        <become-client-about />
      </div>
    </div>
  </div>
</template>

<script>
  import BecomeClientSignIn from '@/components/BecomeClient/BecomeClientSignIn'
  import BecomeClientAbout from '@/components/BecomeClient/BecomeClientAbout'

  export default {
    name: 'BecomeClient',
    components: {
      BecomeClientSignIn,
      BecomeClientAbout
    },
    head () {
      return {
        title: 'Devenez client - Création d\'un compte AgriVillage',
        meta: [
          { hid: 'description', name: 'description', content: 'Partez avec AgriVillage, découvrez une exploitation agricole et participez à une activité unique.' },
          { hid: 'og:description', name: 'og:description', content: 'Partez avec AgriVillage, découvrez une exploitation agricole et participez à une activité unique.' },
          { hid: 'twitter:description', name: 'twitter:description', content: 'Partez avec AgriVillage, découvrez une exploitation agricole et participez à une activité unique.' }
        ]
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .become-host{
    min-height: 100vh;
    padding-top: 32px;

    @media only screen and (max-width: $breakpoint-laptop-m) {
      padding-top: 0;
    }

    &__hero{
      height: 580px;

      @media only screen and (max-width: $breakpoint-laptop-m) {
        height: auto;
      }

      .wrap{
        position: relative;
        display: flex;
        justify-content: space-between;
        height: 100%;

        @media only screen and (max-width: $breakpoint-laptop-m) {
          flex-direction: column;
        }
      }

      &__title{
        display: flex;
        flex-direction: column;
        left: 0;
        top: 0;
        bottom: 0;
        margin: auto 0;
        background-color: white;
        border-radius: 0 200px 200px 0;
        padding: 32px 32px 32px 0;
        margin-right: 100px;

        @media only screen and (max-width: $breakpoint-laptop-m) {
          border-radius: 16px;
          padding: 32px;
          margin-top: 32px;
          margin-right: 0;
        }

        .headline strong{
          font-weight: 400;
        }
      }

      &::before{
        position: absolute;
        content: " ";
        right: 0;
        width: 70%;
        height: 580px;
        border-radius: 580px 0 0 580px;

        background-color: $primary;
        background-image: url('~assets/img/auth/hero-host.jpg');
        background-size: cover;
        background-position: center;

        @media only screen and (max-width: $breakpoint-laptop-m) {
          width: 100%;
          height: 100%;
          border-radius: 0;
        }
      }
    }

    h1{
      font-weight: 400;
    }

    .wrap{
      @media only screen and (max-width: $breakpoint-mobile-l) {
        padding: 0 16px;
      }
    }
  }
</style>
