<template>
  <div class="content">
    <h3>{{ $t("vacancesEnFamille.sejourner.title") }}</h3>
    <hr>
    <div class="card1">
      <div class="img-content">
        <img
          :src="img1"
          class= "image1"
          style="grid-area: photo1"
          alt="" >
      </div>
      <div
        class="content-card"
        style="grid-area: text1">
        <div class="title">
          <h2>{{ $t("vacancesEnFamille.sejourner.card1.title") }}</h2>
        </div>
        <hr>
        <div class="line" />
        <div class="text">
          <p>{{ $t("vacancesEnFamille.sejourner.card1.content1") }}</p>
          <p>{{ $t("vacancesEnFamille.sejourner.card1.content2") }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import img1 from '@/assets/img/VacancesEnFamille/card1.png'
  export default {
    name: 'Sejour',
    data () {
      return {
        img1
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
  hr {
    margin: auto;
    margin-bottom: 4%;
    width: 10%;
    border-bottom: $agri-green 4px solid;
  }
  .card1 {
    margin: auto;
    width: 80%;
    display: flex;
    justify-content: space-around;
    @media only screen and (max-width: $breakpoint-phone) {
      width: 100%;
    }
    .img-content {
      margin-right: 4%;
      width: 100%;
      height: 100%;
    }
    .image1 {
      display: block;
      width: 80%;
      margin: 0 auto;
      border-radius: 5%;
      box-shadow: 1px 1px 9px 3px #152715;
      @media only screen and (max-width: $breakpoint-laptop-m) {
        width: 100%;
      }
    }
    .content-card {
      width: 100%;
      height: auto;
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
