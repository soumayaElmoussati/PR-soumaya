<template>
  <div class="container">
    <div class="content">
      <div class="deco3">
        <img
          :src="deco3"
          alt="">
      </div>
      <div class="card1">
        <div class="img1">
          <img
            :src="img1"
            alt="">
        </div>
        <div class="text1">
          <h3> {{ $t("companySeminar.Services.title")[0] }} </h3>
          <div class="text-card1">
            <p> {{ $t('companySeminar.Services.paragraphs')[0] }} </p>
            <ul>
              <li> {{ $t('companySeminar.Services.paragraphs')[1] }} </li>
              <li> {{ $t('companySeminar.Services.lists')[0] }} </li>
              <li> {{ $t('companySeminar.Services.lists')[1] }} </li>
              <li> {{ $t('companySeminar.Services.lists')[2] }} </li>
            </ul>
          </div>
        </div>
        <div class="img2">
          <img
            :src="img2"
            alt="">
        </div>
      </div>

      <div class="card2">
        <div class="deco4">
          <img
            :src="deco4"
            alt="">
        </div>
        <div class="img3">
          <img
            :src="img3"
            alt="">
        </div>
        <div class="text2">
          <h3> {{ $t("companySeminar.Services.title")[1] }} </h3>
          <div class="text-card2">
            <p> {{ $t('companySeminar.Services.paragraphs')[2] }} </p>
            <ul>
              <li> {{ $t('companySeminar.Services.lists')[3] }} </li>
              <li> {{ $t('companySeminar.Services.lists')[4] }} </li>
              <li> {{ $t('companySeminar.Services.lists')[5] }} </li>
              <li> {{ $t('companySeminar.Services.lists')[6] }} </li>
            </ul>
            <p> {{ $t('companySeminar.Services.paragraphs')[3] }} </p>
          </div>
        </div>
      </div>

      <div class="card3">
        <div class="img4">
          <img
            :src="img4"
            alt="">
        </div>
        <div class="text3">
          <h3> {{ $t("companySeminar.Services.title")[2] }} </h3>
          <div class="text-card3">
            <p> {{ $t('companySeminar.Services.paragraphs')[4] }} </p>
            <ul>
              <li> {{ $t('companySeminar.Services.lists')[7] }} </li>
              <li> {{ $t('companySeminar.Services.lists')[8] }} </li>
              <li> {{ $t('companySeminar.Services.lists')[9] }} </li>
              <li> {{ $t('companySeminar.Services.paragraphs')[6] }} </li>
            </ul>
          </div>
        </div>
        <div class="img5">
          <img
            :src="img5"
            alt="">
        </div>
      </div>

      <div class="card4">
        <div class="img6">
          <img
            :src="img6"
            alt="">
        </div>
        <div class="img7">
          <img
            :src="img7"
            alt="">
        </div>
        <div class="text4">
          <h3> {{ $t("companySeminar.Services.title")[3] }} </h3>
          <div class="text-card4">
            <p> {{ $t('companySeminar.Services.paragraphs')[7] }} </p>
            <ul>
              <li> {{ $t('companySeminar.Services.lists')[10] }} </li>
              <li> {{ $t('companySeminar.Services.lists')[11] }} </li>
            </ul>
            <p> {{ $t('companySeminar.Services.paragraphs')[8] }} </p>
            <ul style="padding-bottom: 2vw;">
              <li> {{ $t('companySeminar.Services.lists')[12] }} </li>
              <li> {{ $t('companySeminar.Services.lists')[13] }} </li>
              <li> {{ $t('companySeminar.Services.lists')[14] }} </li>
            </ul>
          </div>
        </div>
      </div>
      <div class="deco">
        <img
          :src="deco5"
          alt="">
      </div>
    </div>
  </div>
</template>
<script>
import img1 from '@/assets/img/companySeminar/pictures/hosting1.png'
import img2 from '@/assets/img/companySeminar/pictures/hosting2.png'
import img3 from '@/assets/img/companySeminar/pictures/workSpace.png'
import img4 from '@/assets/img/companySeminar/pictures/activity1.png'
import img5 from '@/assets/img/companySeminar/pictures/activity2.png'
import img6 from '@/assets/img/companySeminar/pictures/cooking1.png'
import img7 from '@/assets/img/companySeminar/pictures/cooking2.png'
import deco3 from '@/assets/img/companySeminar/deco/deco3.png'
import deco4 from '@/assets/img/companySeminar/deco/deco4.png'
import deco5 from '@/assets/img/companySeminar/deco/deco5.png'

