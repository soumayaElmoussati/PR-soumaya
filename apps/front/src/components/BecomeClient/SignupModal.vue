<template>
  <transition name="modal-fade">
    <div class="modal-backdrop">
      <div
        class="modal"
        role="dialog"
        aria-labelledby="modalTitle"
        aria-describedby="modalDescription">
        <header
          id="modalTitle"
          class="modal-header">
          <slot name="header">

            <img
              src="@/assets/img/auth/banner.png"
              class="modal-banner"
              alt="auth">

            <button
              type="button"
              class="btn-close"
              aria-label="Close modal"
              @click="close"
            >
              x
            </button>

          </slot>
        </header>
        <section
          id="modalDescription"
          class="modal-body">
          <slot name="body">

            <sign-up-form />

          </slot>
        </section>
      </div>
    </div>
  </transition>
</template>

<script>
import SignUpForm from '@/components/BecomeClient/BecomeClientSignIn'

export default {
    name: 'SignUpModal',
    components: {
        SignUpForm
    },
    data () {
        return {

        }
    },
    methods: {
        close () {
            this.$emit('close')
        }
    }
  }
</script>

<style>

.banner-title {
    color: #476458;
    font-size: 20px;
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
    text-transform: uppercase;
    font-weight: bold;
}

.modal-banner {
    width: 100%;
    height: 100%;
}

.modal-fade-enter,
.modal-fade-leave-active {
    opacity: 0;
}

.modal-fade-enter-active,
.modal-fade-leave-active {
    transition: opacity .5s ease
}

.modal-backdrop {
    position: fixed;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    background-color: rgba(0, 0, 0, 0.3);
    display: flex;
    justify-content: center;
    align-items: center;
}

.modal {
    background: #FFFFFF;
    box-shadow: 2px 2px 20px 1px;
    overflow-x: auto;
    display: flex;
    flex-direction: column;
    padding: none !important;
    border-radius: 10px;
    max-width: 450px;
}

.modal-calendar {
    background: #FFFFFF;
    box-shadow: 2px 2px 20px 1px;
    overflow-x: auto;
    display: flex;
    flex-direction: column;
    padding: none !important;
    border-radius: 10px;
    max-width: 400px;
    padding: 25px;
}

.modal-header,
.modal-footer {
    display: flex;
}

.modal-header {
    justify-content: space-between;
    height: 120px;
    width: 450px;
}

.modal-body {
    position: relative;
    padding: 20px 10px;
}

</style>
