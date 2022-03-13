<template>
  <div class="container">
    <div class="photo1">
      <div class="col">
        <div class="text">
          <h2>{{ $t("conceptTiny.sejour.title") }}</h2><br>
          <p>{{ $t("conceptTiny.sejour.content")[0] }}</p>
          <p>{{ $t("conceptTiny.sejour.content")[1] }}</p>
          <p>{{ $t("conceptTiny.sejour.content")[2] }}</p>
        </div>
      </div>
      <div class="image col1">
        <img
          :src="img1"
          class="photo"
          style="grid-area: grandephoto"
          alt=""
        >
        <img
          :src="img2"
          class="photo"
          style="grid-area:petitphoto2"
          alt=""
        >
      </div>
    </div>
    <div class="photo2">
      <div class="col">
        <img
          :src="img3"
          class="photo image3"
          style="grid-area: petitphoto1"
          alt=""
        >
      </div>
      <div class="col1">
        <div class="text">
          <h2>{{ $t("conceptTiny.sejour.title2") }}</h2><br>
          <p>{{ $t("conceptTiny.sejour.content2")[0] }}</p>
          <p>{{ $t("conceptTiny.sejour.content2")[1] }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import img1 from '@/assets/img/conceptTiny/photo1/ct1.png'
import img2 from '@/assets/img/conceptTiny/photo1/ct2.png'
import img3 from '@/assets/img/conceptTiny/photo1/ct3.png'
export default {
  name: 'SejourTiny',
  data () {
    return {
      img1,
      img2,
      img3
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
.container {
  padding: 0px 49px 0px 77px;
  @media only screen and (max-width: $breakpoint-tablet) {
    padding: 0px 10px 0px 10px;
  }
  .col {
    flex: 1;
  }
  .col1 {
    flex: 1;
  }
  h2 {
    font-size: 18px;
    color: $agri-green;
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
        Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  }
  p {
    font-size: 14px;
    color: $agri-green;
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
        Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  }
  .text {
    padding-right: 96px;
    @media only screen and (max-width: $breakpoint-tablet) {
        padding: 10px;
    }
  }
  .photo1 {
    display: flex;
    padding-top: 66px;
    .image {
      display: grid;
      grid-gap: 10px;
      grid-template-columns: repeat(3, 1fr);
      grid-template-areas:
          "grandephoto grandephoto petitphoto2";
      .photo {
        width: 100%;
        height: 100%;
      }
    }
    @media only screen and (max-width: $breakpoint-tablet) {
      display: flex;
      flex-direction: column;
    }
  }
  .photo2 {
    padding-bottom: 50px;
    display: flex;
    .text {
      padding-top: 40px;
      padding-right: 80px;
      @media only screen and (max-width: $breakpoint-tablet) {
        padding-right: 0px;
      }
    }
    .photo {
        width: 80%;
        height: 100%;
      @media only screen and (max-width: $breakpoint-tablet) {
        width: 100%;
        height: 100%;
      }
    }
    @media only screen and (max-width: $breakpoint-tablet) {
      display: flex;
      flex-direction: column-reverse;
    }
  }
}
</style>
