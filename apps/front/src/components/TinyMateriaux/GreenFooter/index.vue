<template>
  <div class="container">
    <div class="logos">
      <div class="logo1">
        <img
          :src="logo1"
          alt="" >
        <p>
          {{ $t("materiauxTiny.paragraphs.equipped") }}
        </p>
      </div>
      <div class="logo2">
        <img
          :src="logo2"
          alt="" >
        <p>
          {{ $t("materiauxTiny.paragraphs.comfort") }}
        </p>
      </div>
      <div class="logo3">
        <img
          :src="logo3"
          alt="" >
        <p>
          {{ $t("materiauxTiny.paragraphs.disconnected") }}
        </p>
      </div>
    </div>
  </div>
</template>

<script>
import logo1 from '@/assets/img/materiauxTiny/Icone tout équipé.png'
import logo2 from '@/assets/img/materiauxTiny/detente.png'
import logo3 from '@/assets/img/materiauxTiny/smart-home 1.png'
export default {
  name: 'GreenFooter',
  data () {
    return {
      logo1,
      logo2,
      logo3
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
.container {
  min-height: 425px !important;
  background-image: url("~assets/img/materiauxTiny/Fond_vert.png");
  background-repeat: no-repeat;
  background-size: cover;
  @media only screen and (max-width: $breakpoint-tablet) {
    min-height: 876px !important;
  }
  .logos {
    padding-top: 80px;
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    @media only screen and (max-width: $breakpoint-tablet) {
      display: flex;
      flex-direction: column;
    }
    .logo1,
    .logo2,
    .logo3 {
      display: flex;
      flex-direction: column;
      justify-content: center;
      @media only screen and (max-width: $breakpoint-tablet) {
        margin-bottom: 28px;
      }
      img {
        width: 130px;
        height: 135px;
        margin: 0 auto;
      }
    }
    p {
      width: 50%;
      margin: 0 auto;
      color: #fff9e6;
      text-align: center;
      margin: 12px auto 0 auto;
      font-size: 22px !important;
      font-style: italic;
      font-weight: 400;
      @media only screen and (max-width: $breakpoint-tablet) {
        font-size: 14px;
        font-weight: 500;
        width: 100%;
      }
    }
  }
}
</style>
