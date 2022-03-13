<template>
  <div class="container">
    <h3>{{ $t("materiauxTiny.lesPlus.title") }}</h3>
    <div class="cards">
      <div class="cards1 picture">
        <div>
          <img
            :src="img1"
            alt="souvenir"
            class="image">
        </div>
        <div class="title overlay">
          <h3>{{ $t("materiauxTiny.titles.book") }}</h3>
          <p>
            {{ $t("materiauxTiny.paragraphs.album") }}
          </p>
        </div>
      </div>
      <div class="cards2 picture">
        <div>
          <img
            :src="img2"
            alt="activité"
            class="image">
        </div>
        <div class="title overlay">
          <h3>{{ $t("materiauxTiny.titles.activities") }}</h3>
          <p>
            {{ $t("materiauxTiny.paragraphs.discovery") }}
          </p>
        </div>
      </div>
      <div class="cards3 picture">
        <div>
          <img
            :src="img3"
            alt="cadeau"
            class="image">
        </div>
        <div class="title overlay">
          <h3>{{ $t("materiauxTiny.titles.gifts") }}</h3>
          <p>
            {{ $t("materiauxTiny.paragraphs.happy") }}
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import img1 from '@/assets/img/materiauxTiny/picto.png'
  import img2 from '@/assets/img/materiauxTiny/cards2.png'
  import img3 from '@/assets/img/materiauxTiny/cards3.png'
export default {
  name: 'LesPlus',
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
  margin: 0px 45px 50px 45px;
  .cards {
    display: flex;
    justify-content: space-around;
    .picture {
      width: 100%;
      position: relative;
      margin-left: 10px;
      margin-right: 10px;
      @media only screen and (max-width: $breakpoint-tablet) {
        margin-top: 10px;
        margin-bottom: 10px;
      }
    }
    .image {
        display: block;
        width: 100%;
        height: auto;
    }
    .overlay {
      position: absolute;
      bottom: 0;
      left: 0;
      right: 0;
      overflow: auto;
      width: 100%;
      height: 40px;
      transition: .5s ease;
      background: rgba(71, 100, 88, 0.9);
    }
    .picture:hover .overlay {
      height: 50%
    }
    h3 {
      font-size: 16px;
      font-family: roboto, "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
      text-align: center;
      color: #E5E5E5;
    }
    p {
      font-size: 12px;
      font-family: roboto, "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
      text-align: center;
      color: #E5E5E5;
    }
    @media only screen and (max-width: $breakpoint-tablet) {
          flex-direction: column;
    }
    .cards2 {
      width: 100%;
    }
    .cards3 {
      width: 100%;
    }
  }
  h3 {
      font-size: 18px;
      font-family: roboto, "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
      text-align: center;
      color: $agri-green;
    }
// .container {
//   min-height: 550px;
//   padding: 25px;
//   h3 {
//     font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
//       Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
//     color: $agri-green;
//     font-size: 24px;
//     font-weight: 900;
//   }
//   .cards {
//     display: flex;
//     justify-content: space-around;
//     @media only screen and (max-width: $breakpoint-tablet) {
//       flex-direction: column;
//     }
//     .cards1 {
//       width: 405px;
//       height: 300px;
//       background-image: url(~assets/img/materiauxTiny/picto.png);
//       background-repeat: no-repeat;
//       background-position: bottom;
//       background-size: cover;
//       position: relative;
//       @media only screen and (max-width: $breakpoint-tablet) {
//         width: 100%;
//         background-position: center;
//         background-image: url(~assets/img/materiauxTiny/card1mobile.png);
//       }
//     }
//     .cards2 {
//       width: 405px;
//       height: 300px;
//       background-image: url(~assets/img/materiauxTiny/cards2.png);
//       background-repeat: no-repeat;
//       background-position: bottom;
//       background-size: contain;
//       position: relative;
//       @media only screen and (max-width: $breakpoint-tablet) {
//         width: 100%;
//         background-position: center;
//         background-image: url(~assets/img/materiauxTiny/card2mobile.png);
//       }
//     }
//     .cards3 {
//       width: 405px;
//       height: 300px;
//       background-image: url(~assets/img/materiauxTiny/cards3.png);
//       background-repeat: no-repeat;
//       background-position: bottom;
//       position: relative;
//       @media only screen and (max-width: $breakpoint-tablet) {
//         width: 100%;
//         background-position: center;
//         background-image: url(~assets/img/materiauxTiny/card3mobile.png);
//       }
//     }
//     .title {
//       background-color: $agri-green;
//       width: 100%;
//       border-bottom-right-radius: 35px;
//       border-bottom-left-radius: 35px;
//       text-align: center;
//       position: absolute;
//       bottom: 0;
//       left: 0;
//     }
//     h3 {
//       font-size: 22px;
//       color: $tiny-beige;
//       font-weight: 400;
//       margin: 2px 0 0 0;
//     }
//     p {
//       font-size: 14px;
//       font-style: italic;
//       color: $tiny-beige;
//       margin: 4px auto 8px auto;
//       width: 90%;
//     }
//   }
}
</style>
