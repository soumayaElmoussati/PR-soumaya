<template>
  <div
    id="wrap_foot"
    class="wrapper_footer">
    <div
      id="generalContent"
      class="joinus-content">
      <div class="joinus-container">
        <div class="joinus-content">
          <div class="joinus-content-text">
            <h3 class="convinced-title">{{ $t("home.joinus.title") }}</h3>
            <p class="convinced-desc">
              {{ $t("home.joinus.description")[0] }} <br >
              {{ $t("home.joinus.description")[1] }} <br >
              {{ $t("home.joinus.description")[2] }}
            </p>
          </div>
          <img
            :src="logoCard"
            alt="logo_agrivillage"
            class="icones_png" >
        </div>
        <div class="joinus-card">
          <div class="joinus-text">
            <h4 class="text-title">{{ $t("home.joinus.client.title") }}</h4>
            <p class="text-body">{{ $t("home.joinus.client.sub_title") }}</p>
            <p class="text-body">{{ $t("home.joinus.client.description") }}</p>
            <button
              type="submit"
              class="btn farm-btn"
              style="margin-top: 25px"
              @click="goBecomeClient">
              {{ $t("home.joinus.client.call") }}
            </button>
          </div>

          <img
            src="~assets/img/joinus/devenirvisiteur.jpg"
            alt="famille"
            title="famille"
            class="joinus-img"
          >
        </div>

        <mq-layout mq="sm">
          <div class="joinus-card-2-sm">
            <div class="joinus-text-2">
              <h4 class="text-title">{{ $t("home.joinus.farmer.title") }}</h4>
              <p class="text-body">{{ $t("home.joinus.farmer.sub_title") }}</p>
              <p class="text-body">
                {{ $t("home.joinus.farmer.description") }}
              </p>
              <br >
              <button
                type="submit"
                class="btn farm-btn-big"
                @click="goBecomeHost">
                {{ $t("home.joinus.farmer.call") }}
              </button>
            </div>

            <img
              src="~assets/img/joinus/deveniragri.png"
              alt="agriculteur"
              title="agriculteur"
              class="joinus-img"
            >
          </div>
        </mq-layout>

        <mq-layout mq="lg">
          <div class="joinus-card-2">
            <img
              src="~assets/img/joinus/deveniragri.png"
              alt="agriculteur"
              title="agriculteur"
              class="joinus-img"
            >

            <div class="joinus-text-2-sm">
              <h4 class="text-title">{{ $t("home.joinus.farmer.title") }}</h4>
              <p class="text-body">{{ $t("home.joinus.farmer.sub_title") }}</p>
              <p class="text-body">
                {{ $t("home.joinus.farmer.description") }}
              </p>
              <br >
              <button
                type="submit"
                class="btn farm-btn"
                @click="goBecomeHost">
                {{ $t("home.joinus.farmer.call") }}
              </button>
            </div>
          </div>
        </mq-layout>
      </div>
    </div>
  </div>
</template>

