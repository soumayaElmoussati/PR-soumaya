<template>
  <div class="container">
    <div class="content">
      <div class="title">
        <h3> {{ $t('companySeminar.Seminar.title') }} </h3>
      </div>
      <div class="card-content">
        <div class="card">
          <div class="img">
            <img
              :src="img1"
              alt="">
          </div>
          <div class="text">
            <h4> {{ $t('companySeminar.Seminar.subtitle')[0] }} </h4>
            <ul>
              <li> {{ $t('companySeminar.Seminar.lists')[0] }} </li>
              <li> {{ $t('companySeminar.Seminar.lists')[1] }} </li>
              <li> {{ $t('companySeminar.Seminar.lists')[2] }} </li>
              <li> {{ $t('companySeminar.Seminar.lists')[3] }} </li>
            </ul>
          </div>
        </div>
        <div class="card">
          <div class="img">
            <img
              :src="img2"
              alt="">
          </div>
          <div class="text">
            <h4> {{ $t('companySeminar.Seminar.subtitle')[1] }} </h4>
            <ul>
              <li> {{ $t('companySeminar.Seminar.lists')[4] }} </li>
              <li> {{ $t('companySeminar.Seminar.lists')[5] }} </li>
              <li> {{ $t('companySeminar.Seminar.lists')[6] }} </li>
            </ul>
          </div>
        </div>
        <div class="card">
          <div class="img">
            <img
              :src="img3"
              alt="">
          </div>
          <div class="text">
            <h4> {{ $t('companySeminar.Seminar.subtitle')[2] }} </h4>
            <p> {{ $t('companySeminar.Seminar.paragraph') }} </p>
            <ul>
              <li> {{ $t('companySeminar.Seminar.lists')[7] }} </li>
              <li> {{ $t('companySeminar.Seminar.lists')[8] }} </li>
              <li> {{ $t('companySeminar.Seminar.lists')[9] }} </li>
            </ul>
          </div>
        </div>
      </div>

      <vueper-slides
        :visible-slides="3"
        :gap="3"
        :slide-ratio="1 / 4"
        :dragging-distance="200"
        :breakpoints="{ 800: { visibleSlides: 1, slideMultiple: 1 } }"
        :bullets="false"
        style="margin-bottom: 35px"
        arrows-outside
        fixed-height="360px"
        class="no-shadow"
        slide-multiple
      >
        <template v-slot:arrow-left>
          <img src="@/assets/img/chambrehote/arrowLeft.png" >
        </template>

        <template v-slot:arrow-right>
          <img src="@/assets/img/chambrehote/arrowRight.png" >
        </template>
        <vueper-slide
          v-for="(slide, i) in farms"
          :key="i"
          :title="slide.title"
        >
          <template v-slot:content>
            <div
              :style="
                'background-image: url(' +
                  slide.image +
                  '); background-size: cover; border-radius: 31px !important; width: 225px;'
              "
              class="vueperslide__content-wrapper"
            >
              <div
                style="font-size: 20px; line-height: 27px; font-weight: 900; color: white !important; font-size: 22px; position: absolute; bottom: 0; background-color: rgb(71, 100, 88); opacity: 1 !important; width: 225px; border-radius: 0 0 35px 35px; padding: 25px 0; text-transform: uppercase; font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;"
                class="vueperslide__title"
              >
                {{ slide.title }}
              </div>
            </div>
          </template>
        </vueper-slide>
      </vueper-slides>

      <br>

      <div class="btn">
        <a
          style="all:unset;font-family:Helvetica,Arial,sans-serif;display:inline-block;max-width:100%;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;background-color:#417266;color:#ffffff;font-size:18px;border-radius:8px;padding:0 30px;font-weight:bold;height:45px;cursor:pointer;line-height:45px;text-align:center;margin:0;text-decoration:none;"
          href="https://drive.google.com/file/d/1SqkXpDX0m_Kdfnf8ATzImwX8RZKJ7Y7y/view?usp=sharing"
          data-mode="popup"
          data-size="100"
          target="_blank"
        >
          {{ $t("companySeminar.Headers.buttonHeader") }}
        </a>
      </div>

    </div>
  </div>
</template>

