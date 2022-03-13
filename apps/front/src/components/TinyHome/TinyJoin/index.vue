<template>
  <div class="container">
    <div class="carteTitle">
      <img
        :src="carte"
        alt="" >
      <p>{{ $t("tinyhouse.join.titleCarte") }}</p>
    </div>
    <div class="explain">
      <div class="title">
        {{ $t("tinyhouse.join.title") }}
      </div>
      <div class="content">
        <p>
          {{ $t("tinyhouse.join.content")[0] }}
          <br >
          <br >
          {{ $t("tinyhouse.join.content")[1] }}
          <br >
          <br >
          {{ $t("tinyhouse.join.content")[2] }}
          <br >
          <br >
          {{ $t("tinyhouse.join.content")[3] }}
        </p>
      </div>
      <div class="button">
        <a
          class="typeform-share button"
          href="https://qql4hcv3fo7.typeform.com/to/dicrq0QJ"
          data-mode="popup"
          style="display:inline-block;text-decoration:none;background-color:#FFF9E6;color:white;cursor:pointer;font-family:Helvetica,Arial,sans-serif;font-size:20px;line-height:50px;text-align:center;margin:0;height:50px;padding:0px 33px;border-radius:19px;max-width:100%;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;font-weight:bold;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;"
          data-size="70"
          target="_blank"
        >{{ $t("tinyhouse.join.button") }}</a
        >
        <script type="application/javascript"> (function() { var qs,js,q,s,d=document, gi=d.getElementById, ce=d.createElement, gt=d.getElementsByTagName, id='typef_orm_share', b='https://embed.typeform.com/'; if(!gi.call(d,id)){ js=ce.call(d,'script'); js.id=id; js.src=b+'embed.js'; q=gt.call(d,'script')[0]; q.parentNode.insertBefore(js,q) } })() </script>
      </div>
    </div>
  </div>
</template>

<script>
import carte from '@/assets/img/homeTiny/carte_france.png'
export default {
  name: 'TinyJoin',
  data () {
    return {
      carte
    }
  }
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
}
.container {
  background-color: $agri-green;
  height: auto;
  width: 100%;
  margin: 0;
  padding: 0;
  display: flex;
  @media only screen and (max-width: $breakpoint-tablet) {
    display: flex;
    flex-direction: column;
  }
  .carteTitle {
    width: 45%;
    text-align: center;
    @media only screen and (max-width: $breakpoint-tablet) {
      margin: 0 auto;
      width: 70%;
    }
    img {
      @media only screen and (max-width: $breakpoint-tablet) {
        width: 120px;
        height: 120px;
        margin-top: 25px;
      }
    }
    p {
      font-size: 14px;
      line-height: 17px;
      font-weight: 700;
      padding: 0 20px;
      color: $tiny-text;
    }
  }
  .explain {
    padding: 34px 12px 12px 12px;
    color: $tiny-beige;
    .title {
      color: $tiny-beige;
      font-size: 22px;
      font-weight: 900;
      line-height: 26px;
    }
    .content {
      font-size: 14px;
      line-height: 16px;
    }
    .button {
      display: flex;
      justify-content: center;
      margin-top: 30px;
      a {
        width: 272px;
        background-color: $tiny-beige;
        border: none;
        cursor: pointer;
        color: $agri-green !important;
        font-weight: 900;
        font-size: 20px;
        padding: 14px 34px;
        border-radius: 99.5px;
      }
    }
  }
}
</style>
