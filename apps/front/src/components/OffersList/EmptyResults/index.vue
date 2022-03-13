<template>
  <div class="empty-box">
    <h1 class="e-title">{{ $t('search.empty.no_offer') }}</h1>
    <img
      src="~assets/img/home/empty-results.svg"
      alt="empty"
      class="e_icon">
    <h3 class="e-text body-1">
      {{ $t('search.empty.sorry')[0] }} <br>
      {{ $t('search.empty.sorry')[1] }} <br>
      {{ $t('search.empty.sorry')[2] }}
    </h3>
    <nuxt-link
      :to="{
        name: 'OffersAll'
      }"
      style="width: 300px;margin-left: auto;margin-right: auto;margin-bottom: 20px;"
      class="btn btn-light"
    >
      {{ $t('search.all_offers') }}
    </nuxt-link>
    <a
      class="typeform-share button btn btn-become"
      href="https://adriengabillet.typeform.com/to/MR3CzF"
      data-mode="popup"
      style="width: 300px;margin-left: auto;margin-right: auto;margin-bottom: 20px"
      target="_blank">{{ $t('search.no_offers') }}</a>
    <script type="application/javascript"> (function() { var qs,js,q,s,d=document, gi=d.getElementById, ce=d.createElement, gt=d.getElementsByTagName, id='typef_orm_share', b='https://embed.typeform.com/'; if(!gi.call(d,id)){ js=ce.call(d,'script'); js.id=id; js.src=b+'embed.js'; q=gt.call(d,'script')[0]; q.parentNode.insertBefore(js,q) } })() </script>
  </div>
</template>

<script>

  export default {
    name: 'EmptyResults'
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .empty-box {
    margin-left: 15%;
    width: 80%;
  }

  .e-title{
    color: #262626;
    font-weight: 500;
    font-size: 30px;
    border-bottom: 1px solid #dcdcdc;
    padding-bottom: 30px;
    margin-top: 70px;
    text-align: center;
  }
  .e_icon {
    width: 50%;
    max-width: 366px;
    @media only screen and (max-width: 450px) {
      width: 60% !important;
    }
    margin-left: auto;
    margin-right: auto;
    margin-top: 80px;
    display: block;
  }
  .e-text{
    font-weight: 400;
    text-align: center;
    margin-top: 50px;
    width: 100%;
    display: block;
    margin-left: auto;
    margin-right: auto;
    margin-bottom: 80px;
  }
</style>
