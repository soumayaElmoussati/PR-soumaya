<template>
  <div class="b-wrapper">
    <a
      class="btn btn-primary btn-outline"
      style="width: 300px;margin-left: auto;margin-right: auto;margin-bottom: 20px;"
      href="../nos-offres">{{ $t('search.all_offers') }}</a>
    <a
      class="typeform-share button btn btn-primary"
      href="https://adriengabillet.typeform.com/to/MR3CzF"
      data-mode="popup"
      style="width: 300px;margin-left: auto;margin-right: auto;background-color: #312A82;height: fit-content;"
      target="_blank">{{ $t('search.no_offers') }}</a>
    <script type="application/javascript"> (function() { var qs,js,q,s,d=document, gi=d.getElementById, ce=d.createElement, gt=d.getElementsByTagName, id='typef_orm_share', b='https://embed.typeform.com/'; if(!gi.call(d,id)){ js=ce.call(d,'script'); js.id=id; js.src=b+'embed.js'; q=gt.call(d,'script')[0]; q.parentNode.insertBefore(js,q) } })() </script>
  </div>
</template>

<script>

  export default {
    name: 'OffersBtns'
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .b-wrapper{
    margin-top: 60px;
    display: grid;
    grid-template-columns: auto auto;
    @media only screen and (max-width: $breakpoint-tablet) {
      grid-template-columns: auto;
    }
  }

  .typeform-share:hover{
    background-color: #1d1852 !important;
  }

  .e-title{
    color: #262626;
    font-weight: 500;
    font-size: 30px;
    border-bottom: 1px solid #dcdcdc;
    padding-left: 15%;
    padding-bottom: 30px;
  }
  .e_icon {
    width: 70%;
    margin-left: auto;
    margin-right: auto;
    display: block;
  }
  .e-text{
    font-weight: 400;
    text-align: center;
    margin-top: 50px;
    width: 70%;
    display: block;
    margin-left: auto;
    margin-right: auto;
    margin-bottom: 80px;
  }
</style>
