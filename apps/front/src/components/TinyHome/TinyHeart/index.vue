<template>
  <div class="heart-container">
    <div class="title">
      <h3>{{ $t("tinyhouse.titles.heart_title") }}</h3>
      <img
        :src="heartIcone"
        alt="coup de coeur" >
    </div>
    <div
      id="cardDeskt1"
      class="cards-heart">
      <offer-card-test
        v-for="offer in getOffers.slice(0, 2)"
        :key="offer.id"
        :offer="offer"
        :id="offer.id"
        residence_type="tiny_house"
      />
    </div>
    <div class="button">
      <div class="line" />
      <nuxt-link
        :to="{
          name: 'OffersTinyHouse'
        }"
        class="button btn-home-tiny">
        {{ $t("tinyhouse.buttons")[2] }}
      </nuxt-link>
      <div class="line" />
    </div>
  </div>
</template>

<script>
import heartIcone from '@/assets/img/homeTiny/heartIcone.png'
import tinyCards from '@/components/TinyHome/TinyCards'
import tinyCardsMobile from '@/components/TinyHome/TinyCardsMobile'
import blur1 from '@/assets/img/homeTiny/blur_filter1.png'
import blur2 from '@/assets/img/homeTiny/blur_filter2.png'
import OfferCardTest from '@/components/OffersList/_subs/OfferCardTest'
import { mapGetters } from 'vuex'

export default {
  components: {
    tinyCards,
    tinyCardsMobile,
    OfferCardTest
  },
  data () {
    return {
      heartIcone,
      blur1,
      blur2
    }
  },
  computed: {
    ...mapGetters([
      'getOffers',
      'getAllOffers',
      'getOffersMeta'
    ])
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
* {
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}
.heart-container {
  background-image: linear-gradient(
      to bottom,
      rgba(210, 204, 184, 0.7),
      rgba(210, 204, 184, 0.7)
    ),
    url("~assets/img/homeTiny/fondBois.png");
  /* min-height: 837px; */
  background-repeat: no-repeat;
  background-size: cover;
  padding: 20px 80px;
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 100% !important;
    padding: 0;
    height: auto;
  }
  .title {
    display: flex;
    justify-content: space-between;
    h3 {
      font-size: 24px;
      font-weight: 900;
      color: $agri-green;
      @media only screen and (max-width: $breakpoint-tablet) {
        text-align: center;
        margin-top: 45px;
      }
    }
    img {
      @media only screen and (max-width: $breakpoint-tablet) {
        width: 40px;
        height: 40px;
        position: absolute;
        left: 280px;
        transform: rotate(30deg);
      }
    }
  }
  .cards-heart {
    display: flex !important;
    justify-content: space-around;
    padding: 120px 0px;
    gap: 20px;
    @media only screen and (max-width: $breakpoint-tablet) {
      display: flex;
      flex-direction: column;
      justify-content: center;
      padding: 0 8px !important;
    }
    @media only screen and(max-width: $breakpoint-laptop-generic) {
      padding: 120px 15px;
    }
    #blur2 {
      @media only screen and (max-width: $breakpoint-tablet) {
        margin-top: 25px;
        margin-bottom: 45px;
      }
    }
  }
  .button {
    display: flex;
    justify-content: space-around;
    top: 0;
    @media only screen and (max-width: $breakpoint-tablet) {
      padding-bottom: 25px;
      padding-top: 25px;
    }
    @media only screen and (max-width: $breakpoint-mobile-m) {
      padding-bottom: 25px;
      padding-top: 25px;
    }
    .line {
      border-bottom: 4px solid $agri-green;
      width: 440px;
      margin-bottom: 20px;
      @media only screen and (max-width: $breakpoint-tablet) {
        display: none;
      }
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
 /*  #cardDeskt2 {
    display: block;
    @media only screen and (max-width: $breakpoint-tablet) {
      display: none;
    }
  } */
  #cardDeskt1 {
    display: block;
    /* @media only screen and (max-width: $breakpoint-tablet) {
      display: none;
    } */
    #blur1 {
      margin-right: 25px;
      /* @media only screen and(max-width: $breakpoint-laptop-l) {
        margin-right: 15px;
      } */
      @media only screen and (max-width: $breakpoint-tablet) {
        margin: 0;
        height: 300px;
      }
    }
    #blur2 {
      @media only screen and (max-width: $breakpoint-tablet) {
        height: 300px;
      }
    }
  }
/*   #cardMobile {
    display: none;
    @media only screen and (max-width: $breakpoint-tablet) {
      display: block;
    }
  } */
}
</style>
