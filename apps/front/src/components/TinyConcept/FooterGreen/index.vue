<template>
  <div class="container">
    <div class="content">
      <div class="logos">
        <div class="logo3 taille">
          <img
            :src="logo1"
            alt="">
          <h2>{{ $t("conceptTiny.fields.place") }}</h2>
          <div class="text1">
            <p>{{ $t("conceptTiny.paragraphs.place") }}</p>
          </div>
        </div>
        <div class="logo2 taille">
          <img
            :src="logo2"
            alt="" >
          <h2>{{ $t("conceptTiny.fields.home") }}</h2>
          <div class="text2">
            <p>{{ $t("conceptTiny.paragraphs.home") }}</p>
          </div>
        </div>
        <div class="logo1 taille">
          <img
            :src="logo3"
            alt="" >
          <h2>{{ $t("conceptTiny.fields.security") }}</h2>
          <div class="text3">
            <p>{{ $t("conceptTiny.paragraphs.security") }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import logo1 from '@/assets/img/conceptTiny/lieu.png'
import logo2 from '@/assets/img/conceptTiny/maison.png'
import logo3 from '@/assets/img/conceptTiny/security.png'
export default {
  data () {
    return {
      logo1,
      logo2,
      logo3
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
.container {
  // min-height: 71vh
  // filter: blur(4px);
  background-image: url("~assets/img/conceptTiny/fond ble.png");
  background-size: cover;
  .content {
    width: 100%;
    background: rgba(71, 100, 88, 0.9);
  }
  .logos {
    display: flex;
    justify-content: space-around;
    text-align: center;
    padding: 0px 138px 65px 138px;
    @media only screen and (max-width: $breakpoint-tablet) {
      display: flex;
      flex-direction: column;
      padding: 0px 10px 65px 10px;
    }
  }
  .taille {
    padding-left: 20px;
    padding-right: 20px;
    @media only screen and (max-width: $breakpoint-tablet) {
      padding-left: 0px;
      padding-right: 0px;
    }
  }
  .logo1 {
    padding-top: 92px;
    width: 100%;
    .text1 {
      padding-left: 35px;
      padding-right: 35px;
      @media only screen and (max-width: $breakpoint-tablet) {
        padding-left: 10px;
        padding-right: 10px;
      }
    }
  }
  .logo2 {
    width: 100%;
    padding-top: 75px;
    .text2 {
      padding-left: 30px;
      padding-right: 30px;
      @media only screen and (max-width: $breakpoint-tablet) {
        padding-left: 10px;
        padding-right: 10px;
      }
    }
  }
  .logo3 {
    width: 100%;
    padding-top: 92px;
    .text3 {
      padding-left: 10px;
      padding-right: 10px;
      @media only screen and (max-width: $breakpoint-tablet) {
        padding-left: 10px;
        padding-right: 10px;
      }
    }
  }
  h2 {
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    font-size: 18px;
    color: white;
  }
  p {
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    font-size: 12px;
    color: #FFF9E6;
  }
}
</style>
