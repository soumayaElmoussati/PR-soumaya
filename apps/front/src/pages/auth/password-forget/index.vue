<template>
  <div class="password-forget">
    <div class="wrap">
      <div class="side">
        <h1 class="title">
          {{ $t("becomeClient.buttons.forgot_password") }}
        </h1>
        <p class="body-1">
          {{ $t("becomeClient.paragraphes.reinit") }}
        </p>
        <p class="body-1">
          {{ $t("becomeClient.paragraphes.spam") }}
        </p>
        <form @submit.prevent="submitted">
          <wi-input
            v-validate="'required|email'"
            id="email"
            v-model="formData.email"
            :disabled="$wait.is('resetting password')"
            :error="errors.first('email')"
            type="email"
            name="email"
            label="E-mail"
            caption="E-mail utilisé lors de votre inscription"
            required
            autocomplete="email"
          />

          <button
            :disabled="$wait.is('resetting password')"
            type="submit"
            class="btn btn-primary"
          >
            <span
              v-if="!$wait.is('resetting password')"
            >
              {{ $t("becomeClient.buttons.reset") }}
            </span>
            <wi-spinner
              v-else
            />
          </button>
        </form>
      </div>
      <div class="password-forget__illustration">
        <img
          src="~/assets/img/auth/password.svg"
          alt=""
          width="400"
        >
      </div>
    </div>
  </div>
</template>

<script>
  /**
   * @module view - passwordForget
   */
  export default {
    name: 'PasswordForget',
    data () {
      return {
        formData: {
          email: null
        }
      }
    },
    head () {
      return {
        title: 'Mot de passe oublié?',
        meta: [
          {
            hid: 'robots',
            name: 'robots',
            content: 'noindex'
          }
        ]
      }
    },
    methods: {
      submitted () {
        this.$validator.validateAll()
          .then(valid => {
            if (valid) {
              this.$wait.start('resetting password')
              this.$axios.post('/auth/password', {
                email: this.formData.email,
                redirect_url: `${process.env.FRONT_DOMAIN}/auth/password/reset`
              })
                .then(res => {
                  this.$toast.success({
                    title: 'E-mail envoyé',
                    message: `Un e-mail vous a été envoyé à ${this.formData.email}.`,
                    position: 'bottom center',
                    timeOut: 8000
                  })
                })
                .catch(() => {
                  this.$toast.error({
                    title: 'E-mail non existant',
                    message: 'L\'email que vous avez spécifié n\'existe pas dans notre base de donnée.',
                    position: 'bottom center',
                    timeOut: 8000
                  })
                })
                .finally(() => this.$wait.end('resetting password'))
            }
          })
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .password-forget{
    padding: 64px 0;

    .wrap{
      display: flex;
      justify-content: space-between;

      @media only screen and (max-width: $breakpoint-laptop-m) {
        flex-direction: column;
      }
    }

    .side{
      width: 50%;

      @media only screen and (max-width: $breakpoint-laptop-m) {
        width: 100%;
        padding: 0 16px;
      }

      .btn {
        margin-top: 32px;
      }
    }

    &__illustration {
      padding: 32px;

      @media only screen and (max-width: $breakpoint-tablet) {
        width: 100%;

        img{
          width: 100%;
        }
      }
    }

  }
</style>
