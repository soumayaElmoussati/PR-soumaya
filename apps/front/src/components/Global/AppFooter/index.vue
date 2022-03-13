<template>
  <footer
    :class="{ 'mt-0': $parent.expl }"
    class="app-footer">
    <img
      src="@/assets/img/forest/forest-footer.png"
      class="forest-footer"
      title="forest-footer"
      alt="forest-footer"
    >
    <div class="wrap laptop-wrap">
      <div class="right-footer">
        <div class="info-menu">
          <div class="info-logo">
            <nuxt-link
              :to="'/'"
              class="app-footer-logo">
              <img
                src="@/assets/img/logo/logo-footer.png"
                width="132"
                height="127"
                title="logo"
                alt="logo"
              >
            </nuxt-link>

            <div class="press-logo">
              <a
                href="https://www.europe1.fr/emissions/la-france-bouge-academie/la-france-bouge-academie-161019-3925854"
                target="_blank"
              >
                <img
                  alt="europe1"
                  title="europe1"
                  src="@/assets/img/footer/europe1.svg"
                  width="57"
                  height="20"
                >
              </a>

              <a
                href="https://www.youtube.com/watch?v=fujGJndPX1k"
                target="_blank"
              >
                <img
                  alt="tf1"
                  title="tf1"
                  src="@/assets/img/footer/tf1.svg"
                  width="57"
                  height="20"
                >
              </a>

              <a
                href="https://www.youtube.com/watch?v=9F_v5exKYdk"
                target="_blank"
              >
                <img
                  alt="france-3"
                  title="france-3"
                  src="@/assets/img/footer/france3.svg"
                  width="57"
                  height="20"
                  class="fr3"
                >
              </a>
            </div>
          </div>
          <div class="mobilInfoResp">
            <div class="info-information">
              <h3>{{ $t("global.footer.titles.informations") }}</h3>
              <p class="legalmenu">
                <button
                  class="app-header-menu__title"
                  @click="goTerms">
                  {{ $t("global.footer.list.terms") }}
                </button>
              </p>

              <p class="legalmenu">
                <button
                  class="app-header-menu__title"
                  @click="goLegal">
                  {{ $t("global.footer.list.legals") }}
                </button>
              </p>

              <p class="legalmenu">
                <button
                  @click="goBlog">
                  {{ $t("global.footer.list.blog") }}
                </button>
              </p>
            </div>
            <div class="info-decouvrir">
              <h3>{{ $t("global.footer.titles.discover") }}</h3>

              <p class="legalmenu">
                <button
                  class="app-header-menu__title"
                  @click="goAbout">
                  {{ $t("global.footer.list.about") }}
                </button>
              </p>
              <p class="legalmenu">
                <button
                  class="app-header-menu__title"
                  target="_blank"
                  @click="goGift">
                  {{ $t("global.footer.list.gift_box") }}
                </button>
                <img
                  alt="coffret"
                  title="coffret"
                  src="@/assets/img/home/coffret.png"
                  width="20"
                  height="20"
                >
              </p>

              <p class="legalmenu">
                <a
                  href="https://blog.agrivillage.fr/faq"
                  target="_blank">{{
                    $t("global.footer.list.faq")
                  }}</a>
              </p>
            </div>
          </div>
        </div>

        <div class="about">
          <h3 class="about-title">
            {{ $t("global.footer.titles.about") }}
          </h3>

          <p class="body-1">
            {{ $t("global.footer.paragraphs.about")[0] }}
          </p>
          <p class="body-1">
            {{ $t("global.footer.paragraphs.about")[1] }}
          </p>
        </div>
      </div>

      <div class="contact">
        <h3>
          {{ $t("global.footer.titles.contact") }}
        </h3>
        <ul>
          <li class="contact-icon">
            <img
              src="@/assets/img/footer/phone.svg"
              class="icon-img"
              height="24"
              alt="0601350754"
              title="0601350754"
              width="24"
            >
            {{ $t("global.contact.phone") }}
          </li>
          <li class="contact-icon">
            <img
              src="@/assets/img/footer/mail.svg"
              class="icon-img"
              height="24"
              title="adrien.gabillet@agrivillage.fr"
              alt="adrien.gabillet@agrivillage.fr"
              width="24"
            >
            <a href="mailto:adrien.gabillet@agrivillage.fr">
              {{ $t("global.contact.email") }}
            </a>
          </li>

          <br >
          <li>
            <ul class="follow">
              <h3>
                {{ $t("global.footer.titles.social_network") }}
              </h3>
              <li>
                <a
                  href="https://www.facebook.com/AgriVillage.fr/"
                  target="_blank"
                >
                  <img
                    class="social-icon"
                    alt="facebook"
                    title="facebook"
                    src="https://res.cloudinary.com/bdmbdm/image/upload/v1554720648/facebook2.svg"
                  >
                </a>
              </li>
              <li class="follow-space">
                <a
                  href="https://www.instagram.com/agrivillage.fr/"
                  target="_blank"
                >
                  <img
                    class="social-icon"
                    alt="instagram"
                    title="instagram"
                    src="https://res.cloudinary.com/bdmbdm/image/upload/v1554720648/instagram2.svg"
                  >
                </a>
              </li>
              <li class="follow-space">
                <a
                  href="https://twitter.com/AgriVillagefr"
                  target="_blank">
                  <img
                    class="social-icon"
                    alt="twitter"
                    title="twitter"
                    src="https://res.cloudinary.com/bdmbdm/image/upload/v1554720648/twitter3.svg"
                  >
                </a>
              </li>
              <li class="follow-space">
                <a
                  href="https://www.linkedin.com/company/agrivillage"
                  target="_blank"
                >
                  <img
                    class="social-icon"
                    alt="linkedin"
                    title="linkedin"
                    src="https://res.cloudinary.com/bdmbdm/image/upload/v1554720648/linkedin2.svg"
                  >
                </a>
              </li>
            </ul>
          </li>
        </ul>
        <!-- Begin Mailchimp Signup Form -->
        <h3>
          {{ $t("global.footer.titles.newsletter") }}
        </h3>
        <link
          href="//cdn-images.mailchimp.com/embedcode/horizontal-slim-10_7.css"
          rel="stylesheet"
          type="text/css"
        >
        <div id="mc_embed_signup">
          <form
            id="mc-embedded-subscribe-form"
            action="https://agrivillage.us20.list-manage.com/subscribe/post?u=9d4d8b8f930e25ea615effb83&amp;id=0dda707543"
            method="post"
            name="mc-embedded-subscribe-form"
            class="validate"
            target="_blank"
            novalidate
          >
            <div id="mc_embed_signup_scroll">
              <input
                id="mce-EMAIL"
                :placeholder="$t('global.placeholder.email')"
                type="email"
                value=""
                name="EMAIL"
                class="email"
                required
              >
              <div class="clear">
                <input
                  id="mc-embedded-subscribe"
                  type="submit"
                  value="S'abonner"
                  name="S'abonner"
                  class="button"
                >
              </div>
            </div>
          </form>
        </div>

        <!--End mc_embed_signup-->
      </div>
      <div class="grid-link">
        <h3 style="grid-area: grandlink">
          {{ $t("global.footer.titles.toprecherche") }}
        </h3>
        <button
          class="grid-area: petitlink1"
          @click="goHostFarm">
          {{ $t("global.grid.guest") }}
        </button>
        <button
          class="grid-area: petitlink2"
          @click="goFamilly">
          {{ $t("global.grid.vacancy") }}
        </button>
        <button
          class="grid-area: petitlink3"
          @click="goWeekend">
          {{ $t("global.grid.week") }}
        </button>
        <button
          class="grid-area: petitlink4"
          @click="goInsolite">
          {{ $t("global.grid.location") }}
        </button>
        <button
          class="grid-area: petitlink5"
          @click="goHebergement">
          {{ $t("global.grid.host") }}
        </button>
        <button
          class="grid-area: petitlink6"
          @click="goOriginales">
          Vacances originales en France
        </button>
        <button
          class="grid-area: petitlink7"
          @click="goSeminar">
          Séminaire d'entreprise
        </button>
      </div>
    </div>
  </footer>