<script>
import SignInForm from '@/components/SignIn/SignInForm'
import logoCard from '../../../assets/img/logo/logo_vertical_noir 1.png'
export default {
  name: 'HomeFooter',
  components: {
    SignInForm
  },
  data () {
    return {
      logoCard
    }
  },
  methods: {
    goBecomeClient () {
      this.$router.push({
        name: 'BecomeClient'
      })
    },
    goBecomeHost () {
      this.$router.push({
        name: 'BecomeHost'
      })
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.forest-modal {
  width: 100%;
  height: 100%;
}

#wrap_foot {
  @media only screen and (max-width: $breakpoint-mobile-m) {
    height: 1850px !important;
  }
  @media only screen and (max-width: $breakpoint-tablet) {
    height: auto;
  }
}

.modal {
  padding: 0px 0px;
  border-radius: 50px;
}

.modal-content {
  padding: 0px 85px;
}

.modal-header {
  background-color: grey;
  height: 100px;
}

.modal-title {
  font-weight: 800;
  font-size: 20px;
  color: #476458;
  text-transform: uppercase;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.modal-text {
  font-size: 14px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  color: #555f61;
}

.joinus-content {
  display: flex;
  justify-content: space-between;
}

.garanties-container {
  max-width: 1280px;
  width: 75%;
  margin: auto;
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 90%;
  }
}

.argument-img {
  width: 95px;
  height: 95px;
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 100%;
  }
}

.text-title {
  font-weight: 800;
  margin-top: 40px;
  text-align: center;
  font-size: 16px;
  @media only screen and (max-width: $breakpoint-tablet) {
    font-size: 20px;
    font-weight: 900;
    line-height: 27px;
    padding: 0 12px;
  }
}

.text-body {
  text-align: center;
  font-size: 14px;
  margin: 0 50px !important;
  @media only screen and (max-width: $breakpoint-tablet) {
    margin-left: 20px;
    margin-right: 20px;
    color: #000;
    font-weight: 500;
    text-align: start;
  }
}

.garanties {
  width: 100%;
  margin: 0 auto;
  padding-top: 100px;

  .title {
    color: #476458;
    text-transform: uppercase;
    font-weight: bold;
    font-size: 25px;
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    text-align: center;
    padding-top: 100px;
    padding-bottom: 50px;
  }

  .arguments {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    grid-gap: 15px;
    padding-bottom: 100px;

    @media only screen and (max-width: $breakpoint-tablet) {
      grid-template-columns: repeat(1, 1fr);
    }

    .card {
      display: grid;
      grid-template-columns: 96px auto;
      grid-gap: 9px;
      @media only screen and (max-width: $breakpoint-tablet) {
        grid-template-columns: repeat(1, 1fr);
        width: 100%;
        text-align: center;
      }

      .card-resume {
        display: flex;
        flex-direction: column;
        color: #476458;
        font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
          Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;

        .catchline {
          text-transform: uppercase;
          font-weight: bold;
          font-size: 16px;
        }

        .card-text {
          font-size: 14px;
        }
      }
    }
  }
}

.type-title {
  font-weight: 800;
  font-size: 20px;
  color: #476458;
  text-transform: uppercase;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  text-align: left;
  border-bottom: solid 1px #417267;
  @media only screen and (max-width: $breakpoint-tablet) {
    font-size: 16px;
    text-align: center;
  }
}

.convinced-title {
  padding-bottom: 30px;
  font-weight: 800;
  font-size: 20px;
  color: #476458;
  text-transform: uppercase;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  margin-top: 0px;
  margin-bottom: 0px;
  @media only screen and (max-width: $breakpoint-tablet) {
    font-size: 22px;
    font-weight: 900;
    line-height: 30px;
    text-align: center;
    margin: 0 auto;
    width: 50%;
  }
}

.end-resume {
  color: #476458;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.country-list {
  list-style-image: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='10' height='10' viewBox='-1 -1 2 2'><circle r='1' /></svg>");
  li {
    color: #476458;
    font-weight: 800;
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    font-size: 15px;
    padding-left: 20px;
    margin: 1em 0;
  }
}

.where-resume {
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  color: #476458;
}

.where-title {
  font-weight: 800;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  font-size: 30px;
  color: #476458;
  text-transform: uppercase;
}

.where-is {
  display: grid;
  grid-template-columns: 75px auto;
  margin-right: 250px;
  margin-left: 250px;

  background-image: url(~assets/img/icon.png);
  background-repeat: no-repeat;
  background-position: center;
  background-size: 750px 530px;

  @media only screen and (max-width: $breakpoint-tablet) {
    grid-template-columns: 100%;
    margin-right: 0px;
    margin-left: 0px;
  }
}

.about-us {
  background-color: white;
  margin-bottom: 100px;
}

.why-title {
  font-weight: 800;
  color: #476458;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  font-size: 17px;
  text-transform: uppercase;
}

.whyus {
  display: grid;
  grid-template-columns: 50% 50%;
  margin-right: 170px;
  margin-left: 170px;
  grid-gap: 50px;
  padding-top: 50px;
  padding-bottom: 70px;
  @media only screen and (max-width: $breakpoint-tablet) {
    grid-template-columns: 100%;
    margin-right: 0px;
    margin-left: 0px;
  }
}

.whyheader {
  display: grid;
  grid-template-columns: 65px auto;
}

.whytext {
  text-align: justify;
  color: #4e5547;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  margin-top: 20px;
}

.joinus-title {
  font-size: 20px;
  font-weight: 800;
  color: #476458;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  text-transform: uppercase;
  text-align: right;
  margin-top: 0px;
  padding-top: 26px;
}

.icones_png {
  width: 138px;
  height: 126px;
  @media only screen and (max-width: $breakpoint-tablet) {
    display: none;
  }
}

.convinced-desc {
  font-size: 14px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  color: #555f61;
  padding-bottom: 50px;
  margin-top: 0;
  margin-bottom: 0;
  @media only screen and (max-width: $breakpoint-tablet) {
    font-weight: 500;
    line-height: 19px;
  }
}

.join-desc {
  font-size: 14px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  color: #555f61;
  text-align: left;
}

.solution-title {
  font-size: 26px;
  font-weight: 800;
  color: #476458;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  text-transform: uppercase;
  text-align: center;

  // border: 1px solid #476458;
  // width: 400px;
  // margin-left: 35%;
  margin-bottom: 75px;
  @media only screen and (max-width: 700px) {
    margin-left: 0%;
    width: 100%;
  }
}

.joinus-container {
  padding-top: 50px;
  padding-bottom: 115px;
  max-width: 1280px;
  width: 60%;
  margin: auto;
  .joinus-content {
    text-align: start;
  }
  @media only screen and (max-width: $breakpoint-tablet-l) {
    padding-bottom: 1%;
  }
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 95%;
    height: auto;
  }
}

