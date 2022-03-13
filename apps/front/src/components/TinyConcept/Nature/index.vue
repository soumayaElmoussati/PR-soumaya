<template>
  <div class="container">
    <div class="table rang1">
      <div>
        <div class="textg">
          <div class="title">
            <h2>{{ $t("conceptTiny.nature.title1") }}</h2>
            <img
              :src="img4"
              alt="" >
          </div>
          <p>{{ $t("conceptTiny.nature.content1")[0] }}</p>
          <p>{{ $t("conceptTiny.nature.content1")[1] }}</p>
          <p>{{ $t("conceptTiny.nature.content1")[2] }}</p>
        </div>
      </div>
      <div>
        <img
          :src="img1"
          class="image"
          alt="" >
      </div>
    </div>
    <div class="table rang2">
      <div>
        <img
          :src="img2"
          class="image"
          alt="" >
      </div>
      <div>
        <div class="text">
          <div class="title">
            <h2>{{ $t("conceptTiny.nature.title2") }}</h2>
            <img
              :src="img5"
              alt="" >
          </div>
          <p>{{ $t("conceptTiny.nature.content2")[0] }}</p>
          <p>{{ $t("conceptTiny.nature.content2")[1] }}</p>
          <p>{{ $t("conceptTiny.nature.content2")[2] }}</p>
        </div>
      </div>
    </div>
    <div class="table rang3">
      <div>
        <div class="textg">
          <div class="title">
            <h2>{{ $t("conceptTiny.nature.title3") }}</h2>
            <img
              :src="img6"
              alt="" >
          </div>
          <p>{{ $t("conceptTiny.nature.content3")[0] }}</p>
          <p>{{ $t("conceptTiny.nature.content3")[1] }}</p>
        </div>
      </div>
      <div>
        <img
          :src="img3"
          class="image"
          alt="" >
      </div>
    </div>
  </div>
</template>

<script>
import img1 from '@/assets/img/conceptTiny/photo2/nat1.png'
import img2 from '@/assets/img/conceptTiny/photo2/nat2.png'
import img3 from '@/assets/img/conceptTiny/photo2/nat3.png'
import img4 from '@/assets/img/conceptTiny/photo2/tract.png'
import img5 from '@/assets/img/conceptTiny/photo2/cow.png'
import img6 from '@/assets/img/conceptTiny/photo2/ferm.png'
export default {
  name: 'Nature',
  data () {
    return {
      img1,
      img2,
      img3,
      img4,
      img5,
      img6
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
.container {
  margin: 0px 100px 0px 100px;
  @media only screen and (max-width: $breakpoint-tablet) {
      margin: 0px 10px 0px 10px;
  }
  .table {
    display: flex;
    margin-top: 58px;
    .textg {
      margin-right: 175px;
      @media only screen and (max-width: $breakpoint-tablet) {
        margin-right: 10px;
      }
    }
    .text {
      margin-left: 90px;
      @media only screen and (max-width: $breakpoint-tablet) {
        margin-left: 10px;
      }
    }
    .image {
      @media only screen and (max-width: $breakpoint-tablet) {
        width: 100%;
        height: 100%;
      }
      @media only screen and (max-width: $breakpoint-laptop-generic) {
        width: 100%;
        height: 100%;
      }
    }
  }
  .title{
    display: flex;
    align-items: flex-end;
  }
  h2 {
    font-size: 16px;
    font-family: roboto, "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    color: $agri-green;
    margin-right: 30px;
  }
  p {
    font-size: 14px;
    font-family: roboto, "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    color: $agri-green;
  }
  .rang1 {
    @media only screen and (max-width: $breakpoint-tablet) {
      display: flex;
      flex-direction: column;
    }
  }
  .rang2 {
    @media only screen and (max-width: $breakpoint-tablet) {
      display: flex;
      flex-direction: column-reverse;
    }
  }
  .rang3 {
    margin-bottom: 50px;
    @media only screen and (max-width: $breakpoint-tablet) {
      display: flex;
      flex-direction: column;
    }
  }
}
</style>
