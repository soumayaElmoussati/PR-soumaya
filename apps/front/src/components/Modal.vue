<template>
  <transition name="modal-fade">
    <div class="modal-backdrop">
      <div class="form-modal">
        <div class="form-toggle">
          <button
            v-if="login"
            id="login-toggle"
            @click="toggleLogin()">
            {{ $t("becomeClient.modal.login") }}
          </button>
          <button
            v-if="login"
            id="signup-toggle"
            @click="toggleSignup()">
            {{ $t("becomeClient.modal.signup") }}
          </button>
          <button
            v-if="signup"
            id="signup-toggle"
            @click="toggleLogin()">
            {{ $t("becomeClient.modal.login") }}
          </button>
          <button
            v-if="signup"
            id="login-toggle"
            @click="toggleSignup()">
            {{ $t("becomeClient.modal.signup") }}
          </button>
        </div>

        <div
          v-if="login"
          id="login-form">
          <form @submit.prevent="submitted">
            <input
              v-validate="'required|email'"
              id="email"
              :disabled="$wait.is('signing in')"
              :style="[
                errors.first('email')
                  ? { border: 'red solid 1px' }
                  : { border: 'none' }
              ]"
              :error="errors.first('email')"
              v-model="data.email"
              data-vv-as="email"
              placeholder="E-mail"
              name="email"
              type="email"
              autocomplete="email"
            >
            <span style="color: red">{{ errors.first("email") }}</span>
            <input
              v-validate="'required'"
              id="password"
              :style="[
                errors.first('password')
                  ? { border: 'red solid 1px' }
                  : { border: 'none' }
              ]"
              :disabled="$wait.is('signing in')"
              :error="errors.first('password')"
              v-model="data.password"
              :placeholder="$t('home.placeholder.mdp')"
              type="password"
              data-vv-as="mot de passe"
              name="password"
              autocomplete="current-password"
            >
            <span style="color: red">{{ errors.first("password") }}</span>
            <button
              :disabled="$wait.is('signing in')"
              class="btn login"
              type="submit"
            >
              <span v-if="!$wait.is('signing in')">
                {{ $t("becomeClient.fields.title") }}
              </span>
              <wi-spinner v-else />
            </button>
          </form>
          <button
            id="closeBtn"
            class="btn"
            @click="closeModal()"
          >
            {{ $t("becomeClient.modal.close") }}
          </button>
          <p>
            <nuxt-link
              :to="{
                name: 'PasswordForget',
                class: 'forgot-password'
              }"
            >
              {{ $t("becomeClient.buttons.forgot_password") }}
            </nuxt-link>
          </p>
          <hr >
          <button
            id="buttonConnect"
            type="button"
            class="btn -box-sd-effect"
            style="display: flex; justify-content: space-evenly; text-transform: none;"
            @click="signIn('googleOAuth')"
          >
            <img
              :src="google"
              alt="connecter avec google" >
            <p>{{ $t("becomeClient.modal.loginGoogle") }}</p>
          </button>
          <button
            id="buttonConnect"
            type="button"
            class="btn -box-sd-effect"
            style="display: flex; justify-content: space-evenly; text-transform: none;"
            @click="signIn('facebookOAuth')"
          >
            <img
              :src="facebook"
              alt="connecter avec facebook" >
            <p>{{ $t("becomeClient.modal.loginFacebook") }}</p>
          </button>
        </div>

        <signupForm
          v-if="signup"
          @closeModal="closeModal" />
      </div>
    </div>
  </transition>
</template>

