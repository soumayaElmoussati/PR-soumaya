<template>
  <div class="container">
    <div class="content">
      <div class="title">
        <h3> {{ $t('companySeminar.Reserve.title') }} </h3>
      </div>
      <div class="text">
        <div class="card">
          <p class="number"> 1 </p>
          <div class="content-text">
            <h4> {{ $t('companySeminar.Reserve.subtitle')[0] }} </h4>
            <p> {{ $t('companySeminar.Reserve.paragraphs')[0] }} </p>
          </div>
        </div>
        <div class="card card-bas">
          <p class="number"> 2 </p>
          <div class="content-text">
            <h4> {{ $t('companySeminar.Reserve.subtitle')[1] }} </h4>
            <p> {{ $t('companySeminar.Reserve.paragraphs')[1] }} </p>
          </div>
        </div>
        <div class="card">
          <p class="number"> 3 </p>
          <div class="content-text">
            <h4> {{ $t('companySeminar.Reserve.subtitle')[2] }} </h4>
            <p> {{ $t('companySeminar.Reserve.paragraphs')[2] }} <br>
              {{ $t('companySeminar.Reserve.paragraphs')[3] }} </p>
          </div>
        </div>
        <div class="card card-bas">
          <p class="number"> 4 </p>
          <div class="content-text">
            <h4> {{ $t('companySeminar.Reserve.subtitle')[3] }} </h4>
            <p> {{ $t('companySeminar.Reserve.paragraphs')[4] }} </p>
          </div>
        </div>

      </div>

      <br>

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
</template>
<script>
import deco6 from '@/assets/img/companySeminar/deco/deco6.png'
export default {
  name: 'Reserve',
  data () {
    return {
      deco6
    }
  }
}
</script>
<style lang="scss" scoped>
@import '@/assets/scss/_variables.scss';
* {
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
}
.content {
  margin: 3%;
  -webkit-margin: 3%;
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
.text {
  display: grid;
  grid-template-columns: 22% 22% 22% 22%;
  justify-content: space-between;
  -webkit-display: grid;
  -webkit-grid-template-columns: 22% 22% 22% 22%;
  -webkit-justify-content: space-between;
  @media only screen and (max-width: $breakpoint-tablet) {
    display: contents;
    -webkit-display: contents;
  }
  .card {
    width: 100%;
    height: max-content;
    background-color: #417267;
    color: white;
    -webkit-width: 100%;
    -webkit-height: max-content;
    -webkit-background-color: #417267;
    -webkit-color: white;
    @media only screen and (max-width: $breakpoint-tablet) {
      margin: auto;
      width: 50%;
      -webkit-margin: auto;
      -webkit-width: 50%;
    }
    @media only screen and (max-width: $breakpoint-mobile-large) {
      width: 90%;
      -webkit-width: 90%;
    }
  }
  .card-bas {
    margin-top: 4vw;
    -webkit-margin-top: 4vw;
  }
  .number {
    width: auto;
    margin: auto;
    padding-right: 3vw;
    font-size: 5em;
    text-align: end;
    font-weight: bold;
    color: #FFFFFF;
    text-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
    -webkit-width: auto;
    -webkit-margin: auto;
    -webkit-padding-right: 3vw;
    -webkit-font-size: 5em;
    -webkit-text-align: end;
    -webkit-font-weight: bold;
    -webkit-color: #FFFFFF;
    -webkit-text-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
  }
  .content-text {
    margin-left: 2vw;
    margin-right: 2vw;
    margin-bottom: 2vw;
    color: #FFFFFF;
    font-weight: normal;
    -webkit-margin-left: 2vw;
    -webkit-margin-right: 2vw;
    -webkit-margin-bottom: 2vw;
    -webkit-color: #FFFFFF;
    -webkit-font-weight: normal;-webkit-
    h4 {
      font-size: 1.8em;
      margin: auto;
      -webkit-font-size: 1.8em;
      -webkit-margin: auto;
    }
    p {
      font-size: 1em;
      padding-bottom: 2vw;
      -webkit-font-size: 1em;
      -webkit-padding-bottom: 2vw;
    }
  }
}
</style>
