<template>
  <div>
    <div class="home-hero">
      <div class="home-hero__image h_small">
        <div class="wrap">
          <h1
            class="title title-all"
            style="display: inline">
            {{ $t("insoliteBretagne.hero.titleHero") }}
          </h1>
        </div>
      </div>
    </div>
    <!-- <Sejourner class="destkop" />
    <SejournerTablette class="tablette" />
    <SejournerMobile class="mobile" /> -->
  </div>
</template>

<script>
// import Sejourner from '@/components/InsoliteBretagne/Sejourner'
// import SejournerTablette from '@/components/InsoliteBretagne/SejournerTablette'
// import SejournerMobile from '@/components/InsoliteBretagne/SejournerMobile'
export default {
  name: 'HoteHero',
  // components: { Sejourner, SejournerTablette, SejournerMobile },
  data () {
    return {
      mobile: false,
      disabledDates: {
        to: new Date()
      }
    }
  },
  computed: {},
  methods: {}
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
* {
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}
.home-hero {
  background-image: linear-gradient(rgba(40, 58, 38, 0.5), rgba(46, 60, 45, 0.3)), url("~assets/img/insoliteBretagne/hero.png");
  background-size: cover;
  background-position: center;
  min-height: 85vh;
  width: 100%;
  @media only screen and (max-width: $breakpoint-phone) {
    min-height: 37vh;
  }
  .wrap {
  display: flex;
  height: 100%;
    h1 {
      font-size: 6vw;
      text-align: center;
      color: white;
      margin: auto;
      width: 87%;
      margin-top: 10%;
      font-weight: 500;
      text-shadow: 0 0 7px rgba(0, 0, 0, 0.25);
      @media only screen and (max-width: $breakpoint-phone) {
        font-size: 30px;
        margin-top: 15%;
      }
    }
  }
}
// .destkop {
//   display: none;
//   @media only screen and (min-width: $breakpoint-laptop-l) {
//     display: block;
//   }
// }
// .tablette {
//   display: none;
//   @media only screen and (max-width: $breakpoint-laptop-m) {
//     display: block;
//   }
//   @media only screen and (max-width: $breakpoint-tablet) {
//     display: block;
//   }
//   @media only screen and (max-width: $breakpoint-mobile-m) {
//     display: none;
//   }
// }
// .mobile {
//   display: none;
//   @media only screen and (max-width: $breakpoint-mobile-m) {
//     display: block;
//   }
// }

// .home-hero {
//   margin: 0 !important;
//   display: flex !important;
//   justify-content: center;
//   align-items: center;
//   text-align: center;
// }

// .shadow {
//   -webkit-box-shadow: 0 8px 6px -6px black;
//   -moz-box-shadow: 0 8px 6px -6px black;
//   box-shadow: 0 8px 6px -6px black;
// }

// .title-all {
//   font-size: 96px !important;
//   font-weight: 400;
// }

// .hide-input {
//   z-index: -99999999;
//   opacity: 0;
//   position: relative;
// }
// .image-container {
//   background-size: cover;
//   background-position-x: left;
//   background-position-y: center;
//   width: 100%;
//   position: absolute;
//   height: 900px;
//   opacity: 0;
// }
// #s1 {
//   background-image: url("~assets/img/insoliteBretagne/hero.png");
// }
// #s2 {
//   background-image: url("~assets/img/insoliteBretagne/hero.png");
// }
// #s3 {
//   background-image: url("~assets/img/insoliteBretagne/hero.png");
// }

// .slideshow {
//   overflow: hidden;
//   display: -webkit-box;
//   position: relative;
//   width: 100%;
//   min-height: 850px;
//   background-color: whitesmoke;
//   .empty-container {
//     height: 850px;
//   }
//   .hero-image {
//     opacity: 0;
//     position: absolute;
//     width: 100%;
//   }
//   .h-first {
//     opacity: 1;
//   }
// }
// .hero-content {
//   position: absolute;
//   margin-left: auto;
//   margin-right: auto;
//   left: 0;
//   right: 0;
//   margin-top: 150px;
// }

// .hero-wrap {
//   margin-left: auto;
//   margin-right: auto;
//   .title {
//     display: flex;
//     justify-content: flex-end;
//     flex-direction: row;
//     margin-right: 80px;
//     margin-bottom: 20px;
//     text-shadow: 0 0 7px rgba(0, 0, 0, 0.25);
//   }
// }

// @media only screen and (max-width: $breakpoint-tablet) {
//   .home-hero-titles {
//     margin-right: 10px !important;
//     margin-left: 10px !important;
//   }
// }
// @media only screen and (max-width: 500px) {
//   .home-hero-titles {
//     display: flex !important;
//     flex-direction: column !important;
//   }
// }
// .home-hero__image {
//   display: flex;
//   flex-direction: column;
//   box-shadow: inset 0px -100px 140px 0px #0000008c;
// }

// .home-hero-titles {
//   display: grid;
//   grid-template-columns: repeat(3, 1fr);
//   grid-column-gap: 30px;
//   margin-right: 100px;
//   margin-left: 100px;
//   margin-bottom: 20px;
//   .hh-sub {
//     text-align: center;
//     h2 {
//       margin: 0px;
//       font-size: 20px;
//       font-weight: 500;
//       margin: 12px 0;
//       color: white;
//     }
//     h3 {
//       margin: 0px;
//       font-size: 15px;
//       font-weight: 400;
//       margin: 12px 0;
//       color: white;
//     }
//   }
// }

// .home-hero {
//   display: flex;
//   flex-direction: column;
//   display: -webkit-box;
//   h1,
//   h2,
//   h3 {
//     user-select: none;
//   }

//   & > .wrap {
//     display: flex;
//     height: 100%;
//     flex: 1;

//     @media only screen and (max-width: $breakpoint-tablet) {
//       padding: 0 16px;
//     }
//   }

//   h1 {
//     display: flex;
//     flex-direction: column;
//     color: white;
//     margin: auto 0;
//   }

//   &__image {
//     display: flex;
//     min-height: 550px;
//     width: 100%;
//     background-color: $agri-grey;
//     background-image: linear-gradient(rgba(0, 0, 0, 0.4), rgba(0, 0, 0, 0.4)),
//       url("~assets/img/insoliteBretagne/hero.png");
//     background-size: cover;
//     background-position: center;

//     @media only screen and (max-width: $breakpoint-mobile-l) {
//       padding: 0 16px;
//     }

//     .wrap {
//       height: 100%;
//       width: 80%;
//       text-align: center;
//       display: flex;
//       @media only screen and (max-width: $breakpoint-tablet) {
//         margin-top: 150px;
//         margin-left: 12px;
//       }
//       @media only screen and (max-width: $breakpoint-mobile-m) {
//         margin: 0 auto;
//       }

//       .title {
//         font-size: 36px;
//         position: relative;
//         font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
//           Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
//         @media only screen and (max-width: $breakpoint-tablet) {
//           font-size: 50px !important;
//           font-weight: 500;
//           line-height: 38px;
//         }
//         @media only screen and (max-width: $breakpoint-mobile-m) {
//           font-size: 50px !important;
//           font-weight: 500;
//           line-height: 60px;
//         }
//       }
//     }
//   }

//   &__content {
//     background-color: $primary;
//     color: white;
//     padding: 32px 0;

//     @media only screen and (max-width: $breakpoint-mobile-l) {
//       padding: 32px 16px;
//     }

//     .wrap {
//       display: grid;
//       grid-template-columns: repeat(3, 1fr);
//       grid-gap: 16px;

//       @media only screen and (max-width: $breakpoint-tablet) {
//         grid-template-columns: 1fr;
//       }

//       .body-1 {
//         color: rgba(white, 0.7);
//       }

//       .headline {
//         color: white;
//       }
//     }
//   }
// }
// @media only screen and (max-width: $breakpoint-mobile-l) {
//   .wrap {
//     width: 90%;
//   }
//   .buttons {
//     display: flex;
//     justify-content: center;
//   }
//   .title {
//     margin-right: 0px !important;
//     justify-content: start !important;
//   }
// }
// @media only screen and (max-width: $breakpoint-tablet) {
//   .image-container {
//     background-position-x: -200px !important;
//   }
// }

// .h_small {
//   height: 75vh !important;
//   justify-content: center !important;
// }

// @media only screen and (max-width: $breakpoint-tablet) {
//   .h_small {
//     min-height: 735px !important;
//   }
// }
</style>