.joinus-card {
  margin-left: 100px;
  margin-right: 100px;
  margin-bottom: 65px;
  display: grid;
  grid-template-columns: auto auto;
  margin-bottom: 50px;
  box-shadow: 0px 3px 6px rgba(0, 0, 0, 0.16);
  background-color: $agri-white;
  border-top-left-radius: 50px;
  border-bottom-left-radius: 50px;
  @media only screen and (max-width: $breakpoint-tablet) {
    grid-template-columns: 100%;
    margin-left: 0px;
    margin-right: 0px;
    border-bottom-left-radius: 0px;
    border-top-right-radius: 50px;
  }
  @media only screen and (max-width: $breakpoint-laptop-l) {
    margin-left: 0px;
    margin-right: 0px;
  }
}

.joinus-card-2 {
  margin-left: 100px;
  margin-right: 100px;
  display: grid;
  grid-template-columns: auto auto;
  box-shadow: 0px 3px 6px rgba(0, 0, 0, 0.16);
  border-top-right-radius: 50px;
  border-bottom-right-radius: 50px;
  background-color: $agri-white;
  @media only screen and (max-width: $breakpoint-tablet) {
    grid-template-columns: 100%;
    margin-left: 0px;
    margin-right: 0px;
    border-bottom-left-radius: 0px;
    border-top-right-radius: 50px;
  }
  @media only screen and (max-width: $breakpoint-laptop-l) {
    margin-left: 0px;
    margin-right: 0px;
  }
}

.joinus-card-2-sm {
  margin-left: 100px;
  margin-right: 100px;
  display: grid;
  grid-template-columns: auto auto;
  box-shadow: 0px 3px 6px rgba(0, 0, 0, 0.16);
  border-top-right-radius: 50px;
  border-top-left-radius: 50px;
  background-color: $agri-white;
  @media only screen and (max-width: $breakpoint-tablet) {
    grid-template-columns: 100%;
    margin-left: 0px;
    margin-right: 0px;
  }
  @media only screen and (max-width: $breakpoint-laptop-l) {
    margin-left: 0px;
    margin-right: 0px;
  }
}

.joinus-img {
  width: 255px;
  height: 259px;
  max-height: 340px;
  @media only screen and (max-width: $breakpoint-tablet) {
    /* width: 100%;
      max-width: 100%; */
    width: 100%;
    height: 294px;
    margin: 0 auto;
  }
}

.joinus-text {
  font-size: 12px;
  color: #417267;
  background-color: white;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  border-top-left-radius: 50px;
  border-bottom-left-radius: 50px;
  @media only screen and (max-width: $breakpoint-tablet) {
    border-top-left-radius: 50px;
    border-top-right-radius: 50px;
    border-bottom-left-radius: 0px;
    border-bottom-right-radius: 0px;
  }
}

