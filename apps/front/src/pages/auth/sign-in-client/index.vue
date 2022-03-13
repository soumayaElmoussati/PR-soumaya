<template>
  <div class="sign-in">
    <div class="wrap">
      <div class="side">
        <h1 class="title">
          {{ $t('becomeClient.fields.title') }}
        </h1>
        <p class="body-1">
          {{ $t('becomeClient.titles.connect') }}
        </p>
        <div>
          <div class="sign-in-form__networks">
            <h3
              class="sign-in-form__networks__title"
              style="font-weight: normal;">{{ $t("becomeHost.buttons.continueWith") }}</h3>
            <div class="sign-in-form__networks__buttons">
              <img
                src="@/assets/img/auth/btn-google.png"
                title="Se connecter avec Google"
                height="35"
                alt="google"
                role="button"
                @click="signIn('googleOAuth')"
              >
              <img
                src="@/assets/img/auth/btn-facebook.png"
                title="Se connecter avec Facebook"
                height="35"
                alt="facebook"
                role="button"
                @click="signIn('facebookOAuth')"
              >
            </div>
            <hr >
          </div>
        </div>
        <sign-in-form />
      </div>
      <div class="sign-in__img">
        <img
          src="~/assets/img/auth/sign-in.svg"
          alt=""
          width="400"
        >
      </div>
    </div>
  </div>
</template>

<script>
  import SignInForm from '@/components/SignIn/SignInFormClientMail'

  export default {
    name: 'SignInClient',
    components: {
      SignInForm
    },
    head () {
      return {
        title: 'Se connecter Client'
      }
    },
    methods: {
    signIn (schema) {
      this.$wait.start('signing in')
      this.$auth
        .loginWith(schema, {
          params: {
            farmer: true
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
  @import "@/assets/scss/_variables.scss";

  .sign-in{
    padding: 64px 0;

    .wrap {
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
    }

    &__img{
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