<script>
import signupForm from '@/components/BecomeClient/SignUpFormTest'
import WiSpinner from '@/components/WiUI/Spinner'
import google from '@/assets/img/auth/iconGoogle.png'
import facebook from '@/assets/img/auth/iconFacebook.png'
import cross from '@/assets/img/auth/cross.png'
export default {
  name: 'Modal',
  components: {
    signupForm,
    WiSpinner
  },
  data () {
    return {
      google,
      cross,
      facebook,
      login: true,
      signup: false,
      data: {
        email: null,
        password: null
      },
      isSignUpModalVisible: false,
      register: false
    }
  },
  methods: {
    toggleLogin () {
      this.login = true
      this.signup = false
    },
    toggleSignup () {
      this.login = false
      this.signup = true
    },
    closeModal () {
      this.$emit('closeModal', false)
      this.login = true
      this.signup = false
    },
    signIn (schema) {
      this.$wait.start('signing in')
      this.$auth
        .loginWith(schema, {
          params: {
            farmer: false
          }
        })
        .then(() => {
          /**
           * According to the user "role", redirect to the right view.
           * Even if the user signed-in to the "farmer" view, if the
           * user is a client, redirect it to the client view.
           *
           * Althrough the user sign-in as a farmer, if the data
           * returns client, redirect it to the right view.
           */
          this.$toast.success({
            title: 'Connexion réussie',
            message: 'Vous vous êtes bien connecté.',
            position: 'bottom center',
            timeOut: 3000
          })
          this.$emit('closeModal', false)
        })
        .catch(() => {
          this.$toast.error({
            title: 'Erreur',
            message:
              'Cette adresse est déjà enregistrée dans AgriVillage. Pour vous connecter saisissez directement votre adresse mail.',
            position: 'bottom center',
            timeOut: 8000
          })
        })
        .finally(() => this.$wait.end('signing in'))
    },
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
                path: this.$route.path
              })
              this.$toast.success({
                title: 'Connexion réussie',
                message: 'Vous vous êtes bien connecté.',
                position: 'bottom-center',
                timeOut: 3000
              })
              this.$emit('closeModal', false)
            })
            .catch(() => {
              this.$toast.error({
                title: 'Erreur',
                message:
                  'Compte introuvable. Vérifiez votre méthode de connexion et votre saisie.',
                position: 'bottom-center',
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
@import url("https://fonts.googleapis.com/css?family=Montserrat|Quicksand");
@import "@/assets/scss/_variables.scss";

* {
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  box-sizing: border-box;
}

body {
  background: #fff;
}

.modal-fade-enter,
.modal-fade-leave-active {
  opacity: 0;
}

.modal-fade-enter-active,
.modal-fade-leave-active {
  transition: opacity 0.5s ease;
}
#closeBtn:hover {
  background-color: #a8373f;
}

#closeBtn {
  background-color: #F0505C;
  width: 90% !important;
  margin: 0 auto;
  color: white;
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 80% !important;
  }
}
#buttonConnect {
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 80% !important;
    margin: 2px auto !important;
  }
}

.modal-backdrop {
  // position: fixed;
  z-index: 1000;
  width: auto;
  top: 0vh;
  bottom: 0;
  left: 0;
  right: 0;
  background-color: rgba(0, 0, 0, 0.3);
  display: flex;
  justify-content: center;
  align-items: center;
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 90%;
    margin: 0 auto;
  }
}

.form-modal {
  max-height: -webkit-fill-available;
  overflow-y: auto;
  position: relative;
  width: 30%;
  // width: 450px;
  height: auto;
  margin: 0 auto;
  margin-top: 6vh;
  margin-bottom: 6vh;
  background: #fff;
  border-top-right-radius: 10px;
  border-top-left-radius: 10px;
  border-bottom-right-radius: 10px;
  border-bottom-left-radius: 10px;
  box-shadow: 1px 1px 8px 6px #1f3820;
  // box-shadow: 0 3px 20px 0px rgba(0, 0, 0, 0.1);
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 60%;
  }
}

.form-modal button {
  cursor: pointer;
  position: relative;
  font-size: 1em;
  z-index: 2;
  outline: none;
  background: #fff;
  transition: 0.2s;
  @media only screen and (max-width: $breakpoint-tablet) {
    font-size: 0.5em;
  }
}

