<template>
  <div class="error-view">
    <div class="wrap">
      <img
        v-if="error.statusCode === 404"
        src="~/assets/img/error/not-found.svg"
        width="300"
        alt=""
      >
      <h1 class="title">
        Erreur {{ error.statusCode }}
      </h1>
      <h2 class="headline">
        {{ error.message }}
      </h2>
      <nuxt-link to="/">
        Retourner à l'accueil
      </nuxt-link>
    </div>
  </div>
</template>

<script>
  export default {
    props: {
      error: {
        type: Object,
        default: null
      }
    }
  }
</script>

<style lang="scss" scoped>
  .error-view {
    text-align: center;
    min-height: 80vh;
    padding-top: 64px;

    .title{
      margin-top: 32px;
    }
  }
</style>
