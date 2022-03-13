<template>
  <div class="container">
    <div class="content">
      <div class="deco">
        <img
          :src="deco7"
          alt="">
      </div>
      <div class="title">
        <h3> Nos partenaires </h3>
      </div>
      <div class="card">
        <div class="logo chase">
          <img
            :src="logo1"
            alt="">
        </div>
        <div class="logo asana">
          <img
            :src="logo2"
            alt="">
        </div>
        <div class="logo google">
          <img
            :src="logo3"
            alt="">
        </div>
        <div class="logo buzzfeed">
          <img
            :src="logo4"
            alt="">
        </div>
        <div class="logo walmart">
          <img
            :src="logo5"
            alt="">
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import logo1 from '@/assets/img/companySeminar/logo/chase.png'
import logo2 from '@/assets/img/companySeminar/logo/asana.png'
import logo3 from '@/assets/img/companySeminar/logo/google.png'
import logo4 from '@/assets/img/companySeminar/logo/buzzfeed.png'
import logo5 from '@/assets/img/companySeminar/logo/walmart.png'
import deco7 from '@/assets/img/companySeminar/deco/deco7.png'
export default {
  name: 'Partner',
  data () {
    return {
      logo1,
      logo2,
      logo3,
      logo4,
      logo5,
      deco7
    }
  }
}
</script>
<style lang="scss" scoped>
@import '@/assets/scss/_variables.scss';
.deco {
  right: 0px;
  position: absolute;
  -webkit-right: 0px;
  -webkit-position: absolute;
  img {
    width: 8vw;
    -webkit-width: 8vw;
  }
}
.content {
  margin: 4%;
  margin-top: 10%;
  margin-bottom: 10%;
  -webkit-margin: 4%;
  -webkit-margin-top: 10%;
  -webkit-margin-bottom: 10%;
  .title {
    text-align: center;
    -webkit-text-align: center;
  }
  .card {
    display: flex;
    justify-content: space-around;
    align-items: center;
    -webkit-display: flex;
    -webkit-justify-content: space-around;
    -webkit-align-items: center;
    @media only screen and (max-width: $breakpoint-tablet) {
      flex-direction: column;
      text-align: center;
      -webkit-flex-direction: column;
      -webkit-text-align: center;
    }
  }
}
</style>
