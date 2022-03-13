<template>
  <div class="container">
    <div class="first-block">
      <div class="details">
        <h3>{{ $t("tinyhouse.titles.home_first_block") }}</h3>
        <img
          id="mobile"
          :src="photo1"
          class="photo-mobil-1"
          alt="" >
        <p style="margin-bottom: 30px">
          {{ $t("tinyhouse.content.first_block")[0] }}
          <br >
          <br >
          {{ $t("tinyhouse.content.first_block")[1] }}
          <br >
          <br >
          {{ $t("tinyhouse.content.first_block")[2] }}
          <br >
          <br >
          {{ $t("tinyhouse.content.first_block")[3] }}
        </p>
        <nuxt-link
          :to="{
            name: 'TinyConcept'
          }"
          class="button btn-home-tiny"
        >
          {{ $t("tinyhouse.buttons")[1] }}
        </nuxt-link>
      </div>
      <img
        id="desktop"
        :src="photo1"
        class="photo-1"
        alt="" >
    </div>
    <div class="second-block">
      <img
        id="desktop"
        :src="photo2"
        class="photo-2"
        alt="" >
      <div class="details">
        <h3>{{ $t("tinyhouse.titles.home_second_block") }}</h3>
        <img
          id="mobile"
          :src="photo2"
          class="photo-mobil-2"
          alt="" >
        <p style="margin-bottom: 30px">
          {{ $t("tinyhouse.content.second_block")[0] }}
          <br >
          <br >
          {{ $t("tinyhouse.content.second_block")[1] }}
          <br >
          <br >
          {{ $t("tinyhouse.content.second_block")[2] }}
          <br >
          <br >
          {{ $t("tinyhouse.content.second_block")[3] }}
        </p>
        <nuxt-link
          :to="{
            name: 'Materiaux'
          }"
          class="button btn-home-tiny"
        >
          {{ $t("tinyhouse.buttons")[1] }}
        </nuxt-link>
      </div>
    </div>
  </div>
</template>

<script>
import photo1 from '@/assets/img/homeTiny/firstBlockPhoto.jpg'
import photo2 from '@/assets/img/homeTiny/secondBlockPhoto.jpg'

export default {
  data () {
    return {
      photo1,
      photo2
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.photo-1 {
  height: auto;
  width: 359px;
  object-fit: cover;
}

.photo-2 {
  height: auto;
  width: 359px;
  object-fit: cover;
}

.photo-mobil-1 {
  width: auto;
  height: 50vw;
}

.photo-mobil-2 {
  width: auto;
  height: 50vw;
}

* {
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}
a {
  text-decoration: none;
}
.container {
  height: auto;
  margin-bottom: 10%;
  margin-left: 5%;
  margin-right: 5%;
  .first-block {
    background-color: rgba(71, 100, 88, 0.05);
    max-width: 1280px;
    display: flex;
    justify-content: space-between;
    margin: 0 auto;
    margin-top: 70px;
    @media only screen and (max-width: $breakpoint-tablet) {
      display: flex;
      flex-direction: column;
      background-color: white !important;
    }
    .details {
      display: grid;
      width: 900px;
      text-align: center;
      border: $agri-green 5px solid;
      @media only screen and (max-width: $breakpoint-tablet) {
        display: flex;
        flex-direction: column;
        width: 100% !important;
        border: none;
      }
      h3 {
        font-size: 22px;
        font-weight: 900;
        color: $agri-green;
        padding-top: 34px;
        @media only screen and (max-width: $breakpoint-tablet) {
          width: 80% !important;
          margin: 0 auto;
          margin-bottom: 20px;
        }
      }
      p {
        font-size: 14px;
        color: $agri-green;
        font-weight: 500;
        padding: 0 25px;
        text-align: left;
      }
      a {
        @media only screen and (max-width: $breakpoint-tablet) {
          margin: 0 auto;
          margin-bottom: 25px;
        }
      }
    }
    #desktop {
      display: block;
      @media only screen and (max-width: $breakpoint-tablet) {
        display: none;
      }
    }
    #mobile {
      display: none;
      @media only screen and (max-width: $breakpoint-tablet) {
        display: block;
        margin: 0 auto;
      }
    }
  }
  .second-block {
    background-color: rgba(71, 100, 88, 0.05);
    max-width: 1280px;
    display: flex;
    justify-content: space-between;
    margin: 0 auto;
    margin-top: 70px;
    @media only screen and (max-width: $breakpoint-tablet) {
      display: flex;
      flex-direction: column;
      background-color: white !important;
    }
    .details {
      display: grid;
      width: 900px;
      text-align: center;
      border: $agri-green 5px solid;
      padding-bottom: 30px;
      @media only screen and (max-width: $breakpoint-tablet) {
        display: flex;
        flex-direction: column;
        width: 100% !important;
        border: none;
      }
      h3 {
        font-size: 22px;
        font-weight: 900;
        color: $agri-green;
        padding-top: 34px;
        @media only screen and (max-width: $breakpoint-tablet) {
          width: 80% !important;
          margin: 0 auto;
          padding: 0;
          margin-bottom: 20px;
        }
      }
      p {
        font-size: 14px;
        color: $agri-green;
        font-weight: 500;
        padding: 0 25px;
        text-align: left;
      }
      a {
        @media only screen and (max-width: $breakpoint-tablet) {
          margin: 0 auto;
        }
      }
    }
    #desktop {
      display: block;
      @media only screen and (max-width: $breakpoint-tablet) {
        display: none;
      }
    }
    #mobile {
      display: none;
      @media only screen and (max-width: $breakpoint-tablet) {
        display: block;
        margin: 0 auto;
      }
    }
  }
}
.btn-home-tiny {
  margin: auto;
  margin-bottom: 4%;
  width: 272px;
  background-color: $tiny-beige;
  border: 1px solid $agri-green;
  cursor: pointer;
  color: $agri-green;
  font-weight: 900;
  font-size: 20px;
  padding: 14px 34px;
  border-radius: 99.5px;
}
</style>
