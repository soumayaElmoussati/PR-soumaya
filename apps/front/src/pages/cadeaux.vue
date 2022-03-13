<template>
  <div class="blog-container">
    <div class="wrap">
      <div class="content">
        <h1 class="title">
          {{ $t("cadeaux.titles.redirection") }}
        </h1>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'Cadeaux',
    middleware ({ redirect }) {
      return redirect('https://cadeaux.agrivillage.fr/')
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .blog-container{
    min-height: 100vh;

    .content{
      text-align: center;
      width: 50%;
      margin: auto;
      padding-top: 32px;

      @media only screen and (max-width: $breakpoint-tablet) {
        width: 100%;
      }

      @media only screen and (max-width: $breakpoint-mobile-l) {
        padding: 32px 16px 0 16px;
      }
    }

    h1{
      font-size: 32px;
      font-weight: 400;
      color: $primary;
    }
  }
</style>
