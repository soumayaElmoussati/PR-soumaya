<template>
  <div id="signup-form">
    <form
      :disabled="$wait.is('creating client')"
      @submit.prevent="submitted">
      <input
        v-validate="'required|max:255'"
        v-show="step === 1"
        id="first_name"
        v-model="data.firstName"
        :label="$t('becomeClient.fields.firstName')"
        :style="[
          errors.first('first_name')
            ? { border: 'red solid 1px' }
            : { border: 'none' }
        ]"
        :error="errors.first('first_name')"
        :disabled="$wait.is('creating client')"
        :placeholder="$t('becomeClient.fields.firstName')"
        data-vv-as="prénom"
        name="first_name"
        type="text"
        autocomplete="given-name"
        required
      >
      <span style="color: red">{{ errors.first("first_name") }}</span>
      <input
        v-validate="'required|max:255'"
        v-show="step === 1"
        id="last_name"
        v-model="data.lastName"
        :label="$t('becomeClient.fields.lastName')"
        :style="[
          errors.first('last_name')
            ? { border: 'red solid 1px' }
            : { border: 'none' }
        ]"
        :error="errors.first('last_name')"
        :disabled="$wait.is('creating client')"
        :placeholder="$t('becomeClient.fields.lastName')"
        data-vv-as="nom"
        name="last_name"
        type="text"
        autocomplete="last_name"
        required
      >
      <span style="color: red">{{ errors.first("last_name") }}</span>
      <input
        v-validate="'email|required'"
        v-show="step === 1"
        id="email"
        v-model="data.email"
        :style="[
          errors.first('email')
            ? { border: 'red solid 1px' }
            : { border: 'none' }
        ]"
        :label="$t('becomeClient.fields.email')"
        :error="errors.first('email')"
        :disabled="$wait.is('creating client')"
        placeholder="E-mail"
        class="email-input"
        data-vv-as="e-mail"
        name="email"
        type="email"
        autocomplete="email"
        required
      >
      <span style="color: red">{{ errors.first("email") }}</span>
      <input
        v-validate="'required|min:6|max:255'"
        v-show="step === 2"
        id="password"
        ref="password"
        :style="[
          errors.first('password')
            ? { border: 'red solid 1px' }
            : { border: 'none' }
        ]"
        v-model="data.password"
        :label="$t('becomeClient.fields.password')"
        :error="errors.first('password')"
        :disabled="$wait.is('creating client')"
        :placeholder="$t('becomeClient.fields.password')"
        data-vv-as="mot de passe"
        name="password"
        type="password"
        autocomplete="new-password"
        required
      >
      <span style="color: red">{{ errors.first("password") }}</span>
      <input
        v-validate="'required|min:6|max:255|confirmed:password'"
        v-show="step === 2"
        id="password_confirmation"
        v-model="data.passwordConfirmation"
        :label="$t('becomeClient.fields.passwordConfirmation')"
        :error="errors.first('password_confirmation')"
        :disabled="$wait.is('creating client')"
        :style="[
          errors.first('password_confirmation')
            ? { border: 'red solid 1px' }
            : { border: 'none' }
        ]"
        :placeholder="$t('becomeClient.fields.passwordConfirmation')"
        data-vv-as="confirmation"
        name="password_confirmation"
        type="password"
        autocomplete="new-password"
        required
      >
      <span style="color: red">{{
        errors.first("password_confirmation")
      }}</span>
      <input
        v-validate="'required|phone:FR'"
        v-show="step === 2"
        id="phone"
        :style="[
          errors.first('phone')
            ? { border: 'red solid 1px' }
            : { border: 'none' }
        ]"
        v-model="data.phone"
        :label="$t('becomeClient.fields.phone')"
        :error="errors.first('phone')"
        :disabled="$wait.is('creating client')"
        :placeholder="$t('becomeClient.fields.phone')"
        data-vv-as="numéro de téléphone"
        class="phone-input"
        name="phone"
        type="tel"
        autocomplete="tel"
        required
      >
      <span style="color: red">{{ errors.first("phone") }}</span>

      <div
        v-show="step === 2"
        style="display: flex; justify-content: space-around;"
      >
        <input
          v-validate="'required'"
          name="cgu"
          required
          type="checkbox"
          class="checkbox"
        >
        <p>
          {{ $t('becomeClient.legend.read') }}
          <nuxt-link
            :to="{ name: 'Terms', target: '_blank' }"
          >{{ $t('becomeClient.legend.conditions') }}</nuxt-link
          >
        </p>
      </div>

      <div stymle="display: flex">
        <button
          v-if="step === 1"
          type="button"
          class="btn signup"
          @click="nextStep"
        >
          {{ $t("becomeClient.buttons.continue") }}
        </button>
        <button
          v-else
          :disabled="$wait.is('creating client')"
          type="submit"
          class="btn signup"
        >
          <span v-if="!$wait.is('creating client')">
            {{ step === 1 ? "Continuer" : "Créer mon compte" }}
          </span>
          <wi-spinner v-else />
        </button>
        <button
          v-show="step === 2"
          class="btn signup"
          @click="back">
          {{ $t("becomeClient.buttons.back") }}
        </button>
        <button
          id="closeBtn"
          class="btn signup"
          @click="closeModal()">
          {{ $t("becomeClient.buttons.close") }}
        </button>
      </div>
    </form>
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
</template>

