<template>
  <div class="container">
    <div class="wrap">
      <div class="text">
        <div class="title">
          <h2>{{ $t("conceptTiny.sejour.title3") }}</h2>
        </div>
        <div class="description">
          <p>{{ $t("conceptTiny.sejour.content3")[0] }}</p>
          <p>{{ $t("conceptTiny.sejour.content3")[1] }}</p>
          <p>{{ $t("conceptTiny.sejour.content3")[2] }}</p>
          <p>{{ $t("conceptTiny.sejour.content3")[3] }}</p>
        </div>
        <div class="btn">
          <a
            href="/tiny-house"
            target="_blanc">
          <button>{{ $t("conceptTiny.buttons.guide") }}</button></a>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'VacancesTiny'
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
.container {
  min-height: 88vh;
  background-color: $tiny-back-brown;
  background-image: url("~assets/img/conceptTiny/ct.png");
  background-size: cover;
  position:relative;
    @media only screen and (max-width: $breakpoint-tablet) {
      min-height: 98vh;
    }
  h2 {
    font-size: 16px;
    color: $agri-green;
    font-family: roboto, "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
        Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  }
  p {
    font-size: 12px;
    color: $agri-green;
    font-family: roboto, "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
        Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  }
  .text {
    position: absolute;
    background: rgba(255, 255, 255, 0.7);
    float: left;
    max-width: 35%;
    margin: 49px 0px 40px 66px;
    border-radius: 80px;
    .title {
      margin-top: 60px;
      margin-left: 39px;
    }
    .description {
      margin: 45px 22px 48px 39px;
    }
    @media only screen and (max-width: $breakpoint-laptop-generic) {
      max-width: 50%;
    }
    @media only screen and (max-width: $breakpoint-laptop-m) {
      max-width: 60%;
    }
    @media only screen and (max-width: $breakpoint-tablet) {
      max-width: 100%;
      margin: 0px;
      border-radius: 0px;
      min-height: 98vh;
    }
    .btn {
      display: flex;
      justify-content: center;
      margin-bottom: 40px;
      text-align: center;
      button {
        margin: 0 auto;
        width: auto;
        background-color: $tiny-beige;
        border: 1px solid $agri-green;
        cursor: pointer;
        color: $agri-green;
        font-weight: 900;
        font-size: 18px;
        padding: 10px;
        border-radius: 99.5px;
        margin-bottom: 15px;
        line-height: 23px;
        box-shadow: 0px 3px 5px 2px;
        font-family: roboto, "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
        Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
      }
    }
  }
}
</style>