.joinus-text-2 {
  font-size: 12px;
  color: #417267;
  background-color: white;
  border-top-right-radius: 50px;
  border-bottom-right-radius: 50px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  @media only screen and (max-width: $breakpoint-tablet) {
    border-top-left-radius: 50px;
    border-top-right-radius: 50px;
    border-bottom-left-radius: 0px;
    border-bottom-right-radius: 0px;
  }
}

.joinus-text-2-sm {
  font-size: 12px;
  color: #417267;
  background-color: white;
  border-top-right-radius: 50px;
  border-bottom-right-radius: 50px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  @media only screen and (max-width: $breakpoint-tablet) {
    border-top-left-radius: 50px;
    border-top-right-radius: 50px;
    border-bottom-left-radius: 0px;
    border-bottom-right-radius: 0px;
  }
}

.farm-btn {
  color: $agri-white;
  font-size: 14px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  font-weight: 900;
  background-color: $agri-green-light;
  margin: auto;
  text-transform: uppercase;
  border: 1px solid $agri-white;
  box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.4);
  padding: 13px 10px;
  text-decoration: none;
  text-transform: uppercase;
  border-radius: 45px;
  width: 240px;
  /* margin-bottom: 20px; */
  line-height: 20px !important;
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 85%;
    border-radius: 45px;
    margin: auto;
    border: none;
    background-color: $agri-green-light;
    color: $agri-white;
    margin-bottom: 12px;
  }
}

.farm-btn-big {
  color: $agri-white;
  font-size: 14px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  font-weight: 900;
  background-color: $agri-green-light;
  margin: auto;
  text-transform: uppercase;
  border: 1px solid $agri-white;
  box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.4);
  padding: 13px 13px;
  text-decoration: none;
  text-transform: uppercase;
  border-radius: 45px;
  width: 250px;
  margin-bottom: 20px;
  line-height: 20px !important;
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 85%;
    border-radius: 45px;
    margin: auto;
    border: none;
    background-color: $agri-green-light;
    color: $agri-white;
    margin-bottom: 12px;
  }
}

.solutions {
  padding-bottom: 100px;
  margin-left: 75px;
  margin-right: 75px;
  background-image: url(~assets/img/joinus/light-background.png);
  background-position: top;
  background-repeat: no-repeat;
  background-size: 1200px 970px;
}

.list-solutions {
  display: grid;
  grid-template-columns: 25% 25% 25% 25%;
  @media only screen and (max-width: 700px) {
    grid-template-columns: 100%;
  }
}

.list-elem {
  margin-bottom: 6px;
}

.list-link {
  color: #476458;
  text-decoration: none;
  cursor: pointer;
  font-size: 13px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

@media only screen and (max-width: 700px) {
  .f_item1,
  .f_item3 {
    grid-column-start: 1;
    grid-column-end: 3;
  }
  .f_item2,
  .f_item4 {
    grid-column-start: 3;
    grid-column-end: 5;
  }
  .f_subtitle {
    font-size: 16px !important;
  }
  .f_text {
    font-size: 12px !important;
  }
}
@media only screen and (max-width: $breakpoint-mobile-l) {
  .f_item1,
  .f_item3,
  .f_item2,
  .f_item4 {
    grid-column-start: 1;
    grid-column-end: 5;
  }
}

.wrapper_footer {
  // background-color: #F2F2F2;
  // padding: 10px;
  padding-bottom: 0px !important;
  .f_subtitle {
    margin: 0px;
    font-size: 20px;
    font-weight: 500;
    margin: 12px 0;
    color: black;
    text-align: center;
  }
  .f_text {
    margin: 0px;
    font-size: 16px;
    font-weight: 400;
    margin: 4px 0;
    color: black;
    text-align: center;
  }
  .f_icon {
    height: 70px;
    margin-bottom: 20px;
  }
  .f_title,
  .f_item1,
  .f_item2,
  .f_item3,
  .f_item4 {
    text-align: center;
  }
  .f_title {
    grid-column-start: 1;
    grid-column-end: 5;
    margin-bottom: 20px;
    margin-top: 20px;
    h1 {
      font-size: 30px;
      font-weight: 500;
      margin: 8px 0;
      color: rgba(0, 0, 0, 0.76);
      text-align: center;
    }
  }
  #generalContent {
    background-color: $agri-grey-back;
    @media only screen and (max-width: $breakpoint-tablet) {
      background-color: $agri-yellow-back;
    }
  }
}
</style>
