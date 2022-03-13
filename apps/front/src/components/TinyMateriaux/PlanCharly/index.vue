<template>
  <div>
    <div class="container">
      <div class="charli">
        <img
          :src="charli"
          alt="" >
        <div class="symbols">
          <div class="border" />
          <i class="fas fa-quote-left" />
        </div>
        <p>
          {{ $t("materiauxTiny.paragraphs.pause") }}
          <br >
          <br >
          {{ $t("materiauxTiny.paragraphs.sleeped") }}
        </p>
      </div>
      <div class="plan">
        <div class="content">
          <div class="text">
            <h2> {{ $t("materiauxTiny.titles.plan") }} </h2>
            <p> {{ $t("materiauxTiny.titles.discovery") }} </p>
            <div class="list">
              <ul>
                <li>
                  <div>
                    <img
                      :src="icone1">
                  </div>
                  <p> {{ $t("materiauxTiny.lists.person") }}</p>
                </li>
                <li>
                  <div>
                    <img
                      :src="icone2">
                  </div>
                  <p> {{ $t("materiauxTiny.lists.bathroom") }} </p>
                </li>
                <li>
                  <div>
                    <img
                      :src="icone3">
                  </div>
                  <p> {{ $t("materiauxTiny.lists.salon") }}</p>
                </li>
                <li>
                  <div>
                    <img
                      :src="icone4">
                  </div>
                  <p> {{ $t("materiauxTiny.lists.patio") }}</p>
                </li>
                <li>
                  <div>
                    <img
                      :src="icone5">
                  </div>
                  <p> {{ $t("materiauxTiny.lists.nightSpace") }}</p>
                </li>
                <li>
                  <div>
                    <img
                      :src="icone6">
                  </div>
                  <p> {{ $t("materiauxTiny.lists.toilet") }}</p>
                </li>
                <li>
                  <div>
                    <img
                      :src="icone7">
                  </div>
                  <p> {{ $t("materiauxTiny.lists.cook") }}</p>
                </li>
              </ul>
            </div>
          </div>
          <div class="model">
            <img
              :src="plan"
              alt="maquette">
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import charli from '@/assets/img/icones/charli.png'
import icone1 from '@/assets/img/materiauxTiny/plan/group 2.png'
import icone2 from '@/assets/img/materiauxTiny/plan/bathtub 2.png'
import icone3 from '@/assets/img/materiauxTiny/plan/living-room 1.png'
import icone4 from '@/assets/img/materiauxTiny/plan/terrace 1.png'
import icone5 from '@/assets/img/materiauxTiny/plan/bed 2.png'
import icone6 from '@/assets/img/materiauxTiny/plan/toilet 1.png'
import icone7 from '@/assets/img/materiauxTiny/plan/kitchen 1.png'
import plan from '@/assets/img/materiauxTiny/plan/plan.png'
export default {
  name: 'PlanCharly',
  data () {
    return {
      charli,
      icone1,
      icone2,
      icone3,
      icone4,
      icone5,
      icone6,
      icone7,
      plan
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.container {
  margin-top: 50px;
  .charli {
    background-color: #d2ccb8;
    text-align: center;
    width: 100%;
    margin: 0 0;
    display: flex;
    border-top-right-radius: 98.5px;
    border-bottom-right-radius: 98.5px;
    height: 100%;
    @media only screen and (max-width: $breakpoint-tablet) {
        border-radius: 10px;
        height: 100%;
        width: 100%;
      }
    p {
      font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
        Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
      font-weight: 400;
      font-size: 14px;
      text-align: start;
      align-self: center;
      margin-left: 15px;
      color: $agri-green !important;
      padding: 0 25px 0 0;
      margin-right: 15px;
      width: 100%;
      @media only screen and (max-width: $breakpoint-tablet) {
        margin: 0;
        padding: 0;
        width: 100%;
      }
    }
    .symbols {
      display: flex;
      justify-content: center;
      margin-top: 8px;
      i {
        margin-top: 15px 15px;
        @media only screen and (max-width: $breakpoint-tablet) {
          margin-top: 20px;
        }
      }
      .border {
        border-left: 1px solid #476458;
        margin: 35px 0;
        @media only screen and (max-width: $breakpoint-tablet) {
          margin: 50px 0;
        }
      }
      @media only screen and (max-width: $breakpoint-tablet) {
        margin: 0;
      }
    }
    img {
      height: 210px;
      width: 210px;
      margin: 0;
      @media only screen and (max-width: $breakpoint-tablet) {
        height: 100%;
        width: 100%;
      }
    }
    @media only screen and (max-width: $breakpoint-tablet) {
      border-top-left-radius: 0;
      border-bottom-left-radius: 0;
      width: 100%;
    }
  }
  .plan {
    margin: 30px 30px 50px 30px;
    .content {
      display: flex;
      justify-content: space-between;
      @media only screen and (max-width: $breakpoint-tablet) {
        display: flex;
        flex-direction: column;
      }
      .list {
        column-count: 2;
        column-fill: auto;
        column-gap: 20px;
        margin-top: 30px;
      }
      .text {
        width: 100%;
        img {
          width: auto;
          height: auto;
          margin-right: 20px;
        }
        p {
          font-size: 14px;
          font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
            Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
          color: $agri-green;
        }
        h2 {
          font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
            Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
          font-style: italic;
          font-size: 22px;
          color: $agri-green;
        }
      }
      .model {
        img {
          width: 100%;
          height: 100%;
          @media only screen and (max-width: $breakpoint-tablet) {
            width: 100%;
            height: 100%;
          }
        }
      }
      li{
        display: flex;
        margin-top: 20px;
      }
    }
  }
}
</style>
