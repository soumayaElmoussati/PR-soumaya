<template>
  <div class="general-card-content">
    <div class="confiance">
      <div class="title">
        <h3>
          {{ $t("home.trust.title") }}
        </h3>
        <div class="icone_card1">
          <img
            :src="charli"
            alt="charli_farmer" >
        </div>
      </div>
      <div class="content">
        <p>
          {{ $t("home.trust.description")[0] }}
          ».
        </p>
        <br >
        <p>
          {{ $t("home.trust.description")[1] }}{{ $t("home.trust.description")[2] }}
        </p>
        <br >
        <p>
          {{ $t("home.trust.description")[3] }} Une idée {{ $t("home.trust.description")[4] }}
        </p>
        <br >
        <p>
          {{ $t("home.trust.description")[5] }}
        </p>
        <br>
      </div>
    </div>
    <div class="instaCard">
      <div class="title">
        <h3>
          {{ $t("home.titles.instagram") }}
        </h3>
        <div class="icone_card2">
          <img
            :src="insta"
            alt="instagram" >
        </div>
      </div>
      <div class="detail_insta">
        <div class="img">
          <img
            :src="feedInsta"
            alt="feed insta" >
        </div>
        <div class="words">
          <p class="w1">{{ $t("home.feeds.quizz") }}</p>
          <p class="w2">{{ $t("home.feeds.jeux") }}</p>
          <p class="w3">{{ $t("home.feeds.filter") }}</p>
          <p class="w4">{{ $t("home.feeds.actus") }}</p>
          <p class="w5">{{ $t("home.feeds.promo") }}</p>
        </div>
      </div>
      <div style="display: flex; justify-content: center; margin-bottom: 35px;">
        <a
          href="https://www.instagram.com/agrivillage.fr/?hl=fr"
          target="_blank"
          class="farm-btn"
        >{{ $t("home.buttons.join") }} <i
          class="fab fa-instagram"
        /></a>
      </div>
    </div>
  </div>
</template>

