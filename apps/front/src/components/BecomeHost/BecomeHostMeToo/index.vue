<template>
  <div class="container">
    <div class="svg">
      <div class="content">
        <div class="title">
          Moi aussi je veux installer un terrain de Glamping sur mon exploitation
        </div>
        <div class="img">
          <img
            :src="tinyHouse"
            alt="" >
        </div>
        <div class="text">
          {{ $t('becomeHost.paragraphs.supporting') }}
          <br >
          <br >
          <span
          >{{ $t('becomeHost.paragraphs.open') }}
          </span>
        </div>
        <div class="cards">
          <div class="card-img">
            <img
              :src="img1"
              alt="" >
          </div>
          <div class="card-img">
            <img
              :src="img2"
              alt="" >
          </div>
          <div class="card-img">
            <img
              :src="img3"
              alt="" >
          </div>
        </div>
        <div class="btn">
          <a
            class="typeform-share button"
            href="https://qql4hcv3fo7.typeform.com/to/dicrq0QJ"
            data-mode="popup"
            data-size="100"
            target="_blank"
          >Plus d'information
          </a>
          <script type="application/javascript">(function() {var qs,js,q,s,d = document,gi = d.getElementById,ce = d.createElement,gt = d.getElementsByTagName,id = "typef_orm_share",b = "https://embed.typeform.com/";if (!gi.call(d, id)) {js = ce.call(d, "script");js.id = id;js.src = b + "embed.js";q = gt.call(d, "script")[0];q.parentNode.insertBefore(js, q);}})();
          </script>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import img1 from '@/assets/img/becomehost/img1.png'
import img2 from '@/assets/img/becomehost/img2.png'
import img3 from '@/assets/img/becomehost/img3.png'
import tinyHouse from '@/assets/img/becomehost/tiny-house 1.png'
export default {
  name: 'Metoo',
  data () {
    return {
      img1,
      img2,
      img3,
      tinyHouse
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
* {
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.container {
  height: 51vw;
  margin-bottom: 4%;
  // height: 675px !important;
  @media only screen and (max-width: $breakpoint-tablet) {
    height: auto;
    margin-bottom: 4%;
  }
}
.card-img {
  width: 100%
}
.svg {
  background-image: url("../../../assets/img/becomehost/back_green_beige.svg");
  background-size: 100% 100%;
  -o-background-size: 100% 100%;
  -webkit-background-size: 100% 100%;
  background-size: contain;
  background-repeat: no-repeat;
  height: 100%;
  @media only screen and (max-width: $breakpoint-tablet-l) {
    background-image: none;
  }
  @media only screen and (max-width: $breakpoint-laptop-generic) {
    background-size: 100% 90%;
    background-repeat: no-repeat;
  }
  .content {
    height: 80%;
    padding-top: 45px;
    .title {
      display: flex;
      justify-content: center;
      font-size: 22px;
      line-height: 26px;
      color: $agri-green;
      font-weight: 900;
      text-transform: uppercase;
      @media only screen and (max-width: $breakpoint-laptop-generic) {
        font-size: 18px;
        // margin-top: 4%;
      }
      @media only screen and (max-width: $breakpoint-tablet) {
        font-size: 16px;
        text-align: center;
      }
    }
    .text {
      padding-right: 4%;
      margin: 0 auto;
      width: 80%;
      text-align: left;
      font-size: 14px;
      line-height: 16.5px;
      color: $agri-green;
      margin-top: 25px;
      margin-right: 14%;
      span {
        font-weight: 700;
      }
      @media only screen and (max-width: $breakpoint-laptop-generic) {
        margin-top: 1%;
        font-size: 12px;
      }
      @media only screen and (max-width: $breakpoint-tablet) {
        margin-right: 0%;
        text-align: center;
        width: 100%;
      }
    }
    .cards {
      // width: 87%;
      width: 80%;
      margin: 45px auto 0 auto;
      padding-left: 4%;
      display: flex;
      /* justify-content: space-between; */
      @media only screen and (max-width: $breakpoint-laptop-generic) {
        width: 77%;
        margin-top: 2%;
      }
      @media only screen and (max-width: $breakpoint-tablet) {
        display: flex;
        flex-direction: column;
        align-items: center;
        width: 50%;
      }
      img {
        // margin-right: 60px;
        width: 100%;
        padding-right: 4%;
        @media only screen and (max-width: $breakpoint-tablet) {
          margin-bottom: 25px;
          margin-right: 0;
        }
        // @media only screen and (max-width: $breakpoint-laptop-generic) {
        //   width: 300px;
        // }
      }
    }
    .img {
      position: absolute;
      right: 25px;
      padding-right: 12px;
      @media only screen and (max-width: $breakpoint-tablet) {
        visibility: hidden;
      }
    }
  }
  .btn {
    // margin-top: 45px;
    margin-top: 2%;
    @media only screen and (max-width: $breakpoint-tablet) {
      margin-top: 25px;
    }
    a {
      text-decoration: none;
      width: 272px;
      background-color: $tiny-beige;
      border: none;
      cursor: pointer;
      color: $agri-green;
      font-weight: 900;
      font-size: 20px;
      padding: 14px 34px;
      border-radius: 99.5px;
    }
  }
}
</style>
