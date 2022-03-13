<template>
  <div class="container">
    <div class="content">
      <h2>{{ $t("materiauxTiny.elipse.title") }}</h2>
      <p>{{ $t("materiauxTiny.elipse.content") }}</p>
      <div class="logos">
        <div class="logo1">
          <p class="title">
            {{ $t("materiauxTiny.elipse.text")[0] }}
          </p>
          <p>
            {{ $t("materiauxTiny.elipse.text")[1] }}
          </p>
          <p>
            {{ $t("materiauxTiny.elipse.text")[2] }}
          </p>
        </div>
        <div class="logo3">
          <img
            :src="Ellipse"
            alt="" >
          <p>
            {{ $t("materiauxTiny.type.wood")[0] }}<br><br>
            {{ $t("materiauxTiny.type.wood")[1] }}<br><br>
            {{ $t("materiauxTiny.type.wood")[2] }}<br><br>
            {{ $t("materiauxTiny.type.wood")[3] }}<br>
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Ellipse from '@/assets/img/materiauxTiny/Ellipse 10.png'
export default {
  name: 'GreenFooter',
  data () {
    return {
      Ellipse
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
.container {
  min-height: 670px;
  background-image: linear-gradient(
      to bottom,
      rgba(210, 210, 159, 0.85),
      rgba(197, 197, 188, 0.85)
    ),
    url(~assets/img/materiauxTiny/vache.png);
  background-repeat: no-repeat;
  background-size: cover;
  @media only screen and (max-width: $breakpoint-tablet) {
    min-height: 876px;
  }
  .content {
    padding: 41px 100px 33px 41px;
    @media only screen and (max-width: $breakpoint-tablet) {
    padding: 0;
  }
  }
  h2 {
    color: $agri-green;
    font-size: 24px;
    font-weight: 400;
    font-style: italic;
    margin: 0 0 0 25px !important;
    padding-top: 25px;
    font-weight: bolder;
  }
  p {
    color: $agri-green;
    font-size: 20px;
    font-weight: 400;
    font-style: italic;
    margin: 20px 0 0 25px;
    @media only screen and (max-width: $breakpoint-tablet) {
      padding-bottom: 10px;
      padding-right: 10px;
    }
  }
  .logos {
    // padding-top: 80px;
    display: flex;
    @media only screen and (max-width: $breakpoint-tablet) {
      display: flex;
      flex-direction: column;
    }
    .logo1 {
      padding-top: 50px;
      p {
        text-align: start;
        margin-left: 28px;
        width: auto;
        font-size: 20px;
        padding-bottom: 30px;
        padding-right: 220px;
        @media only screen and (max-width: $breakpoint-tablet-l) {
          padding-bottom: 10px;
          padding-right: 10px;
        }
      }
      .title{
        font-weight: bolder;
      }
    }
    .logo3 {
      text-align: center;
      padding-right: 100px;
      @media only screen and (max-width: $breakpoint-tablet-l) {
        padding-right: 10px;
      }
      @media only screen and (max-width: $breakpoint-tablet) {
        padding-right: 0px!important;
      }
    p {
      width: 74%;
    }
    }
    .logo1
    .logo3 {
      display: flex;
      flex-direction: column;
      @media only screen and (max-width: $breakpoint-tablet) {
        margin-bottom: 28px;
      }
      img {
        width: 200px;
        height: 200px;
        margin: 0 auto;
      }
    }
    h3 {
      font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
        Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
      margin: 12px auto 0 auto;
      color: $agri-green;
    }
    p {
      font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
        Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
      width: 50%;
      color: $agri-green;
      margin: 0 auto;
      text-align: center;
      margin: 12px auto 0 auto;
      font-size: 2vw !important;
      font-style: italic;
      font-weight: 500;
      @media only screen and (max-width: $breakpoint-tablet) {
        font-size: 14px;
        font-weight: 500;
        width: 100%;
      }
    }
  }
}
</style>
