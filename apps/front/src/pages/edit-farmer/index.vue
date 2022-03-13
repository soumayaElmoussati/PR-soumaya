<template>
  <div class="edit-offer">

    <div class="wrap">
      <div class="side">
        <nuxt />
      </div>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    name: 'EditFarmer',
    components: {
    },
    fetch ({ app, route, store }) {
      return app.$axios.get(`/farmers/${route.params.id}`)
        .then(res => {
          if (res.status === 200) {
            store.commit('SET_CURRENT_FARMER', res.data)
          }
        })
    },

    computed: {
      ...mapGetters([
        'getCurrentFarmer'
      ])
    }
  }
</script>

<style lang="scss" scoped>
  .edit-offer{
    .wrap{
      display: flex;
    }

    .side{
      width: 100%;
      min-height: 850px;
      @media screen and (max-width: 768px) {
        width: 100%;
      }
    }

    &__menu {
      width: 200px;
      margin-top: 10px;
      @media screen and (max-width: 768px) {
        display: none;
      }

      ul,
      li {
        list-style-type: none;
        margin: 0;
        padding: 0;
        padding-top: 15px;
      }

      ul {
        display: flex;
        flex-direction: column;
      }
    }
  }

  @media screen and (max-width: 768px) {
    .edit-offer{

      .side{
        width: 100%;
      }

      &__menu {
        display: none;
      }
    }
  }
</style>
