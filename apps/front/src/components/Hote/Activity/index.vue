<template>
  <div style="background-color: #fff9e8">
    <div class="content">
      <div class="activities">
        <div class="title">
          <h3>{{ $t("chambreHote.activities.title") }}</h3>
          <hr>
        </div>
        <div class="cards">
          <div class="cardAct">
            <img
              src="@/assets/img/chambrehote/Group1.jpg"
              alt="" >
            <p>{{ $t("chambreHote.activities.card1Content") }}</p>
          </div>
          <div class="cardAct">
            <img
              src="@/assets/img/chambrehote/Group2.jpg"
              alt="" >
            <p>{{ $t("chambreHote.activities.card2Content") }}</p>
          </div>
          <div class="cardAct">
            <img
              src="@/assets/img/chambrehote/Group3.jpg"
              alt="" >
            <p>{{ $t("chambreHote.activities.card3Content") }}</p>
          </div>
          <div class="cardAct">
            <img
              src="@/assets/img/chambrehote/Group4.jpg"
              alt="" >
            <p>{{ $t("chambreHote.activities.card4Content") }}</p>
          </div>
        </div>
      </div>
      <div class="activities-resp">
        <div class="title">
          <h3>{{ $t("chambreHote.activities.title") }}</h3>
          <hr>
        </div>

        <vueper-slides
          :visible-slides="1"
          :gap="10"
          :slide-ratio="1 / 2"
          :dragging-distance="200"
          :breakpoints="{ 800: { visibleSlides: 1, slideMultiple: 1 } }"
          :bullets="true"
          class="no-shadow"
          bullets-outside
          arrows-inside
          transition-speed="250"
          fixed-height="75vh"
          slide-multiple
        >
          <template v-slot:arrow-left>
            <img
              class="arrow"
              src="@/assets/img/chambrehote/arrowLeft.png" >
          </template>

          <template v-slot:arrow-right>
            <img
              class="arrow"
              src="@/assets/img/chambrehote/arrowRight.png" >
          </template>
          <vueper-slide>
            <template v-slot:content>
              <div class="vueperslide__content-wrapper">
                <div
                  class="card_mobile"
                >
                  <div>
                    <img
                      src="@/assets/img/chambrehote/Group1.jpg"
                      alt=""
                    >
                  </div>
                  <div>
                    <p>
                      {{ $t("chambreHote.activities.card1Content") }}
                    </p>
                  </div>
                </div>
              </div>
            </template>
          </vueper-slide>
          <vueper-slide>
            <template v-slot:content>
              <div class="vueperslide__content-wrapper">
                <div
                  class="card_mobile"
                >
                  <div>
                    <img
                      src="@/assets/img/chambrehote/Group2.jpg"
                      alt=""
                    >
                  </div>
                  <div
                    class=""
                  >
                    <p>
                      {{ $t("chambreHote.activities.card2Content") }}
                    </p>
                  </div>
                </div>
              </div>
            </template>
          </vueper-slide>
          <vueper-slide>
            <template v-slot:content>
              <div class="vueperslide__content-wrapper">
                <div
                  class="card_mobile"
                >
                  <div>
                    <img
                      src="@/assets/img/chambrehote/Group3.jpg"
                      alt=""
                    >
                  </div>
                  <div
                    class=""
                  >
                    <p>
                      {{ $t("chambreHote.activities.card3Content") }}
                    </p>
                  </div>
                </div>
              </div>
            </template>
          </vueper-slide>
          <vueper-slide>
            <template v-slot:content>
              <div class="vueperslide__content-wrapper">
                <div class="card_mobile">
                  <img
                    src="@/assets/img/chambrehote/Group4.jpg"
                    alt=""
                  >
                  <p>
                    {{ $t("chambreHote.activities.card4Content") }}
                  </p>
                </div>
              </div>
            </template>
          </vueper-slide>
        </vueper-slides>
      </div>
    </div>
  </div>
</template>

<script>
  import { VueperSlides, VueperSlide } from 'vueperslides'
  import 'vueperslides/dist/vueperslides.css'
export default {
  name: 'Activity',
  components: { VueperSlides, VueperSlide }
}
</script>
<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
.content {
  margin: 4% 6% 4% 6%;
  h3 {
    padding-top: 4%;
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
    margin-bottom: 7%;
    width: 10%;
    border-bottom: $agri-green 4px solid;
  }
  .activities {
    @media only screen and (max-width: $breakpoint-tablet) {
      display: none;
    }
    h3 {
      font-size: 27px;
    }
    .cards {
      display: grid;
      justify-content: space-between;
      grid-template-columns: 280px 280px 280px 280px;
      grid-template-rows: 411px;
      grid-gap: 25px;
      overflow-x: auto;
      margin: auto;
      text-align: center;
      .cardAct {
        position: relative;
        background-color: $agri-green;
        display: flex;
        justify-content: center;
        align-items: center;
        width: 70%;
        height: 80%;
        margin: auto;
        img {
          position: absolute;
          right: 28px;
          top: -50px;
          width: 73%;
          height: auto;
        }
        p {
          padding: 0 2%;
          font-size: 16px;
          font-weight: 500;
        }
      }
    }
  }
  .activities-resp {
    display: none;
    @media only screen and (max-width: $breakpoint-tablet) {
      display: block;
      width: 58%;
      margin: auto;
      .card_mobile {
      position: relative;
      background-color: $agri-green;
      display: flex;
      justify-content: center;
      align-items: center;
      width: 50%;
      height: 50%;
      margin: auto;
      margin-top: 20%;
      margin-bottom: 20px;
        img {
        position: absolute;
        right: 25px;
        top: -70px;
        width: 73%;
        height: auto;
        }
        p {
        padding: 0 2%;
        font-size: 18px;
        font-weight: 500;
        }
      }
      @media only screen and (max-width: $breakpoint-phone) {
        width: auto;
      }
    }
  }
}
</style>
