<template>
  <div class="become-host-sign-in">
    <sign-in-header
      :step="step"
      @back="step = 1"
    />
    <form
      :disabled="$wait.is('creating farmer')"
      class="become-host-sign-in__form"
      @submit.prevent="submitted"
    >
      <div
        v-show="step === 1"
        class="step-1">
        <div class="fields">
          <!-- First name -->
          <wi-input
            v-validate="'required|max:255'"
            id="first_name"
            v-model="data.firstName"
            :label="$t('becomeHost.fields.firstName')"
            :error="errors.first('first_name')"
            :disabled="$wait.is('creating farmer')"
            data-vv-as="prénom"
            name="first_name"
            type="text"
            autocomplete="given-name"
            required
          />

          <!-- Last name -->
          <wi-input
            v-validate="'required|max:255'"
            id="last_name"
            v-model="data.lastName"
            :label="$t('becomeHost.fields.lastName')"
            :error="errors.first('last_name')"
            :disabled="$wait.is('creating farmer')"
            data-vv-as="nom"
            name="last_name"
            type="text"
            autocomplete="family-name"
            required
          />

          <!-- Email -->
          <wi-input
            v-validate="'email|required'"
            id="email"
            v-model="data.email"
            :label="$t('becomeHost.fields.email')"
            :error="errors.first('email')"
            :disabled="$wait.is('creating farmer')"
            class="email-input"
            data-vv-as="e-mail"
            name="email"
            type="email"
            autocomplete="email"
            required
          />
        </div>
      </div>

      <div
        v-show="step === 2"
        class="step-2">
        <div class="fields">
          <!-- Password -->
          <wi-input
            v-validate="'required|min:6|max:255'"
            id="password"
            ref="password"
            v-model="data.password"
            :label="$t('becomeHost.fields.password')"
            :error="errors.first('password')"
            :disabled="$wait.is('creating farmer')"
            data-vv-as="mot de passe"
            name="password"
            type="password"
            autocomplete="new-password"
            required
          />

          <!-- Password confirmation -->
          <wi-input
            v-validate="'required|min:6|max:255|confirmed:password'"
            id="password_confirmation"
            v-model="data.passwordConfirmation"
            :label="$t('becomeHost.fields.passwordConfirmation')"
            :error="errors.first('password_confirmation')"
            :disabled="$wait.is('creating farmer')"
            data-vv-as="confirmation"
            name="password_confirmation"
            type="password"
            autocomplete="new-password"
            required
          />

          <!-- Phone number -->
          <wi-input
            v-validate="'required|phone:FR'"
            id="phone"
            v-model="data.phone"
            :label="$t('becomeHost.fields.phone')"
            :error="errors.first('phone')"
            :disabled="$wait.is('creating farmer')"
            data-vv-as="numéro de téléphone"
            class="phone-input"
            name="phone"
            type="tel"
            autocomplete="tel"
            required
          />
        </div>
        <div class="terms-checkbox checkbox">
          <input
            v-validate="'required'"
            id="cgu"
            type="checkbox"
            name="cgu"
            required
          >
          <label for="cgu">
            {{ $t('becomeHost.buttons.cgu_read') }} <nuxt-link :to="{ name: 'Terms', target: '_blank'}">{{ $t('becomeHost.buttons.cgu') }}</nuxt-link>
          </label>
        </div>
      </div>

      <div class="buttons">
        <button
          v-if="step === 1"
          type="button"
          class="btn btn-primary"
          @click="nextStep"
        >
          {{ $t('becomeHost.buttons.continue') }}
        </button>
        <button
          v-else
          :disabled="$wait.is('creating farmer')"
          type="submit"
          class="btn btn-primary"
        >
          <span
            v-if="!$wait.is('creating farmer')"
          >
            {{ step === 1 ? 'Continuer' : 'Créer mon compte' }}
          </span>
          <wi-spinner
            v-else
          />
        </button>
      </div>
      <div class="already-signedin">
        {{ $t('becomeHost.buttons.already_account') }} <nuxt-link :to="{ name: 'SignIn' }">{{ $t('becomeHost.buttons.sign_in_cta') }}</nuxt-link>
      </div>
    </form>
  </div>
</template>

<script>
  import moment from 'moment'

  import WiInput from '@/components/WiUI/Input'
  import SignInHeader from './_subs/SignInHeader'

  export default {
    name: 'BecomeHostSignIn',
    components: {
      WiInput,
      SignInHeader
    },
    data () {
      return {
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
    computed: {
      getMinDate () {
        return moment().format('YYYY-MM-DD')
      }
    },
    methods: {
      nextStep () {
        this.$validator.validateAll({
          first_name: this.data.firstName,
          last_name: this.data.lastName,
          email: this.data.email
        })
          .then((valid) => {
            if (valid) {
              this.step = 2
            }
          })
      },
      submitted () {
        this.$validator.validateAll()
          .then((valid) => {
            if (valid) {
              if (this.$wait.is('creating farmer')) return

              this.$wait.start('creating farmer')
              this.$axios.post('/auth', {
                first_name: this.data.firstName,
                last_name: this.data.lastName,
                email: this.data.email,
                password: this.data.password,
                password_confirmation: this.data.passwordConfirmation,
                cellphone: this.data.phone,
                birthdate: this.data.birthday,
                farmer: true
              })
                .then((res) => {
                  this.$auth.loginWith('local', {
                    data: {
                      email: this.data.email,
                      password: this.data.password
                    }
                  })
                    .then((response) => {
                      this.$router.push({
                        path: `/farmer/${this.$auth.user.farmer.id}/agriculteur-${this.$auth.user.first_name}`
                      })
                      this.$toast.success({
                        title: 'Création de compte',
                        message: 'Votre compte a bien été créé. Vous allez recevoir une confirmation par e-mail.',
                        position: 'bottom center',
                        timeOut: 10000
                      })
                    })
                })
                .catch(() => {
                  this.$toast.error({
                    title: 'Erreur',
                    message: 'L\'email utilisée semble déjà exister!',
                    position: 'bottom center',
                    timeOut: 8000
                  })
                })
                .finally(() => {
                  this.$wait.end('creating farmer')
                })
            }
          })
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .become-host-sign-in{
    background-color: white;
    border-radius: 8px;
    padding: 32px 22px;
    width: 40%;
    max-width: 720px;
    margin: auto;
    box-shadow: 0 3px 24px rgba(black, 0.05);

    @media only screen and (max-width: $breakpoint-laptop-m) {
      width: 70%;
      margin: 32px auto 0 auto;
    }

    @media only screen and (max-width: $breakpoint-tablet) {
      width: 100%;
      margin: 32px auto 0 auto;
    }

    &__form{
      border-top: 1px solid rgba(black, 0.12);
      padding-top: 16px;
      margin-top: 16px;
    }

    .fields{
      display: grid;
      grid-template-columns: repeat(2, calc(50% - 8px));
      grid-gap: 16px;

      .email-input,
      .phone-input {
        grid-column: span 2;
      }

      @media only screen and (max-width: $breakpoint-tablet) {
        grid-template-columns: 1fr;

        .email-input,
        .phone-input {
          grid-column: 1;
        }
      }
    }

    .checkbox{
      display: flex;
      grid-column: span 2;

      label{
        flex: 1;
      }
    }

    .buttons{
      display: flex;
      justify-content: center;
      padding: 32px 0 16px 0;

      .btn{
        padding: 0 64px;
      }
    }

    .terms-checkbox{
      margin-top: 16px;
    }

    .already-signedin{
      text-align: center;
    }
  }
</style>
