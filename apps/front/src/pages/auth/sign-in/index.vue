<template>
  <div>
    <div class="sign-in">
      <div class="wrap">
        <div class="side">
          <div class="sign-in-form__networks">
            <p class="body-1">
              <b style="font-size: 20px;">{{ $t("becomeHost.titles.connect") }}</b>
              <br >
            </p>
            <!-- <h3 class="sign-in-form__networks__title">{{ $t("becomeHost.buttons.continueWith") }}</h3>
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
            <hr > -->
          </div>

          <p class="signin-title">{{ $t("becomeHost.buttons.sign_in") }}</p>

          <sign-in-form />
        </div>

        <div class="carousel-side">
          <vueper-slides
            :pause-on-hover="pauseOnHover"
            :visible-slides="1"
            :gap="3"
            :slide-ratio="1 / 4"
            :dragging-distance="200"
            :breakpoints="{ 800: { visibleSlides: 1, slideMultiple: 1 } }"
            :style="'background-color: white;border-radius: 20px'"
            :arrows="false"
            autoplay
            fixed-height="250px"
            class="no-shadow"
            slide-multiple
            @autoplay-pause="internalAutoPlaying = false"
            @autoplay-resume="internalAutoPlaying = true"
          >
            <vueper-slide
              v-for="(slide, i) in infos"
              :key="i"
              :image="slide.image"
              :title="slide.title"
              :content="slide.content"
            />
          </vueper-slides>
        </div>
      </div>
    </div>
    <metoo />
    <!-- <metoo style="height: 665px !important" /> -->
  </div>
</template>

<script>
import SignInForm from '@/components/SignIn/SignInForm'
import metoo from '@/components/BecomeHost/BecomeHostMeToo'
import { VueperSlides, VueperSlide } from 'vueperslides'
import 'vueperslides/dist/vueperslides.css'

export default {
  name: 'SignIn',
  components: {
    SignInForm,
    VueperSlides,
    VueperSlide,
    metoo
  },
  data: () => ({
    pauseOnHover: true,
    autoPlaying: true,
    internalAutoPlaying: true,
    infos: [
      {
        title:
          '<b style="font-size: 11px;color: #476458; bottom: 0; text-transform: uppercase; font-weight: bold;">Faire découvrir la vie à la ferme</b>',
        content:
          '<p style="font-size: 11px;color: #476458; bottom: 0;">L’agritourisme est un moyen formidable <br> pour faire découvrir votre exploitation et <br> votre vocation. Il est temps d’ouvrir vos <br> portes pour des séjours haut en couleur ! <br> Un activité d’une heure sera organisée en <br> amont avec le visiteur afin qu’il comprenne <br> votre quotidien.</p>'
      },
      {
        title:
          '<b style="font-size: 11px;color: #476458; bottom: 0; text-transform: uppercase; font-weight: bold;">Être sur une plateforme qui vous ressemble</b>',
        content:
          '<p style="font-size: 11px;color: #476458; bottom: 0;">AgriVillage est une plateforme française, <br> proche de ses agriculteurs partenaires. Nous <br> travaillerons main dans la main pour renforcer <br> le lien entre le monde agricole et urbain. <br> Des supports pédagogiques seront à votre <br> disposition pour afin de faire découvrir votre <br> métier de façon ludique.</p>'
      },
      {
        title:
          '<b style="font-size: 11px;color: #476458; bottom: 0; text-transform: uppercase; font-weight: bold;">Gagner de l’argent</b>',
        content:
          '<p style="font-size: 11px;color: #476458; bottom: 0;">Stop aux cotisations ! <br> Avec AgriVillage l’inscription est gratuite <br>et sans engagement !</p>'
      }
    ]
  }),
  head () {
    return {
      title: 'Se connecter'
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
          if (this.$auth.user.farmer) {
            this.$router.push({
              path: `/farmer/${this.$auth.user.farmer.id}/agriculteur-${this.$auth.user.first_name}`
            })
          } else {
            this.$router.push({
              path: `/dashboard/client-bookings`
            })
          }

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
@import "vueperslides/dist/vueperslides.css";

.vueperslides__bullet .default {
  border: 1px solid #476458 !important;
}

.sign-in {
  padding: 64px 0;
  background-image: url(~assets/img/auth/background.png);
  background-size: cover;

  .wrap {
    display: flex;
    justify-content: space-between;

    @media only screen and (max-width: $breakpoint-laptop-m) {
      flex-direction: column;
    }
  }

  .side {
    width: 50%;
    background-color: inherit;

    @media only screen and (max-width: $breakpoint-laptop-m) {
      width: 100%;
      padding: 0 16px;
    }

    .body-1 {
      font-size: 16px;
      color: #476458;
      font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
        Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    }

    .signin-title {
      font-size: 23px;
      color: #476458;
      font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
        Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
      text-transform: uppercase;
    }
  }

  .carousel-side {
    width: 20%;
    margin: auto;
    @media only screen and (max-width: $breakpoint-tablet-l) {
      width: 30%;
    }
    @media only screen and (max-width: $breakpoint-tablet) {
      display: none;
    }
  }
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
      @media only screen and (max-width: $breakpoint-mobile-m) {
        flex-direction: column;
      }
      img {
        cursor: pointer;
        width: fit-content;
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
</style>
