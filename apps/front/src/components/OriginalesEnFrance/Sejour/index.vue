<template>
  <div class="content">
    <h3>{{ $t("originalesEnFrance.sejourner.title") }}</h3>
    <div class="card1">
      <div class="img-content">
        <img
          :src="img1"
          class= "image1"
          alt="" >
      </div>
      <div
        class="content-card">
        <div class="title">
          <h2>{{ $t("originalesEnFrance.sejourner.card1.title") }}</h2>
        </div>
        <hr>
        <div class="text">
          <p>{{ $t("originalesEnFrance.sejourner.card1.content1") }}</p>
          <p>{{ $t("originalesEnFrance.sejourner.card1.content2") }}</p>
        </div>
      </div>
    </div>

    <hr class="separator">

    <div class="card2">
      <div class="img-content">
        <img
          :src="img2"
          class= "image1"
          alt="" >
      </div>
      <div
        class="content-card">
        <div class="title">
          <h2>{{ $t("originalesEnFrance.sejourner.card2.title") }}</h2>
        </div>
        <hr>
        <div class="text">
          <p>{{ $t("originalesEnFrance.sejourner.card2.content1")[0] }}</p>
          <p>{{ $t("originalesEnFrance.sejourner.card2.content1")[1] }}</p>
          <p>{{ $t("originalesEnFrance.sejourner.card2.content1")[2] }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import img1 from '@/assets/img/originalesEnFrance/card1.png'
  import img2 from '@/assets/img/originalesEnFrance/card2.png'
  export default {
    name: 'Sejour',
    data () {
      return {
        img1,
        img2
      }
    }
  }
</script>
<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
.content {
  min-height: auto;
  margin-left: 50px;
  margin-right: 50px;
  h3 {
    color: black;
    text-align: center;
    font-size: 27px;
    font-weight: 500;
    margin-top: 4%;
    margin-bottom: 2%;
    display: block;
  }
  .separator {
    margin: auto;
    margin-bottom: 2%;
    margin-top: 2%;
    width: 58%;
    border-bottom: $agri-green 2px solid;
    @media only screen and (max-width: $breakpoint-tablet) {
      margin-top: 10%;
    }
  }
  .card1 {
    margin: auto;
    width: 80%;
    display: flex;
    justify-content: space-around;
    @media only screen and (max-width: $breakpoint-phone) {
      width: 100%;
    }
   /*  background-color: #FFF9E3; */
    .img-content {
      margin-right: 4%;
      width: 100%;
      height: 100%;
    }
    hr {
      margin: auto;
      /* margin-left: 0px; */
      width: 20%;
      border-bottom: $agri-green 4px solid;
    }
    .image1 {
      display: block;
      width: 80%;
      // margin: 0 auto;
      // border-radius: 5%;
      // box-shadow: 1px 1px 9px 3px #152715;
      @media only screen and (max-width: $breakpoint-laptop-m) {
        width: 100%;
      }
    }
    .content-card {
      width: 100%;
      height: auto;
      margin-right: 4%;
    }
    .title {
      width: max-content;
      font-size: 1.3vw;
      text-align: center;
      @media only screen and (max-width: $breakpoint-tablet) {
        font-size: 14px;
        width: auto;
      }
    }
    p {
      font-size: 14px;
      @media only screen and (max-width: $breakpoint-tablet) {
        font-size: 16px;
        text-align: justify;
      }
      @media only screen and (max-width: $breakpoint-phone) {
        font-size: 14px;
      }
    }
    @media only screen and (max-width: $breakpoint-tablet) {
      display: flex;
      flex-direction: column-reverse;
    }
  }
  .card2 {
    margin: auto;
    width: 80%;
    display: flex;
    justify-content: space-around;
    /* background-color: #FFF9E3; */
    flex-direction: row-reverse;
    @media only screen and (max-width: $breakpoint-phone) {
      width: 100%;
    }
    .img-content {
      width: 100%;
      height: 100%;
    }
    hr {
      margin: auto;
      /* margin-left: 0px; */
      width: 20%;
      border-bottom: $agri-green 4px solid;
    }
    .image1 {
      margin-left: auto;
      display: block;
      width: 80%;
      // margin: 0 auto;
      // border-radius: 5%;
      // box-shadow: 1px 1px 9px 3px #152715;
      @media only screen and (max-width: $breakpoint-laptop-m) {
        width: 100%;
      }
    }
    .content-card {
      width: 100%;
      height: auto;
      margin-left: 4%;
    }
    .title {
      width: max-content;
      font-size: 1.3vw;
      text-align: center;
      @media only screen and (max-width: $breakpoint-tablet) {
        font-size: 14px;
        width: auto;
      }
    }
    p {
      font-size: 14px;
      @media only screen and (max-width: $breakpoint-tablet) {
        font-size: 16px;
        text-align: justify;
      }
      @media only screen and (max-width: $breakpoint-phone) {
        font-size: 14px;
      }
    }
    @media only screen and (max-width: $breakpoint-tablet) {
      display: flex;
      flex-direction: column-reverse;
    }
  }
}
</style>