export default {
  name: 'Services',
  data () {
    return {
      img1,
      img2,
      img3,
      img4,
      img5,
      img6,
      img7,
      deco3,
      deco4,
      deco5
    }
  }
}
</script>
<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
* {
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
}
.container {
  min-height: 130vw;
  -webkit-min-height: 130vw;
  @media only screen and (max-width: $breakpoint-tablet) {
    min-height: 180vw;
    -webkit-min-height: 180vw;
  }
  @media only screen and (max-width: $breakpoint-mobile-large) {
    min-height: 560vw;
    -webkit-min-height: 560vw;
  }
  @media only screen and (max-width: $breakpoint-mobile-m) {
    min-height: 570vw;
    -webkit-min-height: 570vw;
  }
  @media only screen and (max-width: $breakpoint-mobile-s) {
    min-height: 600vw;
    -webkit-min-height: 600vw;
  }
}
.deco3 {
  position: absolute;
  right: 0px;
  -webkit-position: absolute;
  -webkit-right: 0px;
  img {
    width: 10.8vw;
    -webkit-width: 10.8vw;
  }
}
.deco4 {
  position: absolute;
  left: 0px;
  -webkit-position: absolute;
  -webkit-left: 0px;
  img {
    width: 10.8vw;
    -webkit-width: 10.8vw;
  }
}
.card1 {
  display: flex;
  margin-bottom: 10%;
  -webkit-display: flex;
  -webkit-margin-bottom: 10%;
  .img1{
    position: relative;
    width: 20%;
    left: 35vw;
    -webkit-position: relative;
    -webkit-width: 20%;
    -webkit-left: 35vw;
    @media only screen and (max-width: $breakpoint-tablet) {
      display: none;
      -webkit-display: none;
    }
    img{
      width: 100%;
      height: 100%;
      border-radius: 50%;
      -webkit-width: 100%;
      -webkit-height: 100%;
      -webkit-border-radius: 50%;
    }
  }
  .text1 {
    position: absolute;
    width: 30%;
    height: auto;
    left: 4vw;
    -webkit-position: absolute;
    -webkit-width: 30%;
    -webkit-height: auto;
    -webkit-left: 4vw;
    @media only screen and (max-width: $breakpoint-tablet) {
      width: 90%;
      -webkit-width: 90%;
    }
    h3 {
      text-align: center;
      color: #417267;
      font-weight: bold;
      margin-top: auto;
      font-size: 2vw;
      margin-bottom: auto;
      text-transform: uppercase;
      -webkit-text-align: center;
      -webkit-color: #417267;
      -webkit-font-weight: bold;
      -webkit-margin-top: auto;
      -webkit-font-size: 2vw;
      -webkit-margin-bottom: auto;
      -webkit-text-transform: uppercase;
      @media only screen and (max-width: $breakpoint-mobile-large) {
        font-size: 5vw;
        -webkit-font-size: 5vw;
      }
    }
    .text-card1 {
      background-color: #417267;
      border-radius: 25px;
      height: auto;
      color: white;
      font-style: normal;
      font-weight: normal;
      font-size: 1vw;
      -webkit-background-color: #417267;
      -webkit-border-radius: 25px;
      -webkit-height: auto;
      -webkit-color: white;
      -webkit-font-style: normal;
      -webkit-font-weight: normal;
      -webkit-font-size: 1vw;
      @media only screen and (max-width: $breakpoint-tablet) {
        font-size: 2vw;
        -webkit-font-size: 2vw;
      }
      @media only screen and (max-width: $breakpoint-mobile-large) {
        font-size: 4vw;
        -webkit-font-size: 4vw;
      }
      p {
        padding-top: 4vw;
        margin: auto;
        width: 90%;
        margin-bottom: 3vw;
        -webkit-padding-top: 4vw;
        -webkit-margin: auto;
        -webkit-width: 90%;
        -webkit-margin-bottom: 3vw;
      }
      ul {
        width: 90%;
        margin: auto;
        padding-bottom: 4vw;
        -webkit-width: 90%;
        -webkit-margin: auto;
        -webkit-padding-bottom: 4vw;
      }
      a {
        text-align: center;
        display: block;
        -webkit-text-align: center;
        -webkit-display: block;
      }
    }
  }
  .img2{
    position: absolute;
    width: 25%;
    left: 35vw;
    margin-top: 15vw;
    -webkit-position: absolute;
    -webkit-width: 25%;
    -webkit-left: 35vw;
    -webkit-margin-top: 15vw;
    img{
      width: 100%;
      height: 100%;
      border-radius: 15%;
      -webkit-width: 100%;
      -webkit-height: 100%;
      -webkit-border-radius: 15%;
    }
    @media only screen and (max-width: $breakpoint-tablet) {
      left: 60vw;
      width: 35%;
      -webkit-left: 60vw;
      -webkit-width: 35%;
    }
    @media only screen and (max-width: $breakpoint-mobile-large) {
      margin-top: 60vw;
      width: 80%;
      left: 5vw;
      -webkit-margin-top: 60vw;
      -webkit-width: 80%;
      -webkit-left: 5vw;
    }
  }
}

