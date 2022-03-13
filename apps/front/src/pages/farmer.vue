<template>
  <div class="farmer">
    <div class="intro">
      <div class="intro-box">
        <h1 class="welcome-msg">
          {{ $t("farmer.profile.welcomeTo") }} {{ getFarmer.user.first_name }}
          {{ getFarmer.user.last_name }}
        </h1>
        <p class="intro-msg">
          {{ $t("farmer.infos.my") }} {{ getFarmer.user.first_name }}, {{ $t("farmer.infos.member") }}
          {{ sub_date }}.
        </p>
      </div>

      <div class="intro-box">
        <p
          v-if="getFarmer.description"
          class="intro-desc">
          {{ getFarmer.description }}
        </p>
        <p
          v-else
          class="intro-desc">
          {{ $t("farmer.paragraphs.welcome") }}
          <br >
          {{ $t("farmer.paragraphs.discovery") }}
          <br >
          {{ $t("farmer.paragraphs.request") }}
        </p>
      </div>
    </div>

    <div class="farmer-container">
      <div class="aside-content">
        <div class="farmer-box">
          <div class="offer-card-image">
            <cloudinary
              v-if="getFarmer.pictures.length"
              :public-id="getFarmer.pictures[0].public_id"
              :itemkey="getFarmer.id.toString()"
              :transformations="{
                w: 80,
                h: 80,
                c: 'fill',
                f: 'jpg',
                fl: 'progressive'
              }"
              :alt="getFarmer.first_name"
            />

            <div v-else>
              <img
                src="~assets/img/user/farmer.svg"
                class="default-profile"
                title="profile"
                alt="profile"
              >
            </div>
          </div>

          <nuxt-link
            v-if="$auth.loggedIn && isFarmer"
            :to="{
              name: 'EditFarmerPicture',
              params: {
                id: $auth.user.farmer.id
              }
            }"
            class="link edit-picture-link"
          >
            {{ $t("farmer.profile.change_profile_picture") }}
          </nuxt-link>

          <p class="profile-name">
            <b>{{ getFarmer.user.first_name }} {{ $t("farmer.infos.provide") }}</b>
          </p>

          <div class="info-profile">
            <p>
              <i
                class="check material-icons check-icon"
                aria-hidden="true"
              >check</i
              >
              {{ $t("farmer.infos.email") }}
            </p>
            <p v-if="$auth.loggedIn && isFarmer">
              {{ getFarmer.user.email }}
            </p>
            <p>
              <i
                class="check material-icons check-icon"
                aria-hidden="true"
              >check</i
              >
              {{ $t("farmer.infos.phone") }}
            </p>
            <p v-if="$auth.loggedIn && isFarmer">
              {{ getFarmer.user.cellphone }}
            </p>
            <p
              v-if="$auth.loggedIn && isFarmer"
              class="edit-info">
              <span style="color: #476458;">&#9432;</span>
              <em
              >{{ $t("farmer.paragraphs.edit") }}</em
              >
            </p>

            <div class="orga-box">
              <img
                v-if="hasOrga && isBretagne"
                src="~assets/img/logo/adb-black.png"
                class="orga-img"
                title="agriculteurs de bretagne"
                alt="agriculteurs de bretagne"
              >

              <img
                v-if="hasOrga && isFaireFrance"
                src="~assets/img/logo/faire-france.png"
                class="orga-img"
                title="Faire France"
                alt="fairefrance"
              >

              <img
                v-if="hasOrga && isBbc"
                src="~assets/img/logo/bleublanccoeur.png"
                class="orga-img"
                title="Bleu Blanc Coeur"
                alt="bleublanccoeur"
              >
            </div>

            <nuxt-link
              v-if="$auth.loggedIn && isFarmer"
              :to="{
                name: 'EditFarmer',
                params: {
                  id: $auth.user.farmer.id
                }
              }"
              class="btn btn-agri-yellow"
            >
              {{ $t("farmer.buttons.edit") }}
            </nuxt-link>
          </div>
        </div>
      </div>

      <div class="main-content">
        <div class="first-content">
          <div
            v-if="$auth.loggedIn && isFarmer"
            class="bookings-box">
            <div class="annonce-box">
              <p>{{ $t("farmer.bookings.titleRequest") }}</p>
            </div>

            <div
              v-for="(booking, k) in computedBookings"
              :key="k">
              <div class="booking-infos">
                <p class="booking-name">{{ booking.offer.name }}</p>
                <p class="booking-date">{{ booking.arrival_date }}</p>
                <p class="booking-person">
                  {{ booking.client.user.first_name }}
                  {{ booking.client.user.last_name }} {{ $t("farmer.bookings.booked") }}
                </p>
                <p class="booking-status">{{ $t("booking.card.state") }} {{ $t("global.status." + booking.status) }}</p>
              </div>

              <hr class="hr-booking" >
            </div>

            <nuxt-link
              v-if="$auth.loggedIn && isFarmer"
              :to="{
                name: 'DashboardBookings'
              }"
              class="btn btn-agri-yellow"
            >
              {{ $t("farmer.buttons.bookings") }}
            </nuxt-link>
          </div>

          <div
            v-if="$auth.loggedIn && isFarmer"
            class="messenger-box">
            <div class="annonce-box">
              <p>{{ $t("farmer.bookings.messenger") }}</p>

              <messaging />

              <nuxt-link
                v-if="$auth.loggedIn && isFarmer"
                :to="{
                  name: 'Messenger'
                }"
                class="btn btn-agri-yellow"
              >
                {{ $t("farmer.bookings.messenger") }}
              </nuxt-link>
            </div>
          </div>
        </div>

        <div class="offers-box">
          <div class="annonce-box-offers">
            <p>{{ $t("farmer.bookings.published") }}</p>
            <nuxt-link
              v-if="$auth.loggedIn && isFarmer"
              :to="{
                name: 'NewOffer'
              }"
              class="btn btn-agri-yellow"
            >
              {{ $t("farmer.buttons.offer") }}
            </nuxt-link>
          </div>

          <div
            v-if="getFarmer.offers.length"
            class="items">
            <div
              v-for="(offer, k) in getFarmer.offers"
              :key="k"
            >
              <div v-if="$auth.loggedIn && isFarmer">
                <offer-card-private :offer="offer" />
              </div>
              <div v-else>
                <offer-card :offer="offer" />
              </div>
            </div>
          </div>
          <nuxt-link
            v-if="$auth.loggedIn && isFarmer"
            id="allOffers"
            :to="{
              name: 'DashboardOffers'
            }"
            class="btn btn-agri-yellow"
          >
            {{ $t("farmer.bookings.allOffer") }}
          </nuxt-link>
        </div>

        <div
          v-if="$auth.loggedIn && isFarmer"
          class="offers-box">
          <div class="annonce-box-activities">
            <p>{{ $t("farmer.bookings.discovery") }}</p>
          </div>

          <div
            v-if="getFarmer.activities.length"
            class="items">
            <div
              v-for="(activity, k) in getFarmer.activities"
              :key="k"
            >
              <div v-if="$auth.loggedIn && isFarmer">
                <activity-card-private :activity="activity" />
              </div>
              <div v-else>
                <activity-card :activity="activity" />
              </div>
            </div>
          </div>
          <nuxt-link
            v-if="$auth.loggedIn && isFarmer"
            id="newAct"
            :to="{
              name: 'NewActivity'
            }"
            class="btn btn-agri-yellow"
          >
            {{ $t("farmer.buttons.activities") }}
          </nuxt-link>
        </div>

        <div class="engagements">

          <h2 class="engagement-title">Les engagements de l’agriculteur auprès des voyageurs :</h2>

          <h3 class="engagement-title">1- Partager son métier lors de son séjour :</h3>

          <p class="engagement-msg">
            Lors de votre visite à la  ferme, les agrculteurs partageront leur amour pour leur métier. <br> Chaque ferme à son histoire, et vous aurez la chance de la découvrir.
          </p>

          <h3 class="engagement-title">2- Louer un hébergement au coeur d’une exploitation agricole :</h3>

          <p class="engagement-msg">
            Lors de votre visite à la  ferme, les agrculteurs partageront leur amour pour leur métier. <br> Chaque ferme à son histoire, et vous aurez la chance de la découvrir.
          </p>

          <h3 class="engagement-title">3- Être récaif pour répondre à vos questions et vos demandes de résevrations :</h3>

          <p class="engagement-msg">
            Rendez-vous sur les offres des agriculteurs pour vous lancer dans la réservation d’un séjour à la ferme. <br> L’agriculteur aura alors 24h00 pour vous répondre. <br> Pour info ils sont souvent bien plus rapide !
          </p>

        </div>

      </div>
    </div>
  </div>