<script>
import google from '@/assets/img/auth/iconGoogle.png'
import facebook from '@/assets/img/auth/iconFacebook.png'
export default {
  name: 'SignupFormTest',
  data () {
    return {
      google,
      facebook,
      register: true,
      step: 1,
      data: {
        firstName: null,
        lastName: null,
        email: null,
        phone: null,
        password: null,
        passwordConfirmation: null,
        birthday: null
      }
    }
  },
  methods: {
    submitted () {
      this.$validator.validateAll().then(valid => {
        if (valid) {
          if (this.$wait.is('creating client')) return

          this.$wait.start('creating client')
          this.$axios
            .post('/auth', {
              first_name: this.data.firstName,
              last_name: this.data.lastName,
              email: this.data.email,
              password: this.data.password,
              password_confirmation: this.data.passwordConfirmation,
              cellphone: this.data.phone,
              birthdate: this.data.birthday,
              farmer: false
            })
            .then(res => {
              this.$auth
                .loginWith('local', {
                  data: {
                    email: this.data.email,
                    password: this.data.password
                  }
                })
                .then(response => {
                  this.$toast.success({
                    title: 'Création de compte',
                    message:
                      'Votre compte a bien été créé. Vous allez recevoir une confirmation par e-mail.',
                    position: 'bottom center',
                    timeOut: 10000
                  })
                })
            })
            .catch(() => {
              this.$toast.error({
                title: 'Erreur',
                message: "L'email utilisée semble déjà exister!",
                position: 'bottom center',
                timeOut: 8000
              })
            })
            .finally(() => {
              this.$wait.end('creating client')
            })
        }
      })
    },
    nextStep () {
      this.$validator
        .validateAll({
          first_name: this.data.firstName,
          last_name: this.data.lastName,
          email: this.data.email
        })
        .then(valid => {
          if (valid) {
            this.step = 2
          }
        })
    },
    back () {
      this.step = 1
    },
    closeModal () {
      this.$emit('closeModal', false)
      this.step = 1
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

#closeBtn:hover {
  background-color: #a8373f;
}

#closeBtn {
  background-color: #F0505C;
}

body {
  background: #fff;
}
#signup-form {
  .btn-back {
    width: 20% !important;
    border-radius: 20px;
    background: $agri-green-light;
    border: none;
    color: $agri-white;
    font-weight: bold;
    left: 5%;
  }
}

.modal-fade-enter,
.modal-fade-leave-active {
  opacity: 0;
}

.modal-fade-enter-active,
.modal-fade-leave-active {
  transition: opacity 0.5s ease;
}

.modal-backdrop {
  position: fixed;
  top: 0vh;
  bottom: 0;
  left: 0;
  right: 0;
  background-color: rgba(0, 0, 0, 0.3);
  display: flex;
  justify-content: center;
  align-items: center;
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 95%;
    margin: 0 auto;
  }
}

.form-modal {
  position: relative;
  width: 30%;
  height: auto;
  /* margin-top: 4em; */
  /* left: 50%; */
  margin: 0 auto;
  /* transform: translateX(-50%); */
  background: #fff;
  border-top-right-radius: 20px;
  border-top-left-radius: 20px;
  border-bottom-right-radius: 20px;
  box-shadow: 0 3px 20px 0px rgba(0, 0, 0, 0.1);
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
  background: #5d9140 !important;
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
}

#login-form,
#signup-form {
  position: relative;
  width: 100%;
  height: auto;
  padding-bottom: 1em;
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
  line-height: 25px;
  padding: 10px;
}

.form-modal input {
  position: relative;
  width: 100%;
  font-size: 1em;
  padding: 1em 1em 1em 1em;
  margin-top: 0.6em;
  margin-bottom: 0.6em;
  border-radius: 10px;
  border: none;
  background: #ebebeb;
  outline: none;
  font-weight: bold;
  transition: 0.4s;
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
  font-weight: bold;
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
    width: 100%;
  }
}

@media only screen and (max-width: 400px) {
  i {
    display: none !important;
  }
}
</style>