.card2 {
  display: flex;
  margin-bottom: 5%;
  margin-top: 20%;
  -webkit-display: flex;
  -webkit-margin-bottom: 5%;
  -webkit-margin-top: 20%;
  @media only screen and (max-width: $breakpoint-tablet) {
    margin-top: 50%;
    -webkit-margin-top: 50%;
  }
  @media only screen and (max-width: $breakpoint-mobile-large) {
    margin-top: 140vw;
    -webkit-margin-top: 140vw;
  }
  @media only screen and (max-width: $breakpoint-mobile-m) {
    margin-top: 140vw;
    -webkit-margin-top: 140vw;
  }
  @media only screen and (max-width: $breakpoint-mobile-s) {
    margin-top: 70vh;
    -webkit-margin-top: 70vh;
  }
  .img3{
    position: relative;
    width: 30%;
    margin-left: 11vw;
    -webkit-position: relative;
    -webkit-width: 30%;
    -webkit-margin-left: 11vw;
    img{
      width: 100%;
      height: auto;
      -webkit-width: 100%;
      -webkit-height: auto;
    }
    @media only screen and (max-width: $breakpoint-tablet) {
      width: 40%;
      -webkit-width: 40%;
    }
    @media only screen and (max-width: $breakpoint-mobile-large) {
      width: 90%;
      margin-top: 65vw;
      margin-left: 5vw;
      -webkit-width: 90%;
      -webkit-margin-top: 65vw;
      -webkit-margin-left: 5vw;

    }
    @media only screen and (max-width: $breakpoint-mobile-m) {
      margin-top: 60vw;
      -webkit-margin-top: 60vw;
    }
    @media only screen and (max-width: $breakpoint-mobile-s) {
      margin-top: 35vh;
      -webkit-margin-top: 35vh;
    }
  }
  .text2 {
    position: absolute;
    width: 40%;
    height: 25vw;
    left: 48vw;
    border-radius: 5px;
    -webkit-position: absolute;
    -webkit-width: 40%;
    -webkit-height: 25vw;
    -webkit-left: 48vw;
    -webkit-border-radius: 5px;
    @media only screen and (max-width: $breakpoint-tablet) {
      width: 45%;
      -webkit-width: 45%;
    }
    @media only screen and (max-width: $breakpoint-mobile-large) {
      width: 90%;
      left: 5vw;
      -webkit-width: 90%;
      -webkit-left: 5vw;
    }
    h3 {
      text-align: center;
      color: #417267;
      font-weight: bold;
      margin-top: auto;
      font-size: 2vw;
      margin-bottom: auto;
      text-transform: uppercase;
      -webkit-text-align: center;
      -webkit-color: #417267;
      -webkit-font-weight: bold;
      -webkit-margin-top: auto;
      -webkit-font-size: 2vw;
      -webkit-margin-bottom: auto;
      -webkit-text-transform: uppercase;
      @media only screen and (max-width: $breakpoint-mobile-large) {
        font-size: 5vw;
        -webkit-font-size: 5vw;
      }
    }
    .text-card2 {
      background-color: #417267;
      border-radius: 25px;
      height: auto;
      color: white;
      font-style: normal;
      font-weight: normal;
      font-size: 1vw;
      -webkit-background-color: #417267;
      -webkit-border-radius: 25px;
      -webkit-height: auto;
      -webkit-color: white;
      -webkit-font-style: normal;
      -webkit-font-weight: normal;
      -webkit-font-size: 1vw;
      @media only screen and (max-width: $breakpoint-tablet) {
        font-size: 2vw;
        -webkit-font-size: 2vw;
      }
      @media only screen and (max-width: $breakpoint-mobile-large) {
        font-size: 4vw;
        -webkit-font-size: 4vw;
      }
      p {
        padding-top: 2vw;
        margin: auto;
        width: 90%;
        padding-bottom: 2vw;
        -webkit-padding-top: 2vw;
        -webkit-margin: auto;
        -webkit-width: 90%;
        -webkit-padding-bottom: 2vw;
      }
      ul {
        width: 90%;
        margin: auto;
        -webkit-width: 90%;
        -webkit-margin: auto;
      }
      a {
        text-align: center;
        display: block;
        -webkit-text-align: center;
        -webkit-display: block;
      }
    }
  }
}

