<template>
  <div class="home-hero">
    <div class="home-hero__image h_small">
      <div class="wrap">
        <div
          class="title-container">
          <h1
            class="title title-all"
            style="display: inline; width: 600px; line-height: 82px; font-size: 70px"
          >
            {{ $t("conceptTiny.hero.title") }}
          </h1>
          <p
            style="margin-top: 113px; font-weight: 900; width: 600px"
            class="title title-all"
          >
            {{ $t("conceptTiny.hero.content") }}
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ConceptHero'
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
* {
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}
.title-container {
  margin-left: 122px;
  width: 50%;
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 100% !important;
    margin-left: 10px;
  }
  h1 {
    @media only screen and (max-width: $breakpoint-tablet) {
      line-height: 42px !important;
    }
  }
  p {
    @media only screen and (max-width: $breakpoint-tablet) {
      font-size: 24px !important;
      font-weight: 400 !important;
    }
  }
}
.title-all {
  font-size: 70px;
  font-weight: 900;
  color: $agri-white !important;
  text-shadow: 0 0 7px rgba(0, 0, 0, 0.25);
  margin-bottom: 15px !important;
  @media only screen and (max-width: $breakpoint-tablet) {
    display: block;
    width: 100% !important;
  }
}
@media only screen and (max-width: $breakpoint-tablet) {
  .home-hero-titles {
    margin-right: 10px !important;
    margin-left: 10px !important;
  }
}
@media only screen and (max-width: 500px) {
  .home-hero-titles {
    display: flex !important;
    flex-direction: column !important;
  }
}
.home-hero__image {
  display: flex;
  flex-direction: column;
  box-shadow: inset 0px -100px 140px 0px #0000008c;
}
.home-hero-titles {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-column-gap: 30px;
  margin-right: 100px;
  margin-left: 100px;
  margin-bottom: 20px;
  .hh-sub {
    text-align: center;
    h2 {
      margin: 0px;
      font-size: 20px;
      font-weight: 500;
      margin: 12px 0;
      color: white;
    }
    h3 {
      margin: 0px;
      font-size: 15px;
      font-weight: 400;
      margin: 12px 0;
      color: white;
    }
  }
}
.home-hero {
  display: flex;
  flex-direction: column;
  display: -webkit-box;
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 100% !important;
  }
  h1,
  h2,
  h3 {
    user-select: none;
  }
  & > .wrap {
    display: flex;
    height: 100%;
    flex: 1;
    @media only screen and (max-width: $breakpoint-tablet) {
      padding: 0 16px;
    }
  }
  h1 {
    display: flex;
    flex-direction: column;
    color: white;
    margin: auto 0;
  }
  &__image {
    display: flex;
    min-height: 550px;
    width: 100%;
    background-color: $agri-grey;
    background-image: url("~assets/img/conceptTiny/hero1.png");
    background-size: cover;
    background-position: center;
    @media only screen and (max-width: $breakpoint-mobile-l) {
      padding: 0 16px;
    }
    .wrap {
      height: 100%;
      margin: auto;
      margin-top: 272px;
      @media only screen and (max-width: $breakpoint-tablet) {
        margin-top: 150px;
        margin-left: 12px;
      }
      .title {
        font-size: 36px;
        position: relative;
        font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
          Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
        @media only screen and (max-width: $breakpoint-tablet) {
          line-height: 40px;
          font-size: 36px !important;
        }
      }
    }
  }
  &__content {
    background-color: $primary;
    color: white;
    padding: 32px 0;
    @media only screen and (max-width: $breakpoint-mobile-l) {
      padding: 32px 16px;
    }
    .wrap {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      grid-gap: 16px;
      @media only screen and (max-width: $breakpoint-tablet) {
        grid-template-columns: 1fr;
      }
      .body-1 {
        color: rgba(white, 0.7);
      }
      .headline {
        color: white;
      }
    }
  }
}
@media only screen and (max-width: $breakpoint-mobile-l) {
  .wrap {
    width: 90%;
  }
  .buttons {
    display: flex;
    justify-content: center;
  }
  .title {
    margin-right: 0px !important;
    justify-content: start !important;
  }
}
@media only screen and (max-width: $breakpoint-tablet) {
  .image-container {
    background-position-x: -200px !important;
  }
}
.h_small {
  min-height: 903px !important;
}
@media only screen and (max-width: $breakpoint-tablet) {
  .h_small {
    min-height: 735px !important;
  }
}
</style>