.form-modal .btn {
  border-radius: 20px;
  border: none;
  font-weight: bold;
  font-size: 1em;
  // padding: 0px;
  // padding: 0.5em 1em 0.5em 1em !important;
  transition: 0.5s;
  border: 1px solid #ebebeb;
  margin-bottom: 0.5em;
  margin-top: 0.5em;
  @media only screen and (max-width: $breakpoint-tablet) {
    font-size: 0.7em;
  }
  p {
    font-weight: bold;
    font-size: 0.9em;
    margin: 0 0 0 -0.6rem;
    padding: 0;
  }
}
#signup-toggle:hover {
  background: $agri-green-light;
  color: white;
}

.form-modal .login,
.form-modal .signup {
  background: $agri-green-light;
  color: #fff;
}

.form-modal .login:hover,
.form-modal .signup:hover {
  background: #5d9140;
}

.form-toggle {
  position: relative;
  width: 100%;
  height: auto;
}

.form-toggle button {
  width: 50%;
  float: left;
  padding: 10px;
  // padding: 1.5em;
  margin-bottom: 1.5em;
  border: none;
  transition: 0.2s;
  font-size: 1em;
  font-weight: bold;
  border-top-right-radius: 10px;
  border-top-left-radius: 10px;
  @media only screen and (max-width: $breakpoint-tablet) {
    font-size: 0.7em;
  }
}

.form-toggle button:nth-child(1) {
  border-bottom-right-radius: 20px;
}

.form-toggle button:nth-child(2) {
  border-bottom-left-radius: 20px;
}

#login-toggle {
  background: $agri-green-light;
  color: #ffff;
}

.form-modal form {
  position: relative;
  width: 90%;
  height: auto;
  left: 50%;
  transform: translateX(-50%);
  @media only screen and (max-width: 500px) {
    width: 80%;
  }
}

#login-form,
#signup-form {
  position: relative;
  width: 100%;
  height: auto;
}

#signup-form {
  .checkbox {
    padding: 0;
    width: 20%;
    margin: auto auto;
  }
}

#login-form button,
#signup-form button {
  width: 100%;
  margin-top: 0.5em;
  // padding: 0.6em;
  padding: 10px;
  line-height: 25px!important;
}

.form-modal input {
  position: relative;
  width: 100%;
  font-size: 0.9em;
  padding: 1em 1em 1em 1em;
  // padding: 1.2em 1.7em 1.2em 1.7em;
  margin-top: 0.6em;
  margin-bottom: 0.6em;
  border-radius: 10px;
  border: none;
  background: #ebebeb;
  outline: none;
  font-weight: bold;
  transition: 0.5s;
  @media only screen and (max-width: 500px) {
    font-size: 0.7em;
  }
}

.form-modal input:focus,
.form-modal input:active {
  transform: scaleX(1.02);
}

.form-modal input::-webkit-input-placeholder {
  color: #222;
}

.form-modal p {
  font-size: 16px;
  font-weight: 600;
}

.form-modal p a {
  color: $agri-green-light;
  text-decoration: none;
  transition: 0.2s;
}

.form-modal p a:hover {
  color: #222;
}

.form-modal i {
  position: absolute;
  left: 10%;
  top: 50%;
  transform: translateX(-10%) translateY(-50%);
}

.fa-google {
  color: #dd4b39;
}

.fa-linkedin {
  color: #3b5998;
}

.fa-windows {
  color: #0072c6;
}
.-box-sd-effect {
  img {
    width: 30px;
    height: 30px;
    margin: auto 0;
  }
}

.-box-sd-effect:hover {
  box-shadow: 0 4px 8px hsla(210, 2%, 84%, 0.2);
}

@media only screen and (max-width: 500px) {
  .form-modal {
    width: 90%;
  }
}

@media only screen and (max-width: 400px) {
  i {
    display: none !important;
  }
}
</style>
