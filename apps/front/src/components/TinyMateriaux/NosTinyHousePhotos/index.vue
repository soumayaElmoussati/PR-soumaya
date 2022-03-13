<template>
  <div class="container">
    <h2>{{ $t("materiauxTiny.photos.title") }}</h2>
    <div class="photos">
      <img
        :src="img2"
        class="petitephoto"
        style="grid-area: petitephoto1"
        alt=""
      >
      <img
        :src="img3"
        class="petitephoto"
        style="grid-area: petitephoto2"
        alt=""
      >
      <img
        :src="img4"
        class="petitephoto"
        style="grid-area: petitephoto3"
        alt=""
      >
      <img
        :src="img5"
        class="petitephoto"
        style="grid-area: petitephoto4"
        alt=""
      >
      <img
        :src="img1"
        class="grandephoto"
        style="grid-area: grandephoto"
        alt=""
      >
    </div>
    <h2 style="margin-top: 35px">{{ $t("materiauxTiny.photos.title2") }}</h2>
    <div class="photos2">
      <img
        :src="img6"
        class="petitephoto"
        style="grid-area: petitephoto1"
        alt=""
      >
      <img
        :src="img7"
        class="petitephoto"
        style="grid-area: petitephoto2"
        alt=""
      >
      <img
        :src="img8"
        class="petitephoto"
        style="grid-area: petitephoto3"
        alt=""
      >
      <img
        :src="img9"
        class="petitephoto"
        style="grid-area: petitephoto4"
        alt=""
      >
      <img
        :src="img10"
        class="petitephoto"
        style="grid-area: grandephoto"
        alt=""
      >
    </div>
    <div class="buble">
      <h3>
        {{ $t("materiauxTiny.photos.content")[0] }}
        <br >
        {{ $t("materiauxTiny.photos.content")[1] }}
      </h3>
      <div class="button">
        <a
          href="/tiny-house"
          target="_blank">{{ $t("materiauxTiny.photos.button") }}</a>
      </div>
    </div>
  </div>
</template>

<script>
import img1 from '@/assets/img/materiauxTiny/photos1/pict1.png'
import img2 from '@/assets/img/materiauxTiny/photos1/pict5.png'
import img3 from '@/assets/img/materiauxTiny/photos1/pict3.png'
import img4 from '@/assets/img/materiauxTiny/photos1/pict4.png'
import img5 from '@/assets/img/materiauxTiny/photos1/pict2.png'
import img6 from '@/assets/img/materiauxTiny/photos2/pic5.png'
import img7 from '@/assets/img/materiauxTiny/photos2/pic3.png'
import img8 from '@/assets/img/materiauxTiny/photos2/pic1.png'
import img9 from '@/assets/img/materiauxTiny/photos2/pic2.png'
import img10 from '@/assets/img/materiauxTiny/photos2/pic4.png'
export default {
  name: 'NosTinyPhotos',
  data () {
    return {
      img1,
      img2,
      img3,
      img4,
      img5,
      img6,
      img7,
      img8,
      img9,
      img10
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
.container {
  padding: 15px 71px;
  // height: 251vh;
  height: auto;
  margin-bottom: 4%;
  @media only screen and (max-width: $breakpoint-tablet) {
    padding: 0 0 0 8px;
    height: 100%;
    margin-bottom: 20px;
  }
  h2 {
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    font-weight: 400;
    font-style: italic;
    font-size: 22px;
    color: $agri-green;
  }
  .photos {
    display: grid;
    grid-gap: 20px;
    grid-template-areas:
      "petitephoto1 petitephoto2 grandephoto"
      "petitephoto3 petitephoto4 grandephoto";
    @media only screen and (max-width: $breakpoint-tablet) {
      grid-gap: 5px;
      grid-template-areas:
        "grandephoto grandephoto"
        "petitephoto1 petitephoto2"
        "petitephoto3 petitephoto4";
    }
    .grandephoto {
        width: 100%;
        height: 100%;
      @media only screen and (max-width: $breakpoint-tablet) {
        width: 100%;
        height: 100%;
      }
    }
    .petitephoto {
        width: 100%;
        height: 100%;
      @media only screen and (max-width: $breakpoint-tablet) {
        width: 100%;
        height: 100%;
      }
    }
  }
  .photos2 {
    display: grid;
    grid-template-columns: repeat(9);
    grid-gap: 20px;
    grid-template-areas:
      "petitephoto1 petitephoto1 petitephoto1 petitephoto1 petitephoto2 petitephoto2 petitephoto2 petitephoto2 petitephoto2"
      "petitephoto3 petitephoto3 petitephoto3 petitephoto4 petitephoto4 petitephoto4 grandephoto grandephoto grandephoto";
    @media only screen and (max-width: $breakpoint-tablet) {
      display: grid;
      grid-gap: 5px;
      grid-template-areas:
        "petitephoto2 petitephoto2"
        "petitephoto1 grandephoto"
        "petitephoto3 petitephoto4";
    }
    .petitephoto {
        width: 100%;
        height: 100%;
      @media only screen and (max-width: $breakpoint-tablet) {
        width: 100%;
        height: 100%;
      }
    }
  }
  .buble {
    margin-top: 40px;
    background-color: $agri-green;
    // height: 191px;
    height: auto;
    border-radius: 39px;
    padding-top: 35px;
    @media only screen and (max-width: $breakpoint-tablet) {
      height: 100%;
      width: 100%;
      margin: 40px auto 0 auto;
    }
    h3 {
      font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
        Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
      font-size: 18px;
      font-weight: 400;
      line-height: 21px;
      text-align: center;
      color: $tiny-beige;
    }
    .button {
      display: flex;
      justify-content: center;
      a {
          margin-top: 12px;
          margin-bottom: 20px;
          align-self: center;
          text-decoration: none;
          width: 300px;
          background-color: $tiny-beige;
          border: none;
          cursor: pointer;
          color: $agri-green;
          font-weight: 900;
          font-size: 20px;
          padding: 14px 34px;
          border-radius: 99.5px;
          border: 1px solid $agri-green;
          box-shadow: 0px 3px 6px black;
        }
      @media only screen and (max-width: $breakpoint-tablet) {
        margin-bottom: 20px;
      }
    }
  }
}
</style>
