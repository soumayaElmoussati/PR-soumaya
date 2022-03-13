<template>
  <div class="home-hero">
    <div class="home-hero__image h_small">
      <div class="wrap">
        <h1
          class="title title-all"
          style="display: inline">
          {{ $t("glamping.titles.stay") }}
        </h1>
      </div>
      <div class="btn">
        <a
          class="typeform-share button"
          href="https://agrivillage.typeform.com/to/VLYM39"
          data-mode="popup"
          data-size="100"
          target="_blank"
        >En savoir plus
        </a>
        <script type="application/javascript">(function() {var qs,js,q,s,d = document,gi = d.getElementById,ce = d.createElement,gt = d.getElementsByTagName,id = "typef_orm_share",b = "https://embed.typeform.com/";if (!gi.call(d, id)) {js = ce.call(d, "script");js.id = id;js.src = b + "embed.js";q = gt.call(d, "script")[0];q.parentNode.insertBefore(js, q);}})();
        </script>
      </div>

    </div>
  </div>
</template>

<script>
import 'jquery'
export default {
  name: 'GlampingHero',
  components: {},
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
.tiny-button {
  align-self: flex-end;
  margin-right: 30px;
  margin-bottom: 51px;
  width: auto;
  color: $agri-green;
  font-size: 18px;
  font-weight: 900;
  background-color: $tiny-beige;
  border: none;
  border-radius: 99.5px;
  padding: 12px 26px;
  text-align: center;
  cursor: pointer;
  @media only screen and (max-width: $breakpoint-tablet) {
    width: auto;
    font-size: 24px;
    margin: 0 auto 20px auto;
  }
  p {
    padding: 0;
    margin: 0;
  }
}

.button {
  /* background-color: #FFF9E6;
  font-size: 20px;
  padding: 14px 34px;
  border-radius: 99.5px; */
}

.title-all {
  font-size: 3.5vw;
  font-weight: 700;
  color: $tiny-beige;
  text-shadow: 0 0 7px rgba(0, 0, 0, 0.25);
  @media only screen and (max-width: $breakpoint-tablet) {
    font-size: 27px;
  }
}

.home-hero__image {
  display: flex;
  flex-direction: column;
}

.home-hero {
  min-height: 550px;
  width: 100%;
  background-color: $agri-grey;
  background-image: url("~assets/img/glamping/header.jpeg");
  background-size: cover;
  background-position: bottom;
  box-shadow: inset 0px -100px 140px 0px #0000008c;
  @media only screen and (max-width: $breakpoint-mobile-l) {
    padding: 0 16px;
  }
 .wrap {
    margin-top: 19%;
    margin-bottom: 4%;
    width: 80%;
    @media only screen and (max-width: $breakpoint-tablet) {
      margin-top: 97px;
    }
  }
}
</style>