.card3 {
  display: flex;
  margin-bottom: 30%;
  -webkit-display: flex;
  -webkit-margin-bottom: 30%;
  .img4{
    position: absolute;
    width: 15%;
    left: 40vw;
    z-index: 2;
    -webkit-position: absolute;
    -webkit-width: 15%;
    -webkit-left: 40vw;
    -webkit-z-index: 2;
    @media only screen and (max-width: $breakpoint-tablet) {
      display: none;
      -webkit-display: none;
    }
    img{
      width: 100%;
      height: 100%;
      -webkit-width: 100%;
      -webkit-height: 100%;
    }
  }
  .text3 {
    width: 40%;
    height: auto;
    position: absolute;
    z-index: 1;
    margin-top: 5vw;
    left: 4vw;
    border-radius: 5px;
    -webkit-width: 40%;
    -webkit-height: auto;
    -webkit-position: absolute;
    -webkit-z-index: 1;
    -webkit-margin-top: 5vw;
    -webkit-left: 4vw;
    -webkit-border-radius: 5px;
    @media only screen and (max-width: $breakpoint-tablet) {
      width: 55%;
      -webkit-width: 55%;
    }
    @media only screen and (max-width: $breakpoint-mobile-large) {
      width: 90%;
      -webkit-width: 90%;
    }
    h3 {
      text-align: center;
      color: #417267;
      font-weight: bold;
      margin-top: auto;
      font-size: 2vw;
      margin-bottom: auto;
      text-transform: uppercase;
      -webkit-text-align: center;
      -webkit-color: #417267;
      -webkit-font-weight: bold;
      -webkit-margin-top: auto;
      -webkit-font-size: 2vw;
      -webkit-margin-bottom: auto;
      -webkit-text-transform: uppercase;
      @media only screen and (max-width: $breakpoint-mobile-large) {
        font-size: 5vw;
        -webkit-font-size: 5vw;
      }
    }
    .text-card3 {
      background-color: #417267;
      border-radius: 25px;
      height: auto;
      color: white;
      font-style: normal;
      font-weight: normal;
      font-size: 1vw;
      -webkit-background-color: #417267;
      -webkit-border-radius: 25px;
      -webkit-height: auto;
      -webkit-color: white;
      -webkit-font-style: normal;
      -webkit-font-weight: normal;
      -webkit-font-size: 1vw;
      @media only screen and (max-width: $breakpoint-tablet) {
        font-size: 2vw;
        -webkit-font-size: 2vw;
      }
      @media only screen and (max-width: $breakpoint-mobile-large) {
        font-size: 4vw;
        -webkit-font-size: 4vw;
      }
      p {
        padding-top: 2vw;
        margin: auto;
        width: 90%;
        padding-bottom: 2vw;
        -webkit-padding-top: 2vw;
        -webkit-margin: auto;
        -webkit-width: 90%;
        -webkit-padding-bottom: 2vw;
      }
      ul {
        width: 90%;
        margin: auto;
        -webkit-width: 90%;
        -webkit-margin: auto;
      }
      a {
        text-align: center;
        display: block;
        -webkit-text-align: center;
        -webkit-display: block;
      }
    }
  }
  .img5{
    position: absolute;
    margin-top: 5vw;
    width: 35%;
    left: 53vw;
    -webkit-position: absolute;
    -webkit-margin-top: 5vw;
    -webkit-width: 35%;
    -webkit-left: 53vw;
    img{
      width: 100%;
      height: auto;
      -webkit-width: 100%;
      -webkit-height: auto;
    }
    @media only screen and (max-width: $breakpoint-tablet) {
      margin-top: 10vw;
      width: 45%;
      -webkit-margin-top: 10vw;
      -webkit-width: 45%;
    }
    @media only screen and (max-width: $breakpoint-mobile-large) {
      margin-top: 80vw;
      width: 90%;
      left: 5vw;
      -webkit-margin-top: 80vw;
      -webkit-width: 90%;
      -webkit-left: 5vw;
    }
    @media only screen and (max-width: $breakpoint-mobile-m) {
      margin-top: 80vw;
      -webkit-margin-top: 80vw;
    }
  }
}

