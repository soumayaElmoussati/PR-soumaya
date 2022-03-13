<template>
  <div class="home-hero">
    <div class="home-hero__image h_small">
      <div class="wrap">
        <h1
          class="title title-all"
          style="display: inline">
          {{ $t("tinyhouse.titles.stay") }}
        </h1>
      </div>
      <nuxt-link
        :to="{
          name: 'OffersTinyHouse'
        }"
        class="tiny-button">
        {{ $t("tinyhouse.buttons")[2] }}
      </nuxt-link>
    </div>
  </div>
</template>

<script>
import 'jquery'
export default {
  name: 'HomeHeroOfferAll',
  components: {},
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
a {
  text-decoration: none;
}
.tiny-button {
  align-self: flex-end;
  margin-right: 30px;
  margin-bottom: 51px;
  width: auto;
  color: $agri-green;
  font-size: 18px;
  font-weight: 900;
  background-color: $tiny-beige;
  border: none;
  border-radius: 99.5px;
  padding: 12px 26px;
  text-align: center;
  cursor: pointer;
  @media only screen and (max-width: $breakpoint-tablet) {
    width: auto;
    font-size: 24px;
    margin: 0 auto 20px auto;
  }
  p {
    padding: 0;
    margin: 0;
  }
}
.title-all {
  font-size: 3.5vw;
  font-weight: 700;
  color: $tiny-beige;
  text-shadow: 0 0 7px rgba(0, 0, 0, 0.25);
  @media only screen and (max-width: $breakpoint-tablet) {
    font-size: 27px;
  }
}

.home-hero__image {
  display: flex;
  flex-direction: column;
}

.home-hero {
  min-height: 550px;
  width: 100%;
  background-color: $agri-grey;
  background-image: url("~assets/img/homeTiny/HeroTiny.jpg");
  background-size: cover;
  background-position: center;
  box-shadow: inset 0px -100px 140px 0px #0000008c;
  @media only screen and (max-width: $breakpoint-mobile-l) {
    padding: 0 16px;
  }
 .wrap {
    margin-top: 25%;
    margin-bottom: 4%;
    width: 80%;
    @media only screen and (max-width: $breakpoint-tablet) {
      margin-top: 97px;
    }
  }
}
</style>
