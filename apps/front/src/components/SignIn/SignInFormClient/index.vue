<template>
  <div>
    <form
      v-if="!register"
      class="sign-in-form"
      @submit.prevent="submitted"
    >
      <div class="sign-in-form__fields">
        <wi-input
          v-validate="'required|email'"
          id="email"
          :disabled="$wait.is('signing in')"
          :error="errors.first('email')"
          v-model="data.email"
          data-vv-as="email"
          placeholder="Email"
          name="email"
          type="email"
          autocomplete="email"
          label="E-mail"
          required
        />
        <wi-input
          v-validate="'required'"
          id="password"
          :disabled="$wait.is('signing in')"
          :error="errors.first('password')"
          v-model="data.password"
          :placeholder="$t('home.placeholder.mdp')"
          data-vv-as="mot de passe"
          name="password"
          type="password"
          autocomplete="current-password"
          label="Mot de passe"
          required
        />
      </div>

      <div class="sign-in-form__buttons">
        <button
          :disabled="$wait.is('signing in')"
          type="submit"
          class="btn btn-discover"
        >

          <span
            v-if="!$wait.is('signing in')"
          >
            {{ $t('becomeClient.fields.title') }}
          </span>
          <wi-spinner
            v-else
          />
        </button>

        <br>

        <nuxt-link
          :to="{
            name: 'PasswordForget',
            class: 'forgot-password'
          }"
        >
          {{ $t('becomeClient.buttons.forgot_password') }}
        </nuxt-link>

        <br>

        <a
          style="cursor: pointer; text-decoration: underline; font-size: 17px;"
          class="forgot-password"
          @click="showModal">{{ $t('becomeClient.titles.joinus') }}</a>

      </div>
    </form>

    <sign-up-form v-else />
  </div>
</template>

<script>
import SignUpForm from '@/components/BecomeClient/BecomeClientSignIn'
import SignUpModal from '@/components/BecomeClient/SignupModal'
import WiInput from '@/components/WiUI/Input'
import WiSpinner from '@/components/WiUI/Spinner'

  export default {
    name: 'SignInFormClient',
    components: {
      WiInput,
      WiSpinner,
      SignUpModal,
      SignUpForm
    },
    data () {
      return {
        data: {
          email: null,
          password: null
        },
        isSignUpModalVisible: false,
        register: false
      }
    },
    methods: {
      showModal () {
        this.register = true
      },
      closeModal () {
        this.isSignUpModalVisible = false
      },
      submitted () {
        this.$validator.validateAll()
          .then((valid) => {
            if (valid) {
              this.$wait.start('signing in')
              this.$auth.loginWith('local', {
                data: {
                  email: this.data.email,
                  password: this.data.password
                }
              })
                .then((response) => {
                  this.$router.push({
                    path: this.$route.path
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
                    message: 'Compte introuvable. Vérifiez votre méthode de connexion et votre saisie.',
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

  .forgot-password {
    font-weight: bold;
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  }

  .btn-discover {
    background-color: #EFCE4A !important;
    border-radius: 10px;
    color: black;
    padding: 5px 25px;
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
    font-size: 12px !important;
    margin: auto;
  }

  .sign-in-form{
    &__fields{
      display: grid;
      grid-template-columns: 1fr;
      grid-gap: 16px;
    }

    &__buttons{
      margin-top: 16px;
    }
  }
</style>
