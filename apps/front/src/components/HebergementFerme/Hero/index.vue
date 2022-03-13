<template>
  <div>
    <div class="home-hero">
      <div class="home-hero__image h_small">
        <div class="wrap">
          <h1
            class="title title-all"
            style="display: inline">
            {{ $t("hebergementFerme.hero.titleHero") }}
          </h1>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'HoteHero',
  data () {
    return {
      mobile: false,
      disabledDates: {
        to: new Date()
      }
    }
  },
  computed: {},
  methods: {}
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
* {
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.home-hero {
  background-image: linear-gradient(rgba(40, 58, 38, 0.5), rgba(46, 60, 45, 0.3)), url("~assets/img/hebergementFerme/hero.png");
  background-size: cover;
  background-position: center;
  min-height: 85vh;
  width: 100%;
  @media only screen and (max-width: $breakpoint-phone) {
    min-height: 37vh;
  }
  .wrap {
  display: flex;
  height: 100%;
    h1 {
      font-size: 5vw;
      text-align: center;
      color: white;
      margin: auto;
      width: 87%;
      margin-top: 10%!important;
      font-weight: 500;
      text-shadow: 0 0 7px rgba(0, 0, 0, 0.25);
      @media only screen and (max-width: $breakpoint-phone) {
        font-size: 30px;
        margin-top: 15%;
      }
    }
  }
}
</style>