</template>

<script>
export default {
  name: 'AppFooter',
  methods: {
    goTerms () {
      this.$router.push({
        name: 'Terms'
      })
    },
    goLegal () {
      this.$router.push({
        name: 'Legal'
      })
    },
    goBlog () {
      this.$router.push({
        name: 'Blog'
      })
    },
    goAbout () {
      this.$router.push({
        name: 'About'
      })
    },
    goGift () {
      this.$router.push({
        name: 'Cadeaux'
      })
    },
    goHostFarm () {
      this.$router.push({
        name: 'ChambreHoteALaFerme'
      })
    },
    goFamilly () {
      this.$router.push({
        name: 'VacancesEnFamille'
      })
    },
    goWeekend () {
      this.$router.push({
        name: 'WeekEndFerme'
      })
    },
    goInsolite () {
      this.$router.push({
        name: 'InsoliteBretagne'
      })
    },
    goHebergement () {
      this.$router.push({
        name: 'HebergementFerme'
      })
    },
    goOriginales () {
      this.$router.push({
        name: 'OriginalesEnFrance'
      })
    },
    goSeminar () {
      this.$router.push({
        name: 'CompanySeminar'
      })
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

button{
  border: none;
  background: transparent;
  color: white;
  cursor: pointer;
}

.fr3 {
  background-color: white;
}

.sm-gift {
  margin-top: 14px !important;
}

.laptop-wrap {
  display: grid;
  .grid-link {
    display: grid;
    font-size: 14px;
    grid-template-areas:
      "grandlink petitlink1 petitlink2 petitlink3 petitlink7"
      "grandlink petitlink4 petitlink5 petitlink6 petitlink7";
    gap: 15px 10px;
    @media only screen and (max-width: $breakpoint-tablet) {
      grid-template-areas:
        "grandlink grandlink"
        "petitlink1 petitlink2"
        "petitlink3 petitlink4"
        "petitlink5 petitlink6"
        "petitlink7 petitlink7";
    }
  }
}

.contact-info {
  font-size: 13px;
}

.mobile-newsletter {
  display: grid;
  grid-template-columns: auto auto;
  grid-gap: 1em;
}

.contact-list {
  display: grid;
  grid-template-columns: auto;
}

.about-mobile {
  text-align: center;
}

.mobilInfoResp {
  @media only screen and (max-width: $breakpoint-tablet) {
    display: flex;
    justify-content: space-between;
  }
  @media only screen and (max-width: $breakpoint-mobile-m) {
    display: flex;
    flex-direction: column;
  }
}

.info-information {
  margin-top: 50px;
  @media only screen and (max-width: $breakpoint-tablet) {
    margin-top: 0px;
  }
}

.information-list {
  display: grid;
  grid-template-columns: auto auto auto;
  text-align: center;
}

.info-decouvrir {
  margin-top: 50px;
  @media only screen and (max-width: $breakpoint-tablet) {
    margin-top: 0px;
  }
}

.forest-footer {
  position: absolute;
  margin-top: -150px;
  right: 0;
  margin-right: 50px;
  @media only screen and (max-width: $breakpoint-tablet) {
    display: none;
  }
}

#mc_embed_signup {
  clear: left;
  font-size: 14px;
  width: 100%;
}

div#mc_embed_signup_scroll {
  text-align: left !important;
}

#mc_embed_signup form[data-v-3836ae43] {
  text-align: left;
}

