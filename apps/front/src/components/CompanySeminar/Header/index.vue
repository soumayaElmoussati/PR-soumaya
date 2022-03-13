<template>
  <div class="container">
    <div class="head">
      <div class="content">
        <h1> {{ $t("companySeminar.Headers.title") }} </h1>
        <h2> {{ $t("companySeminar.Headers.subtitle") }} </h2>
        <div class="btn-link">
          <div>
            <div class="btn">
              <a
                style="all:unset;font-family:Helvetica,Arial,sans-serif;display:inline-block;max-width:100%;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;background-color:#417266;color:#ffffff;font-size:18px;border-radius:8px;padding:0 30px;font-weight:bold;height:45px;cursor:pointer;line-height:45px;text-align:center;margin:0;text-decoration:none;"
                href="https://agrivillage.typeform.com/to/D06Lp5"
                data-mode="popup"
                data-size="100"
                target="_blank"
              >
                {{ $t("companySeminar.Headers.button") }}
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: 'Header'
}
</script>
<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
* {
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
}
.head {
  background-image: url('~assets/img/companySeminar/Bg.png');
  background-repeat: no-repeat;
  background-size: cover;
  width: 100%;
  height: 75vh;
  -webkit-background-repeat: no-repeat;
  -webkit-background-size: cover;
  -webkit-width: 100%;
  -webkit-height: 75vh;
  .content {
    text-align: center;
    color: white;
    position: absolute;
    width: 100%;
    top: 25%;
    -webkit-text-align: center;
    -webkit-color: white;
    -webkit-position: absolute;
    -webkit-width: 100%;
    -webkit-top: 25%;
    h1 {
      font-size: 3vw;
      font-weight: normal;
      width: 80%;
      margin: auto;
      -webkit-font-size: 3vw;
      -webkit-font-weight: normal;
      -webkit-width: 80%;
      -webkit-margin: auto;
      @media only screen and (max-width: $breakpoint-tablet) {
        font-size: 5vw;
        -webkit-font-size: 5vw;
      }
      @media only screen and (max-width: $breakpoint-mobile-large) {
        font-size: 7vw;
        -webkit-font-size: 7vw;
      }
    }
    h2 {
      font-size: 2vw;
      font-weight: normal;
      font-style: italic;
      -webkit-font-size: 2vw;
      -webkit-font-weight: normal;
      -webkit-font-style: italic;
      @media only screen and (max-width: $breakpoint-tablet) {
        font-size: 3vw;
        -webkit-font-size: 3vw;
      }
      @media only screen and (max-width: $breakpoint-mobile-large) {
        font-size: 5vw;
        -webkit-font-size: 5vw;
      }
    }
  }
}
</style>
