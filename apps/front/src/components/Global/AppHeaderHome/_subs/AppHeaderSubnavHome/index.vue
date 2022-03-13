<template>
  <div class="app-header-subnav">
    <app-header-user-home />
    <div
      v-if="!$auth.loggedIn"
      class="app-header-subnav__buttons">
      <img
        src="~assets/img/home/flag.jpg"
        alt="france"
        title="france"
        class="image"
      >
      <button
        type="button"
        class="btn connect-btn"
        @click="showModal">
        {{ $t("global.header.becomeClient") }}
      </button>
      <button
        type="button"
        class="btn btn-primary become-btn"
        @click="goSignIn">
        {{ $t("global.header.becomeHost") }}
      </button>
      <modal
        v-show="isModalVisible"
        id="modal"
        @closeModal = "closeModal" />
    </div>
  </div>
</template>

<script>
import AppHeaderUserHome from './_subs/AppHeaderUserHome'
import Modal from '@/components/Modal'

export default {
  name: 'AppHeaderSubnavHome',
  components: {
    AppHeaderUserHome,
    Modal
  },
  data () {
    return {
      isModalVisible: false
    }
  },
  mounted () {
    // this.closeModalFunction()
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
    closeModal (value) {
      this.isModalVisible = value
    },
    closeModalFunction () {
      let modal = document.querySelector('#modal')
      modal.addEventListener('click', event => {
        if (event.target === modal) {
          document.querySelector('#modal').style.display = 'none'
          this.isModalVisible = false
        } else {
        }
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.app-header-subnav {
  display: flex;

  .btn,
  &__buttons {
    margin: auto 0;
  }

  &__buttons {
    display: flex;

    .btn {
      min-height: 40px;
      line-height: 40px;
      font-size: 16px;
      margin-right: 16px;
      color: white;
    }

    .become-btn {
      background-color: #79bc53;
      color: white;
      padding: 0px 15px;
      border-radius: 50px;
      font-size: 12px;
      font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
        Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    }

    .connect-btn {
      border: 1px solid #79bc53;
      color: #79bc53;
      padding: 0px 15px;
      border-radius: 50px;
      font-size: 12px;
      font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
        Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
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
.btn-primary {
  margin-left: 20px;
}
</style>
