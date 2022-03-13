<template>
  <div class="container">
    <div class="deco">
      <img
        :src="deco"
        alt="">
    </div>
    <div class="content">
      <div class="title">
        <h3> {{ $t("companySeminar.Mission.title") }}</h3>
      </div>
      <div class="text">
        <div>
          <p> {{ $t("companySeminar.Mission.paragraph")[0] }} </p>
          <ul>
            <li> {{ $t("companySeminar.Mission.lists")[0] }} </li>
            <li> {{ $t("companySeminar.Mission.lists")[1] }} </li>
            <li> {{ $t("companySeminar.Mission.lists")[2] }} </li>
            <li> {{ $t("companySeminar.Mission.lists")[4] }} </li>
          </ul>
        </div>
        <div>
          <p> {{ $t("companySeminar.Mission.paragraph")[1] }}  </p>
          <ul>
            <li> {{ $t("companySeminar.Mission.lists")[5] }} </li>
            <li> {{ $t("companySeminar.Mission.lists")[6] }} </li>
            <li> {{ $t("companySeminar.Mission.lists")[7] }} </li>
            <li> {{ $t("companySeminar.Mission.lists")[8] }} </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import deco from '@/assets/img/companySeminar/deco/deco1.png'
export default {
  name: 'Mission',
  data () {
    return {
      deco
    }
  }
}
</script>
<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
* {
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
}
.deco {
  position: absolute;
  -webkit-position: absolute;
  img {
    width: 17vw;
    -webkit-width: 17vw;
  }
}
.content {
  width: 95%;
  margin: auto;
  padding-top: 10vw;
  margin-bottom: 4%;
  -webkit-width: 95%;
  -webkit-margin: auto;
  -webkit-padding-top: 10vw;
  -webkit-margin-bottom: 4%;
  .title {
    h3 {
      color: #417267;
      font-size: 36px;
      margin-top: auto;
      font-style: normal;
      font-weight: bold;
      text-transform: uppercase;
      -webkit-color: #417267;
      -webkit-font-size: 36px;
      -webkit-margin-top: auto;
      -webkit-font-style: normal;
      -webkit-font-weight: bold;
      -webkit-text-transform: uppercase;
    }
  }
  .text {
    display: grid;;
    grid-template-columns: 45% 45%;
    justify-content: space-around;
    color: #514040;
    -webkit-display: grid;;
    -webkit-grid-template-columns: 45% 45%;
    -webkit-justify-content: space-around;
    -webkit-color: #514040;
    @media only screen and (max-width: $breakpoint-tablet) {
      grid-template-columns: auto;
      -webkit-grid-template-columns: auto;
    }
    p {
      margin-bottom: auto;
      font-size: 18px;
      font-weight: normal;
      line-height: 22px;
      font-weight: bold;
      color: #417266;
      -webkit-margin-bottom: auto;
      -webkit-font-size: 18px;
      -webkit-font-weight: normal;
      -webkit-line-height: 22px;
      -webkit-font-weight: bold;
      -webkit-color: #417266;
    }
    ul {
      margin-top: auto;
      -webkit-margin-top: auto;
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
</style>