.card4 {
  display: flex;
  -webkit-display: flex;
  .img6{
    position: absolute;
    width: 20%;
    left: 4vw;
    z-index: 1;
    -webkit-position: absolute;
    -webkit-width: 20%;
    -webkit-left: 4vw;
    -webkit-z-index: 1;
    @media only screen and (max-width: $breakpoint-tablet) {
      display: none;
      -webkit-display: none;
    }
    img{
      width: 100%;
      height: 100%;
      -webkit-width: 100%;
      -webkit-height: 100%;
    }
  }
  .img7{
    position: absolute;
    width: 30%;
    left: 22vw;
    margin-top: 5vw;
    z-index: 2;
    -webkit-position: absolute;
    -webkit-width: 30%;
    -webkit-left: 22vw;
    -webkit-margin-top: 5vw;
    -webkit-z-index: 2;
    img{
      width: 100%;
      height: auto;
      -webkit-width: 100%;
      -webkit-height: auto;
    }
    @media only screen and (max-width: $breakpoint-tablet) {
      margin-top: 20vw;
      width: 45%;
      left: 5vw;
      -webkit-margin-top: 20vw;
      -webkit-width: 45%;
      -webkit-left: 5vw;
    }
    @media only screen and (max-width: $breakpoint-mobile-large) {
      margin-top: 190vw;
      width: 90%;
      -webkit-margin-top: 190vw;
      -webkit-width: 90%;
    }
    @media only screen and (max-width: $breakpoint-mobile-m) {
      margin-top: 200vw;
      -webkit-margin-top: 200vw;
    }
    @media only screen and (max-width: $breakpoint-mobile-s) {
      margin-top: 110vh;
      -webkit-margin-top: 110vh;
    }
  }
  .text4 {
    width: 35%;
    height: auto;
    position: absolute;
    margin-top: 6%;
    z-index: 3;
    left: 50vw;
    border-radius: 5px;
    -webkit-width: 35%;
    -webkit-height: auto;
    -webkit-position: absolute;
    -webkit-margin-top: 6%;
    -webkit-z-index: 3;
    -webkit-left: 50vw;
    -webkit-border-radius: 5px;
    @media only screen and (max-width: $breakpoint-tablet) {
      margin-top: 20vw;
      left: 50vw;
      width: 45%;
      -webkit-margin-top: 20vw;
      -webkit-left: 50vw;
      -webkit-width: 45%;
    }
    @media only screen and (max-width: $breakpoint-mobile-large) {
      margin-top: 120vw;
      left: 5vw;
      width: 90%;
      -webkit-margin-top: 120vw;
      -webkit-left: 5vw;
      -webkit-width: 90%;
    }
    @media only screen and (max-width: $breakpoint-mobile-m) {
      margin-top: 120vw;
      -webkit-margin-top: 120vw;
    }
    @media only screen and (max-width: $breakpoint-mobile-s) {
      margin-top: 65vh;
      -webkit-margin-top: 65vh;
    }
    h3 {
      text-align: center;
      color: #417267;
      font-weight: bold;
      margin-top: auto;
      font-size: 2vw;
      margin-bottom: auto;
      text-transform: uppercase;
      -webkit-text-align: center;
      -webkit-color: #417267;
      -webkit-font-weight: bold;
      -webkit-margin-top: auto;
      -webkit-font-size: 2vw;
      -webkit-margin-bottom: auto;
      -webkit-text-transform: uppercase;
      @media only screen and (max-width: $breakpoint-mobile-large) {
        font-size: 5vw;
        -webkit-font-size: 5vw;
      }
    }
    .text-card4 {
      background-color: #417267;
      border-radius: 25px;
      height: auto;
      color: white;
      font-style: normal;
      font-weight: normal;
      font-size: 1vw;
      -webkit-background-color: #417267;
      -webkit-border-radius: 25px;
      -webkit-height: auto;
      -webkit-color: white;
      -webkit-font-style: normal;
      -webkit-font-weight: normal;
      -webkit-font-size: 1vw;
      @media only screen and (max-width: $breakpoint-tablet) {
        font-size: 2vw;
        -webkit-font-size: 2vw;
      }
      @media only screen and (max-width: $breakpoint-mobile-large) {
        font-size: 4vw;
        -webkit-font-size: 4vw;
      }
      p {
        padding-top: 2vw;
        margin: auto;
        width: 90%;
        -webkit-padding-top: 2vw;
        -webkit-margin: auto;
        -webkit-width: 90%;
      }
      ul {
        width: 90%;
        margin: auto;
        -webkit-width: 90%;
        -webkit-margin: auto;
      }
      a {
        text-align: center;
        display: block;
        -webkit-text-align: center;
        -webkit-display: block;
      }
    }
  }
}
.deco {
  position: absolute;
  right: 0px;
  -webkit-position: absolute;
  -webkit-right: 0px;
  img {
    width: 24vw;
    -webkit-width: 24vw;
  }
}
</style>
