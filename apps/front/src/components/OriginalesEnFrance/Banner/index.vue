<template>
  <div class="bannerContent">
    <div class="title">
      <h3>{{ $t("originalesEnFrance.banner2.title") }}</h3>
    </div>
    <div class="evasion">
      <h4>{{ $t("originalesEnFrance.banner2.subTitle") }}</h4>
      <button class="btn btn-agri">
        <nuxt-link
          :to="{ name: 'OffersAll' }">
          {{ $t("originalesEnFrance.banner2.button") }}
        </nuxt-link>
      </button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Banner'
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
h2,
h3,
h4,
p {
  margin: 0;
  padding: 0;
}

* {
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.bannerContent {
  background-image: linear-gradient(rgba(0, 0, 0, 0.4), rgba(0, 0, 0, 0.4)),
    url("../../../assets/img/originalesEnFrance/banner.png");
  height: auto;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  margin-bottom: 5%;
  background-size: cover;
  height: 34vw;
  @media only screen and (max-width: $breakpoint-tablet) {
    height: auto;
  }
  .title {
    width: 75%;
    @media only screen and (max-width: $breakpoint-tablet) {
        width: 90%;
      }
    h3 {
      font-size: 33px;
      margin: auto;
      width: 66%;
      margin-top: 4%;
      margin-bottom: 4%;
      color: white;
      text-align: center;
      font-weight: 400;
      text-shadow: 0px 8px 4px rgba(0, 0, 0, 0.5);
      @media only screen and (max-width: $breakpoint-mobile-m) {
        font-size: 28px;
        width: 100%;
      }
      @media only screen and (max-width: $breakpoint-mobile-m) {
        font-size: 27px;
        width: 100%;
      }
    }
  }
  .evasion {
    background-color: rgba(255, 249, 230, 0.34);
    height: 230px;
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    h4 {
      color: #fff9e3;
      font-size: 44px;
      font-weight: 500;
      @media only screen and (max-width: $breakpoint-tablet) {
        font-size: 28px;
        text-align: center;
        margin-bottom: 3%;
      }
      @media only screen and (max-width: $breakpoint-mobile-m) {
        font-size: 23px;
      }
    }
    button {
      position: relative;
      text-transform: initial;
      // padding: 10px;
      // // border-radius: 10px;
      // // box-shadow: 0px 2px 3px 0px #000;
      // // color: #fff9e3;
      // // background-color: $agri-green;
      // // font-size: 25px;
      // font-weight: 500;
      // margin-top: 1%;
      @media only screen and (max-width: $breakpoint-mobile-m) {
        margin-top: 5%;
        padding: 3%;
        line-height: normal;
      }
      a {
        font-size: 16px;
        text-decoration: none;
        color: white;
      }
    }
  }
}
</style>