<script>
import charli from '../../../assets/img/icones/charli.png'
import insta from '../../../assets/img/icones/insta.png'
import feedInsta from '../../../assets/img/instaCards/feed insta.png'
export default {
  name: 'HomeCardInsta',
  data () {
    return {
      charli,
      insta,
      feedInsta
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
body {
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}
p {
  padding: 0;
  margin: 0;
}
h3 {
  padding: 0;
  margin: 0 !important;
}
a {
  margin: 0;
}
.general-card-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  grid-gap: 38px;
  padding: 0;
  margin: 0 auto;
  margin: auto auto;
  .confiance {
    background-image: url("../../../assets/img/instaCards/RectangleAgri.png");
    background-repeat: no-repeat;
    background-position: 50% 0;
    margin-left: 20px;
    .title {
      margin: 0 auto;
      width: 75%;
      text-align: start;
      display: flex;
      justify-content: space-between;
      h3 {
        margin: 0;
        color: $agri-green;
        margin-top: 2em;
        font-size: 18px;
        font-weight: 800;
        padding: 30px 15px 0 15px;
        @media only screen and (max-width: $breakpoint-laptop-l) {
          padding: 15px 10px 0 10px;
        }
        @media only screen and (max-width: $breakpoint-laptop-m) {
          padding: 0 0 12px 0;
          font-size: 18px !important;
        }
      }
      @media only screen and (max-width: $breakpoint-laptop-l) {
        padding: 10px 0 0 0;
        width: 65% !important;
      }
      .icone_card1 {
        img {
          @media only screen and (max-width: $breakpoint-laptop-l) {
            width: 100px;
            height: 100px;
          }
        }
        @media only screen and (max-width: $breakpoint-laptop-m) {
          display: none;
        }
      }
      @media only screen and (max-width: $breakpoint-laptop-m) {
        /* margin-bottom: 15px; */
        margin-top: 10px;
        margin-bottom: 10px;
        width: 25% !important;
      }
      @media only screen and (max-width: $breakpoint-mobile-l) {
        width: 60%;
      }
      @media only screen and(max-width: $breakpoint-tablet) {
        width: 30% !important;
      }
      @media only screen and(max-width: $breakpoint-mobile-m) {
        width: 60% !important;
      }
      @media only screen and(max-width: $breakpoint-desktop) {
        width: 75%;
      }
    }
    .content {
      margin: 0 auto;
      width: 75%;
      @media only screen and (max-width: $breakpoint-laptop-l) {
        margin-top: -8px;
      }
      p {
        font-size: 14px;
        line-height: 19px;
        font-weight: 500;
        padding: 0 10px;

        @media only screen and (max-width: $breakpoint-laptop-m) {
          line-height: 12px !important;
          padding: 0 !important;
          font-size: 12px !important;
        }
        @media only screen and (max-width: $breakpoint-mobile-m) {
          line-height: 12px;
        }
        @media only screen and (max-width: $breakpoint-laptop-generic) {
          line-height: 14px;
          padding: 0;
          font-size: 16px;
        }
      }
      @media only screen and(max-width: $breakpoint-desktop) {
        width: 75%;
      }
      @media only screen and(max-width: $breakpoint-laptop-m) {
        width: 25%;
      }
      @media only screen and(max-width: $breakpoint-tablet) {
        width: 30%;
      }
      @media only screen and (max-width: $breakpoint-mobile-l) {
        width: 100% !important;
      }
    }
    @media only screen and (max-width: $breakpoint-laptop-m) {
      width: 100%;
      padding: 0;
      background-image: url("../../../assets/img/instaCards/miniRectangle.png") !important;
      background-position: 100% 0 !important;
      margin-left: 0 !important;
    }
    @media only screen and(max-width: $breakpoint-tablet) {
      /* margin-bottom: 2%; */
    }
    /* @media only screen and (max-width: $breakpoint-laptop-generic) {
      width: 100%;
      margin-left: 0;
    } */
  }
  .instaCard {
    background-image: url("../../../assets/img/instaCards/RectangleAgri.png");
    background-repeat: no-repeat;
    background-position: 50% 0;
    margin: 0;
    position: relative;
    /* margin-top: 85px; */
    .title {
      margin: 0 auto;
      width: 65% !important;
      /* text-align: start; */
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 38px 15px 0 15px;

      h3 {
        margin: 0;
        color: $agri-green;
        margin-top: 2em;
        font-size: 20px;
        font-weight: 800;
        @media only screen and (max-width: $breakpoint-laptop-m) {
          text-align: center;
          font-size: 14px !important;
        }
        @media only screen and (max-width: $breakpoint-laptop-l) {
          margin-right: 15px !important;
        }
      }
      .icone_card2 {
        margin: auto auto;
        img {
          width: 55px;
          height: 55px;
          @media only screen and (max-width: $breakpoint-laptop-m) {
            width: 40px;
            height: 40px;
          }
        }
      }
      @media only screen and (max-width: $breakpoint-laptop-l) {
        padding: 20px 15px 0 15px;
        width: 65% !important;
      }
      @media only screen and (max-width: $breakpoint-laptop-m) {
        width: 25% !important;
      }
      @media only screen and(max-width: $breakpoint-tablet) {
        width: 40% !important;
      }
      @media only screen and (max-width: $breakpoint-mobile-l) {
        width: 60% !important;
      }
      @media only screen and(max-width: $breakpoint-mobile-m) {
        width: 60% !important;
      }
    }
    .detail_insta {
      width: 90%;
      display: flex;
      justify-content: center;
      .img {
        display: flex;
        flex-direction: column;
      }
      .words {
        margin-top: 25px;
        p:nth-child(odd) {
          transform: rotate(-20deg);
          text-align: right;
        }
        p:nth-child(even) {
          transform: rotate(15deg);
          text-align: left;
        }
        p {
          color: $agri-green;
          font-size: 28px;
          font-weight: 800;
          /* line-height: 38px; */
          margin: 0 0 40px 0;
        }
        @media only screen and (max-width: $breakpoint-laptop-m) {
          display: none;
        }
      }
    }
    @media only screen and (max-width: $breakpoint-laptop-m) {
      width: 100%;
      padding: 0;
      background-image: url("../../../assets/img/instaCards/miniRectangle.png");
      background-position: 50% 0;
    }
    .farm-btn {
      text-align: center;
      color: $agri-white;
      font-size: 14px;
      font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
        Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
      font-weight: 900;
      background-color: $agri-green-light;
      text-transform: uppercase;
      border: 1px solid $agri-white;
      box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.4);
      padding: 13px 22px;
      text-decoration: none;
      text-transform: uppercase;
      border-radius: 45px;
      width: 200px;
      margin: auto auto;
      line-height: 20px !important;
      @media only screen and (max-width: $breakpoint-laptop-m) {
        margin: 0 auto;
      }
    }
  }
  @media only screen and (max-width: $breakpoint-laptop-l) {
    height: 80vh;
  }
  @media only screen and (max-width: $breakpoint-laptop-m) {
    display: grid;
    grid-template-columns: 1fr;
    width: 100%;
    margin-top: 35px;
    height: 150vh;
  }
  @media only screen and (max-width: $breakpoint-laptop-generic) {
    height: 100vh;
    grid-gap: 0px !important;
    margin: 0 !important;
    padding: 0 !important;
  }
  @media only screen and (max-width: $breakpoint-mobile-l) {
    height: 100%;
    grid-gap: 0px !important;
    margin: auto !important;
    padding: auto !important;
  }
}
</style>
