<template>
  <div class="wrapper_header">
    <div class="content">
      <h2 class="h_title">
        {{ $t("home.titles.discovery") }} {{ $parent.firstMeta }} {{ $t("home.titles.farmFr") }}
        <a class="test"/>
      </h2>
    </div>

  </div>
</template>

<script>
  export default {
    name: 'HomeHeader'
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";
  .test{
    height: 1.05em;
    width: 1.05em;
    background-position: center;
    background-repeat: no-repeat;
    background-size: contain;
    display: inline-block;
    vertical-align: middle;
    background-image: url("~assets/img/home/emoji.png");
  }
  .wrapper_header{
    padding-top: 30px;
    padding-bottom: 30px;
    background-color: #f7fcf2;
    .content{
      display: flex;
      flex-direction: row;
      justify-content: center;
      .image {
        height: 30px;
        width: 30px;
        margin-left: 10px;
        margin-top: 11px;
      }
    }
  }

  .h_title{
    font-size: 32px;
    font-weight: 500;
    margin: 8px 0;
    color: rgba(0, 0, 0, 0.76);
    text-align: center;
  }
  .h_subtitle{
    font-size: 20px;
    font-weight: 400;
    margin: 8px 0;
    color: rgba(0, 0, 0, 0.76);
    text-align: center;
  }
  @media only screen and (max-width: $breakpoint-tablet) {
    .content{
      flex-direction: column !important;
    }
    .image{
      width: 40px;
      align-self: center;
    }
  }
</style>
