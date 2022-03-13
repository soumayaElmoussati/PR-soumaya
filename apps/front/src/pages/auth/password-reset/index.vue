<template>
  <div class="password-reset">
    <div class="wrap">
      <div class="side">
        <h1 class="title">
          {{ $t("becomeClient.buttons.resetPassword") }}
        </h1>
        <p class="body-1">
          {{ $t("becomeClient.paragraphes.reinitPassword") }}
        </p>

        <form
          @submit.prevent="submitted"
        >
          <wi-input
            v-validate="'required|min:6'"
            id="password"
            ref="password"
            v-model="formData.password"
            :disabled="$wait.is('updating password')"
            :error="errors.first('password')"
            data-vv-as="mot de passe"
            type="password"
            name="password"
            label="Nouveau mot de passe"
            autocomplete="new-password"
            required
          />

          <wi-input
            v-validate="'required|min:6|confirmed:password'"
            id="passwordConfirmation"
            v-model="formData.passwordConfirmation"
            :disabled="$wait.is('updating password')"
            :error="errors.first('passwordConfirmation')"
            data-vv-as="confirmation"
            type="password"
            name="passwordConfirmation"
            label="Confirmation mot de passe"
            autocomplete="new-password"
            required
          />

          <button
            :disabled="$wait.is('updating password')"
            type="submit"
            class="btn btn-primary"
          >
            <span
              v-if="!$wait.is('updating password')"
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
  export default {
    name: 'PasswordReset',
    validate ({ route }) {
      return route.query['access-token'] && route.query['client']
    },
    data () {
      return {
        formData: {
          password: null,
          passwordConfirmation: null
        }
      }
    },
    head () {
      return {
        title: 'Réinitialiser le mot de passe',
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
        const headers = {
          'Access-Token': this.$route.query['access-token'],
          Client: this.$route.query['client'],
          Uid: this.$route.query['uid']
        }

        this.$validator.validateAll()
          .then(valid => {
            if (valid) {
              this.$wait.start('updating password')
              this.$axios.put('/auth/password', {
                password: this.formData.password,
                password_confirmation: this.formData.passwordConfirmation
              }, {
                headers
              })
                .then(() => {
                  this.$toast.success({
                    title: 'Mot de passe modifié',
                    message: 'Votre mot de passe a bien été modifié. Reconnectez-vous.',
                    position: 'bottom center',
                    timeOut: 8000
                  })

                  this.$router.push({
                    name: 'SignIn'
                  })
                })
                .catch(err => {
                  console.error('Error', err)
                  this.$toast.error({
                    title: 'Mot de passe',
                    message: 'Une erreur est survenue lors de la modification de votre mot de passe. Réessayez plus tard.',
                    position: 'bottom center',
                    timeOut: 8000
                  })
                })
                .finally(() => this.$wait.end('updating password'))
            }
          })
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .password-reset{
    padding: 64px 0;

    .wrap{
      display: flex;
      justify-content: space-between;

      @media only screen and (max-width: $breakpoint-laptop-m) {
        flex-direction: column;
      }

      .wi-input:first-child {
        margin-bottom: 16px;
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
