<template>
  <div class="app-header-subnav">
    <app-header-user
    />
    <div
      v-if="!$auth.loggedIn"
      class="app-header-subnav__buttons"
    >
      <img
        src="~assets/img/home/flag.jpg"
        alt="france"
        title="france"
        class="image">
      <button
        type="button"
        class="btn connect-btn"
        @click="showModal"
      >
        {{ $t('global.header.becomeClient') }}
      </button>

      <button
        type="button"
        class="btn btn-primary become-btn"
        @click="goSignIn">
        {{ $t("global.header.becomeHost") }}
      </button>

      <modal
        v-show="isModalVisible"
        @closeModal="closeModal"
      />
    </div>
  </div>
</template>

<script>
  import AppHeaderUser from './_subs/AppHeaderUser'
  import Modal from '@/components/Modal.vue'

  export default {
    name: 'AppHeaderSubnav',
    components: {
      AppHeaderUser, Modal
    },
    data () {
      return {
        isModalVisible: false
      }
    },
    methods: {
      goSignIn () {
        this.$router.push({
          name: 'SignIn'
        })
      },
      login () {
        this.$parent.$parent.expl = false
      },
      showModal () {
        this.isModalVisible = true
      },
      closeModal () {
        this.isModalVisible = false
      }
    }
  }
</script>

<style lang="scss" scoped>
  .app-header-subnav{
    display: flex;

    .btn,
    &__buttons{
      margin: auto 0;
    }

    &__buttons{
      display: flex;

      .btn {
        min-height: 40px;
        line-height: 40px;
        font-size: 16px;
        margin-right: 16px;
        color: white;
      }

      .become-btn {
        background-color: #79BC53;
        color: white;
        padding: 0px 15px;
        border-radius: 50px;
        font-size: 12px;
        font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
      }

      .connect-btn {
        border: 1px solid #79BC53;
        color: #79BC53;
        padding: 0px 15px;
        border-radius: 50px;
        font-size: 12px;
        font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
      }

    }
  }

  .image {
    height: 30px;
    width: 30px;
    align-self: center;
    margin-right: 20px;
    border-radius: 50%;
  }
  .btn-primary{
    margin-left: 20px;
  }
</style>