<script>
import { VueperSlides, VueperSlide } from 'vueperslides'
import 'vueperslides/dist/vueperslides.css'
import img1 from '@/assets/img/companySeminar/pictures/s1.png'
import img2 from '@/assets/img/companySeminar/pictures/s2.png'
import img3 from '@/assets/img/companySeminar/pictures/s3.png'
export default {
  name: 'Seminar',
  components: { VueperSlides, VueperSlide },
  data () {
    return {
        farms: [
          {
            title: 'Vignes de Sauternes',
            image: require('@/assets/img/companySeminar/pictures/s1.png')
          },
          {
            title: 'Ferme des Ruats',
            image: require('@/assets/img/companySeminar/pictures/s2.png')
          },
          {
            title: 'Vignes en Camargue',
            image: require('@/assets/img/companySeminar/pictures/s3.png')
          }
      ],
      img1,
      img2,
      img3
    }
  }
}
</script>

<style lang="scss" scoped>
@import '@/assets/scss/_variables.scss';
* {
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
}
.container {
  margin-top: 11%;
  margin-bottom: 10%;
  -webkit-margin-top: 11%;
  -webkit-margin-bottom: 10%;
}
.title {
  text-align: center;
  -webkit-text-align: center;
  h3 {
    font-weight: bold;
    font-style: normal;
    font-size: 38px;
    color: #417267;
    text-transform: uppercase;
    -webkit-font-weight: bold;
    -webkit-font-style: normal;
    -webkit-font-size: 38px;
    -webkit-color: #417267;
    -webkit-text-transform: uppercase;
    @media only screen and (max-width: $breakpoint-mobile-large) {
      font-size: 30px;
      -webkit-font-size: 30px;
    }
  }
}
.card-content {
  display: grid;
  justify-content: space-around;
  grid-template-columns: 30% 30% 30%;
  -webkit-display: grid;
  -webkit-justify-content: space-around;
  -webkit-grid-template-columns: 30% 30% 30%;
  @media only screen and (max-width: $breakpoint-tablet) {
    grid-template-columns: 80%;
    -webkit-grid-template-columns: 80%;
  }
  @media only screen and (max-width: $breakpoint-mobile-large) {
    display: none;
    -webkit-display: none;
  }
  .card {
    .img {
      width: 100%;
      -webkit-width: 100%;
      img {
        width: 100%;
        height: 100%;
        border-radius: 25px;
        -webkit-width: 100%;
        -webkit-height: 100%;
        -webkit-border-radius: 25px;
      }
    }
    .text {
      color: #000000;
      -webkit-color: #000000;
      h4 {
        font-weight: normal;
        font-size: 36px;
        margin-bottom: auto;
        color: #417266;
        -webkit-font-weight: normal;
        -webkit-font-size: 36px;
        -webkit-margin-bottom: auto;
        -webkit-color: #417266;
      }
      p {
        margin-top: auto;
        font-size: 14px;
        font-style: italic;
        font-weight: normal;
        -webkit-margin-top: auto;
        -webkit-font-size: 14px;
        -webkit-font-style: italic;
        -webkit-font-weight: normal;
      }
      li {
        font-size: 18px;
        font-weight: normal;
        line-height: 35px;
        -webkit-font-size: 18px;
        -webkit-font-weight: normal;
        -webkit-line-height: 35px;
      }
    }
  }
}

.vueperslides__arrow {
  color: #466458;
  -webkit-color: #466458;
}

.vueperslides--fixed-height {
  height: 360px;
  -webkit-height: 360px;
}

.vueperslides__bullet .default {
  background-color: #466458;
  -webkit-background-color: #466458;
}

.vueperslides {
  margin: 0 20%;
  display: none;
  -webkit-margin: 0 20%;
  -webkit-display: none;
  @media only screen and (max-width: $breakpoint-mobile-large) {
    display: block;
    height: 360px;
    width: 60%;
    margin: 0;
    padding: 0;
    margin: 0 auto;
    -webkit-display: block;
    -webkit-height: 360px;
    -webkit-width: 60%;
    -webkit-margin: 0;
    -webkit-padding: 0;
    -webkit-margin: 0 auto;
  }
  @media only screen and (max-width: $breakpoint-mobile-m) {
    width: 67%;
    -webkit-width: 67%;
  }
}

.vueperslide {
  @media only screen and (max-width: $breakpoint-tablet) {
    margin-right: 0px;
    -webkit-margin-right: 0px;
  }
  &__title {
    font-size: 7em;
    opacity: 0.6;
    -webkit-font-size: 7em;
    -webkit-opacity: 0.6;
  }
}

</style>