</template>

<script>
import moment from 'moment'
import { mapGetters } from 'vuex'
import OfferCard from '@/components/OffersList/_subs/OfferCard'
import OfferCardPrivate from '@/components/OffersList/_subs/OfferCardPrivate'
import ActivityCard from '@/components/ActivitiesList/_subs/ActivityCard'
import ActivityCardPrivate from '@/components/ActivitiesList/_subs/ActivityCardPrivate'
import FarmerEquipments from '@/components/Farmer/FarmerEquipments'
import Cloudinary from '@/components/Cloudinary'
import Messaging from '@/components/Messaging.vue'

export default {
  name: 'FarmerProfile',
  components: {
    OfferCardPrivate,
    OfferCard,
    ActivityCard,
    ActivityCardPrivate,
    FarmerEquipments,
    Cloudinary,
    Messaging
  },
  props: {
    farmer: {
      type: Object,
      default: null
    }
  },
  head () {
    return {
      name: 'FarmerProfile',
      title: 'Séjour à la ferme-' + this.getFarmer.user.first_name + '-Agriculteur-' + this.getFarmer.id,
      meta: [
        {
          hid: 'description',
          name: 'description',
          content: 'AgriVillage est une plateforme dédiée à l’agritourisme. Séjournez à la ferme chez ' + this.getFarmer.user.first_name + ' ' + this.getFarmer.user.last_name + ' et participer à une activité typique de votre destination.'
        }
      ]
    }
  },
  data () {
    return {
      offers: [],
      bookings: [],
      limit: 3
    }
  },
  fetch ({ store, app, route, error }) {
    return app.$axios
      .get(`/farmers/${route.params.id}`)
      .then(res => {
        if (res.status === 200) {
          store.dispatch('setFarmer', res.data)
        }
      })
      .catch(() => {
        error({
          statusCode: 404,
          message: "Cette agriculteur n'existe pas ou plus"
        })
      })
  },
  computed: {
    ...mapGetters(['getFarmer', 'isFarmer']),
    computedBookings () {
      return this.limit ? this.bookings.slice(0, this.limit) : this.bookings
    },
    initials () {
      return `${this.getFarmer.user.first_name.charAt(
        0
      )}${this.getFarmer.user.last_name.charAt(0)}`
    },
    sub_date () {
      return moment(this.getFarmer.user.created_at)
        .locale('fr')
        .format('L')
    },
    count () {
      var published = []
      this.getFarmer.offers.map(function (value, key) {
        if (value.state === 'published') {
          published.push(value)
        }
      })
      return `${published.length}`
    },
    hasOrga () {
      if (this.getFarmer.organisation === true) {
        return true
      } else {
        return false
      }
    },
    isBretagne () {
      if (this.getFarmer.organisation.adb === true) {
        return true
      } else {
        return false
      }
    },
    isFaireFrance () {
      if (this.getFarmer.organisation.fairefrance === true) {
        return true
      } else {
        return false
      }
    },
    isBbc () {
      if (this.getFarmer.organisation.bbc === true) {
        return true
      } else {
        return false
      }
    }
  },
  mounted () {
    if (this.$auth.loggedIn) {
      this.$wait.start('fetching bookings')
      this.$axios
        .$get(`/farmers/${this.$auth.user.farmer.id}/bookings`)
        .then(res => {
          this.bookings = res.map(booking => ({
            ...booking,
            arrival_date: moment(booking.arrival_date)
              .locale('fr')
              .format('L'),
            departure_date: moment(booking.departure_date)
              .locale('fr')
              .format('L')
          }))
        })
        .finally(() => {
          this.$wait.end('fetching bookings')
        })
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.engagement-title {
  color: $agri-green;
  font-weight: bold;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.engagement-msg {
  color: $agri-green;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.offers-box {
  border: 1px solid grey;
  border-radius: 25px;
  padding: 20px;
  margin-top: 1em;
  @media only screen and (max-width: $breakpoint-tablet) {
    margin-top: 5em;
  }
}

#allOffers {
  width: 50%;
  margin: 0 auto;
  box-shadow: none;
  margin-top: 10%;
  @media only screen and (max-width: $breakpoint-tablet) {
    /* position: absolute;
    bottom: 0;
    right: 0;
    box-shadow: none; */
    width: 100%;
    margin-top: 15%;
    box-shadow: none;
  }
}
#newAct {
  width: 50%;
  margin: 0 auto;
  box-shadow: none;
  margin-top: 10%;
  @media only screen and (max-width: $breakpoint-tablet) {
    /* position: absolute;
    bottom: 0;
    right: 0;
    box-shadow: none; */
    width: 100%;
    margin-top: 15%;
    box-shadow: none;
  }
}

.messenger-box {
  border: 1px solid grey;
  border-radius: 25px;
  padding: 20px;
  height: 100%;
  @media only screen and (max-width: $breakpoint-mobile-l) {
    margin-top: 20vw;
  }
}

.bookings-box {
  border: 1px solid grey;
  border-radius: 25px;
  padding: 20px;
  /* max-height: 550px; */
  height: 100%;
}

.booking-infos {
  display: grid;
  grid-template-columns: auto auto;
  grid-column-gap: 1em;
}

.booking-name {
  color: black;
  font-weight: bold;
  font-size: 15px;
}

.booking-date {
  color: black;
  font-weight: bold;
  font-size: 15px;
}

.booking-person {
  color: $agri-green;
  font-size: 10px;
}

.booking-status {
  font-size: 14px;
}

.hr-booking {
  width: 50%;
}

.orga-box {
  display: grid;
  grid-template-columns: auto auto auto;
  margin-bottom: 2vh;
}

.orga-img {
  width: 100px;
  height: 100px;
}

.intro {
  margin-left: 18vw;
  margin-right: 18vw;

  display: grid;
  grid-template-columns: auto auto;
  grid-gap: 10ch;

  @media only screen and (max-width: $breakpoint-tablet) {
    grid-template-columns: auto;
    grid-row-gap: 2ch;
    margin-bottom: 5vw;
  }
}

.edit-info {
  font-size: 12px;
}

.default-profile {
  width: 80px;
  height: 80px;
  border-radius: 100%;
}

.edit-picture-link {
  font-size: 13px;
  color: $agri-green;
  font-weight: bold;
  text-decoration: none;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.profile-name {
  font-size: 16px;
  font-weight: bold;
  color: $agri-green;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.info-profile {
  font-size: 15px;
  color: $agri-green;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.offer-card {
  display: flex;
  flex-direction: column;
  text-decoration: none;
  position: relative;
  @media only screen and (max-width: $breakpoint-tablet) {
    position: relative;
  }

  &-image {
    display: flex;
    height: 80px;
    width: 80px;
    border-radius: 6px;
    margin-bottom: 6px;
    margin: auto;

    .cloudinary {
      display: flex;
      width: 80px;
      height: 80px;
      object-fit: cover;
      border-radius: 100%;
      overflow: hidden;
    }

    &__empty {
      display: flex;
      flex-direction: column;
      color: rgba(black, 0.5);
      margin: auto;
    }
  }
}

.app-avatar {
  background-color: #eaeaea;
  color: rgba(black, 0.86);
  border-radius: 100%;
  width: 80px;
  height: 80px;
  text-align: center;
  line-height: 80px;
  text-transform: uppercase;
}

.welcome-msg {
  padding-top: 35px;
  color: $agri-green;
  font-weight: bold;
  font-size: 16px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.intro-msg {
  font-size: 14px;
  color: $agri-green;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.intro-desc {
  font-size: 14px;
  color: $agri-green;
  margin-top: 4vw;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.check {
  background-color: $agri-green;
  color: white;
  width: 20px;
  height: 20px;
  line-height: 20px;
  border-radius: 100%;
  font-size: 20px;
  bottom: -5px;
  right: -5px;
}

.items {
  display: grid;
  grid-template-columns: 50% 50%;
  grid-gap: 16px;
  position: relative;

  @media only screen and (max-width: $breakpoint-mobile-large) {
    grid-template-columns: 100%;
  }
}

.farmer-box {
  position: unset !important;
  border-radius: 25px;
  padding: 32px;
  box-shadow: 1px 1px 12px #555;
  text-align: center;
}

.annonce-box {
  color: $agri-green;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  text-transform: uppercase;
  font-weight: bold;
  text-align: center;
}

.annonce-box-offers {
  display: flex;
  justify-content: space-between;

  color: $agri-green;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  text-transform: uppercase;
  font-weight: bold;
  text-align: center;
  @media only screen and (max-width: $breakpoint-tablet) {
    display: flex;
    flex-direction: column;
    align-items: center;
    grid-template-columns: none;
    margin-bottom: 10%;
  }
}

.annonce-box-activities {
  display: flex;
  justify-content: space-between;

  color: $agri-green;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  text-transform: uppercase;
  font-weight: bold;
  text-align: center;
  @media only screen and (max-width: $breakpoint-tablet) {
    display: flex;
    justify-content: center;
    flex-direction: column;
    align-items: center;
    margin-bottom: 10%;
  }
}

.farmer {
  &-container {
    margin-bottom: 50px;
    display: grid;
    grid-template-columns: 7fr 10fr;
    grid-gap: 60px;

    background-color: white;
    padding-right: 50px;
    padding-left: 50px;
    margin-left: 10vw;
    margin-right: 10vw;
    padding-bottom: 70px;

    margin-bottom: 0px;

    @media only screen and (max-width: $breakpoint-laptop-l) {
      margin-left: 0vw;
      margin-right: 0vw;
    }

    @media only screen and (max-width: $breakpoint-laptop-m) {
      margin-left: 0px;
      margin-right: 0px;
    }

    @media only screen and (max-width: $breakpoint-tablet) {
      grid-template-columns: 1fr;
      padding: 16px;
    }
  }

  .side-content {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    grid-gap: 16px;

    @media only screen and (max-width: $breakpoint-laptop-m) {
      grid-template-columns: 1fr;
    }
  }

  .first-content {
    display: grid;
    grid-template-columns: auto auto;
    grid-column-gap: 1em;
    margin-bottom: 2em;

    @media only screen and (max-width: $breakpoint-tablet) {
      grid-template-columns: auto;
    }

    .body-1 {
      font-size: 16px;
    }
  }
}
</style>