#mc-embedded-subscribe-form input[type="checkbox"] {
  display: inline;
  width: auto;
  margin-right: 10px;
}

#mc_embed_signup input.email {
  width: 168px;
  height: 37px;
  border-radius: 10px;
  font-size: 10px;
  color: white !important;
  border: 1px solid white;
  background-color: #262626;
  padding: 10px;
  color: white;
}

#mc_embed_signup .button {
  height: 37px;
  background-color: #efce4a;
  color: #262626;
  border-radius: 10px;
  text-transform: uppercase;
  font-weight: 600;
  padding: 0 20px;
  font-size: 13px;
  margin-left: 24px;
  @media only screen and (max-width: $breakpoint-tablet) {
    margin-left: 0px;
    width: 100%;
    margin-top: 0px;
  }
}

#mc_embed_signup .button:hover {
  background-color: #efce4a;
  color: white;
  border: 1px solid white;
}

#mergeRow-gdpr {
  margin-top: 20px;
}

#mergeRow-gdpr fieldset label {
  font-weight: normal;
}

#mc-embedded-subscribe-form .mc_fieldset {
  border: none;
  min-height: 0px;
  padding-bottom: 0px;
}

.app-footer {
  background-color: #262626;
  min-height: 200px;
  // margin-top: 32px;
  padding: 15px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;

  .wrap {
    grid-template-columns: auto auto;
    grid-column-gap: 5%;
    @media only screen and (max-width: $breakpoint-tablet) {
      grid-template-columns: 100%;
    }

    .info-menu {
      display: grid;
      grid-template-columns: auto auto auto;
      text-decoration: none;

      @media only screen and (max-width: $breakpoint-tablet) {
        grid-template-columns: auto;
      }

      .info-logo {
        margin-top: 50px;

        @media only screen and (max-width: $breakpoint-tablet) {
          text-align: center;
        }
      }

      .press-logo {
        margin-top: 32px;
        @media only screen and (max-width: $breakpoint-tablet) {
          text-align: center;
          margin-bottom: 32px;
        }
      }

      .about-title {
        border-bottom: solid 2px #efce4a;
        display: inline;
        padding-bottom: 6px;
      }
    }

    .contact {
      margin-top: 50px;
      text-align: left;
      @media only screen and (max-width: $breakpoint-tablet) {
        margin-top: 25px;
      }
    }

    .contact-icon {
      margin-top: 16px;
    }

    .icon-img {
      margin-right: 20px;
      @media only screen and (max-width: $breakpoint-tablet) {
        margin-right: 5px;
      }
    }

    @media only screen and (max-width: $breakpoint-tablet) {
      grid-template-columns: 100%;
      padding: 0 16px;
      max-width: 100%;

      .contact {
        text-align: left;
        padding-bottom: 32px;
      }
    }
  }

  h3 {
    color: #efce4a;
    font-size: 18px;
    font-weight: 400;
    text-transform: uppercase;
  }

  p,
  li {
    color: white;
  }

  ul,
  li {
    margin: 0;
    padding: 0;
    list-style-type: none;
  }

  a {
    color: white;
    text-decoration: none;
  }

  .body-1 {
    font-size: 15px;
  }

  .contact {
    text-align: right;
    font-size: 15px;
  }

  .social-icon {
    width: 30px;
  }

  .follow li {
    display: inline;
  }

  .follow-space {
    padding-left: 30px;
  }

  @media (max-width: 950px) {
    #mc_embed_signup input.email {
      width: 100%;
    }
  }

  .legalmenu {
    font-size: 13px;
    margin-top: 20px;
  }
}

.mt-0 {
  margin-top: 0px !important;
}
</style>
