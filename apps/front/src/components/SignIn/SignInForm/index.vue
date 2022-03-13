<template>
  <div>
    <form
      class="sign-in-form"
      @submit.prevent="submitted">
      <div class="sign-in-form__fields">
        <wi-input
          v-validate="'required|email'"
          id="email"
          :disabled="$wait.is('signing in')"
          :error="errors.first('email')"
          v-model="data.email"
          :label="$t('becomeHost.fields.email')"
          data-vv-as="email"
          name="email"
          type="email"
          autocomplete="email"
          required
        />
        <wi-input
          v-validate="'required'"
          id="password"
          :disabled="$wait.is('signing in')"
          :error="errors.first('password')"
          v-model="data.password"
          :label="$t('becomeHost.fields.password')"
          data-vv-as="mot de passe"
          name="password"
          type="password"
          autocomplete="current-password"
          required
        />
      </div>

      <nuxt-link
        :to="{
          name: 'PasswordForget'
        }"
        class="forgot-password"
      >
        {{ $t("becomeHost.buttons.forgot_password") }}
      </nuxt-link>

      <div class="sign-in-form__buttons">
        <button
          :disabled="$wait.is('signing in')"
          type="submit"
          class="btn btn-green"
        >
          <span v-if="!$wait.is('signing in')">
            {{ $t("becomeHost.buttons.sign_in") }}
          </span>
          <wi-spinner v-else />
        </button>

        <br >

        <p class="body-1">
          <b style="font-size: 20px;">{{ $t("becomeHost.titles.main") }}</b>
          <br >
          {{ $t("becomeHost.titles.signIn") }}
        </p>

        <nuxt-link
          :to="{
            name: 'BecomeHost'
          }"
          class="become-link"
        >
          {{ $t("becomeHost.buttons.joinus") }}
        </nuxt-link>
      </div>
    </form>
  </div>
</template>

<script>
import WiInput from '@/components/WiUI/Input'
import WiSpinner from '@/components/WiUI/Spinner'

export default {
  name: 'SignInForm',
  components: {
    WiInput,
    WiSpinner
  },
  data () {
    return {
      data: {
        email: null,
        password: null
      }
    }
  },
  methods: {
    submitted () {
      this.$validator.validateAll().then(valid => {
        if (valid) {
          this.$wait.start('signing in')
          this.$auth
            .loginWith('local', {
              data: {
                email: this.data.email,
                password: this.data.password
              }
            })
            .then(response => {
              this.$router.push({
                path: `/farmer/${this.$auth.user.farmer.id}/agriculteur-${this.$auth.user.first_name}`
              })

              this.$toast.success({
                title: 'Connexion réussie',
                message: 'Vous vous êtes bien connecté.',
                position: 'bottom center',
                timeOut: 3000
              })
            })
            .catch(() => {
              this.$toast.error({
                title: 'Erreur',
                message:
                  'Compte introuvable. Vérifiez votre méthode de connexion et votre saisie.',
                position: 'bottom center',
                timeOut: 8000
              })
            })
            .finally(() => this.$wait.end('signing in'))
        }
      })
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.become-link {
  font-weight: bold;
  font-size: 20px;
}

.forgot-password {
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  text-align: right;
  font-size: 12px;
}

.btn-discover {
  background-color: #efce4a !important;
  border-radius: 10px;
  color: black;
  padding: 0px 5px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  font-size: 10px !important;
  border-radius: 50px;
}

.sign-in-form {
  &__fields {
    display: grid;
    grid-template-columns: 1fr 1fr;
    grid-gap: 16px;
    @media only screen and (max-width: $breakpoint-mobile-l) {
      grid-template-columns: auto;
    }
  }

  &__networks {
    border-top: 1px solid #476458;
    margin-top: 1.5rem;
    padding-top: 0.5rem;

    &__title {
      font-size: 1rem;
      color: #476458;
      font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
        Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
      text-transform: uppercase;
      font-weight: 400;
    }

    &__buttons {
      display: flex;
      justify-items: center;

      img {
        cursor: pointer;
      }

      img:first-of-type {
        margin-right: 0.5rem;
      }
    }
  }

  &__buttons {
    margin-top: 16px;
  }
}

.btn-green {
  background-color: $agri-green-light !important;
  border: solid 1px #ffffff;
  color: #ffffff;
  border-radius: 50px;
  font-size: 20px;
  font-weight: 900;
  line-height: 27px;
  margin: 0 !important;
  padding: 8px 10px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  box-shadow: 0px 0px 5px black;
}

.body-1 {
  font-size: 16px;
  color: #476458;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}
</style>
