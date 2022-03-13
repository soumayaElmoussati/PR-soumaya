<template>
  <div class="bookings">
    <div class="wrap">
      <div class="dashboard">
        <div v-if="$wait.is('fetching bookings')">
          <h3 class="booking-title inline">
            {{ $t("dashboard.bookings.loading") }}
          </h3>
        </div>

        <div v-else>
          <h2 class="booking-title inline">
            {{ $t("dashboard.bookings.my_bookings") }} :
          </h2>
          <p class="counters inline">
            <button
              type="button"
              class="filter-button btn-status"
              @click="filterBookings('pending')">
              {{ $t("dashboard.bookings.pending") }} ({{ pending_count }})
            </button>
            <button
              type="button"
              class="filter-button btn-status"
              @click="filterBookings('confirmed')">
              {{ $t("dashboard.bookings.confirmed") }} ({{ confirm_count }})
            </button>
            <button
              type="button"
              class="filter-button btn-status"
              @click="filterBookings('payed')">
              {{ $t("dashboard.bookings.payed") }} ({{ payed_count }})
            </button>
            <button
              type="button"
              class="filter-button btn-status"
              @click="filterBookings('cancelled')">
              {{ $t("dashboard.bookings.canceled") }} ({{ cancel_count }})
            </button>
            <button
              type="button"
              class="filter-button btn-status"
              @click="resetFilter">
              Effacer les filtres
            </button>
          </p>

          <div
            v-if="bookings.length"
            class="bookings-list">
            <div
              v-for="(booking, k) in bookings"
              :key="k"
              class="booking-item">
              <div class="picture-box">
                <cloudinary
                  v-if="booking.offer.offer_pictures.length"
                  :public-id="booking.offer.offer_pictures[0].public_id"
                  :itemkey="booking.offer.id.toString()"
                  :transformations="{
                    w: 190,
                    h: 230,
                    c: 'fill',
                    f: 'jpg',
                    fl: 'progressive'
                  }"
                  :alt="booking.offer.name"
                />
              </div>

              <div class="infos-box">
                <div
                  v-if="booking.status !== 'confirmed'"
                  class="booking-info">
                  <b>{{ booking.client.user.first_name }}</b> {{ $t("booking.card.booked") }}
                  <b
                  >{{ residenceType(booking.offer.residence_type) }} -
                    {{ booking.offer.address.city }}</b
                    >
                  {{ $t("booking.card.from") }} <b>{{ booking.arrival_date }}</b> {{ $t("booking.card.to") }}
                  <b>{{ booking.departure_date }}</b> {{ $t("booking.card.for") }}
                  <b>{{ booking.people_count }}</b> {{ $t("booking.card.person") }}
                </div>
                <div v-else>
                  <b>{{ booking.client.user.first_name }}</b> {{ $t("booking.card.booked") }}
                  <b>{{ booking.offer.name }}</b> {{ $t("booking.card.from") }}
                  <b>{{ booking.arrival_date }}</b> {{ $t("booking.card.to") }}
                  <b>{{ booking.departure_date }}</b> {{ $t("booking.card.for") }}
                  <b>{{ booking.people_count }}</b> {{ $t("booking.card.person") }}
                </div>

                <div class="client-info">
                  <span v-if="booking.client.user">
                    {{ $t("booking.card.client") }}
                    <b>
                      {{ booking.client.user.first_name }}
                      {{ booking.client.user.last_name }}</b
                      >
                  </span>

                  <span v-if="booking.client.user">
                    {{ $t("booking.card.email") }} <b>{{ booking.client.user.email }}</b>
                  </span>

                  <span
                    v-if="
                      booking.offer.farmer &&
                        booking.status !== 'pending' &&
                        booking.status !== 'cancelled' &&
                        booking.status !== 'declined'
                    "
                  >
                    {{ $t("booking.card.hote") }}
                    <b>
                      {{ booking.offer.farmer.user.first_name }}
                      {{ booking.offer.farmer.user.last_name }}</b
                      >
                  </span>
                  <span
                    v-if="
                      booking.offer.farmer &&
                        booking.status !== 'pending' &&
                        booking.status !== 'cancelled' &&
                        booking.status !== 'declined'
                    "
                  >
                    {{ $t("booking.card.email") }} <b> {{ booking.offer.farmer.user.email }}</b>
                  </span>

                  <span
                    v-if="
                      booking.offer.farmer &&
                        booking.status !== 'pending' &&
                        booking.status !== 'cancelled' &&
                        booking.status !== 'declined'
                    "
                  >
                    {{ $t("booking.card.phone") }} <b> {{ booking.offer.farmer.user.cellphone }}</b>
                  </span>

                  <span
                  >{{ $t("booking.card.arrival") }} <b>{{ booking.arrival_date }}</b> à
                    <b
                    >{{ booking.offer.arriving_time }}H{{
                      booking.offer.arriving_min_time
                    }}0</b
                    >
                  </span>

                  <span
                  >{{ $t("booking.card.departure") }} <b>{{ booking.departure_date }}</b> à
                    <b
                    >{{ booking.offer.departure_time }}H{{
                      booking.offer.departure_min_time
                    }}0</b
                    >
                  </span>
                </div>

                <hr >

                <div class="price-info">
                  <span
                  >{{ $t("booking.card.price") }} <b>{{ booking.total | currency }}</b>
                  </span>
                </div>

                <div class="services-statut">

                  <div v-if="hasHousework(booking)">
                    <p class="services-title"><b>Frais de ménage à payer sur place : {{ booking.housework_price }}€ (prévoir chèque ou liquide)</b></p>
                  </div>
                  <div
                    v-else
                    class="services-info">

                    <p class="services-title"><b>{{ $t("booking.titles.services") }}</b></p>

                    <div
                      v-if="hasBreakfast(booking.offer.offer_service, booking)"
                    >
                      <p v-if="hasBreakfastInclude(booking.offer.offer_service, booking)">{{ $t("booking.services.breakfast") }} <b>Inclus</b></p>
                      <p v-if="!hasBreakfastInclude(booking.offer.offer_service, booking)">{{ $t("booking.services.breakfast") }} {{ booking.breakfast_total | currency }}</p>
                    </div>

                    <div
                      v-if="hasCleaning(booking.offer.offer_service, booking)"
                    >
                      <p v-if="hasCleaningInclude(booking.offer.offer_service, booking)">{{ $t("booking.services.cleaning") }} <b>Inclus</b></p>
                      <p v-if="!hasCleaningInclude(booking.offer.offer_service, booking)">{{ $t("booking.services.cleaning") }} {{ booking.cleaning_total | currency }}</p>
                    </div>

                    <div v-if="hasLinens(booking.offer.offer_service, booking)">
                      <p v-if="hasLinensInclude(booking.offer.offer_service, booking)">{{ $t("booking.services.bedding") }} <b>Inclus</b></p>
                      <p v-if="!hasLinensInclude(booking.offer.offer_service, booking)">{{ $t("booking.services.bedding") }} {{ booking.linens_total | currency }}</p>
                    </div>

                  </div>

                  <p
                    v-if= "booking.client.user &&
                    booking.status === 'pending'">
                    <b>Statut: En attente de validation de l'Agriculteur</b>
                  </p>
                  <p v-else>
                    <b>Statut: {{ $t("global.status." + booking.status) }}</b>
                  </p>
                </div>

                <div class="state-info">
                  <nuxt-link
                    :to="{
                      name: 'ChatRoom',
                      params: {
                        id: booking.offer.id
                      }
                    }"
                    class="btn btn-agri-contact"
                  >
                    {{ $t("booking.demand.contactAgri") }}
                  </nuxt-link>

                  <nuxt-link
                    :to="{
                      name: 'Offer',
                      params: {
                        id: booking.offer.id,
                        slug: booking.offer.slug,
                        domaine: residenceType(booking.offer.residence_type)
                      }
                    }"
                    class="btn btn-agri-contact"
                    target="_blank"
                  >{{ $t("booking.card.see") }}</nuxt-link
                  >

                  <booking-checkout
                    v-if="isPayable(booking)"
                    :booking="booking"
                  />

                  <nuxt-link
                    :to="{
                      name: 'Booking',
                      params: {
                        id: booking.id
                      }
                    }"
                    class="btn btn-agri-contact"
                  >{{ $t("dashboard.bookings.see") }}</nuxt-link
                  >

                  <nuxt-link
                    v-if="booking.status === 'finished' && booking.reviews.length < 1"
                    :to="{
                      name: 'NewReview',
                      params: {
                        booking: booking.id
                      }
                    }"
                    class="btn btn-agri-contact"
                  >Ajouter un avis</nuxt-link
                  >

                  <nuxt-link
                    v-if="
                      booking.status === 'payed' && isManaged(booking.offer) && booking.annexe_services_total === 0
                    "
                    :to="{
                      name: 'TinyBooking',
                      params: {
                        id: booking.offer.id,
                        bookingId: booking.id,
                        slug: residenceType(booking.offer.residence_type)
                      }
                    }"
                    class="btn btn-agri-contact"
                  >{{ $t("booking.services.subtitle") }}</nuxt-link
                  >

                  <button
                    v-if="
                      booking.status !== 'cancelled' &&
                        booking.status !== 'declined' &&
                        booking.status !== 'payed' &&
                        booking.status !== 'allSet' &&
                        booking.status !== 'finished'
                    "
                    type="button"
                    class="btn btn-agri-contact"
                    @click="cancelBooking(booking)"
                  >
                    {{ $t("booking.demand.canceled") }}
                  </button>
                  <button
                    v-if="
                      booking.status === 'payed' || booking.status === 'allSet'
                    "
                    type="button"
                    class="btn btn-agri-contact"
                    @click="cancelWithdrawBooking(booking)"
                  >
                    {{ $t("booking.demand.canceled") }}
                  </button>
                </div>
                <p style="font-style: italic; text-align: right">
                  {{ $t("dashboard.bookings.update") }} {{ booking.updated_at }}
                </p>
              </div>
            </div>
          </div>

          <div v-else>
            <p class="body-1">
              {{ $t("dashboard.bookings.no_booking") }}
            </p>

            <nuxt-link
              :to="{
                name: 'OffersAll'
              }"
              style="width: 250px; margin: 0 !important;"
              class="btn btn-agri-l"
            >
              {{ $t("dashboard.bookings.stay") }}
            </nuxt-link>

            <img
              src="~assets/img/booking/empty.svg"
              class="empty"
              alt="empty"
            >
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import BookingCheckout from '@/components/Offer/BookingCheckout'
import moment from 'moment'
import Cloudinary from '@/components/Cloudinary'

export default {
  name: 'ClientBookings',
  middleware: 'auth',
  components: {
    BookingCheckout,
    Cloudinary
  },
  head () {
    return {
      title: 'Tableau de bord'
    }
  },
  data () {
    return {
      bookings: [],
      isModalVisible: false
    }
  },
  computed: {
    pending_count () {
      var pendings = []
      this.bookings.map(function (value, key) {
        if (value.status === 'pending') {
          pendings.push(value)
        }
      })
      return `${pendings.length}`
    },
    confirm_count () {
      var confirms = []
      this.bookings.map(function (value, key) {
        if (value.status === 'confirmed') {
          confirms.push(value)
        }
      })
      return `${confirms.length}`
    },
    payed_count () {
      var paids = []
      this.bookings.map(function (value, key) {
        if (value.status === 'payed') {
          paids.push(value)
        }
      })
      return `${paids.length}`
    },
    cancel_count () {
      var cancels = []
      this.bookings.map(function (value, key) {
        if (value.status === 'cancelled') {
          cancels.push(value)
        }
      })
      return `${cancels.length}`
    }
  },
  created () {
    this.$parent.$parent.expl = false
  },
  mounted () {
    if (this.$auth.loggedIn) {
      this.$wait.start('fetching bookings')
      this.$axios
        .$get(`/clients/${this.$auth.user.client.id}/bookings`)
        .then(res => {
          this.bookings = res.map(booking => ({
            ...booking,
            arrival_date: moment(booking.arrival_date)
              .locale('fr')
              .format('L'),
            departure_date: moment(booking.departure_date)
              .locale('fr')
              .format('L'),
            updated_at: moment(booking.updated_at)
              .locale('fr')
              .format('L')
          }))
        })
        .finally(() => {
          this.$wait.end('fetching bookings')
        })
    }
  },
  methods: {
    resetFilter () {
      if (this.$auth.loggedIn) {
        this.$wait.start('fetching bookings')
        this.$axios
          .$get(`/clients/${this.$auth.user.client.id}/bookings`)
          .then(res => {
            this.bookings = res.map(booking => ({
              ...booking,
              arrival_date: moment(booking.arrival_date)
                .locale('fr')
                .format('L'),
              departure_date: moment(booking.departure_date)
                .locale('fr')
                .format('L'),
              updated_at: moment(booking.updated_at)
                .locale('fr')
                .format('L')
            }))
          })
          .finally(() => {
            this.$wait.end('fetching bookings')
          })
      }
    },
    filterBookings (state) {
      if (this.$auth.loggedIn) {
        this.$wait.start('fetching bookings')
        this.$axios
          .$get(`/clients/${this.$auth.user.client.id}/bookings`, { params: { status: state } })
          .then(res => {
            this.bookings = res.map(booking => ({
              ...booking,
              arrival_date: moment(booking.arrival_date)
                .locale('fr')
                .format('L'),
              departure_date: moment(booking.departure_date)
                .locale('fr')
                .format('L'),
              updated_at: moment(booking.updated_at)
                .locale('fr')
                .format('L')
            }))
          })
          .finally(() => {
            this.$wait.end('fetching bookings')
          })
      }
    },
    isPayable (booking) {
      if (booking.offer.manager && booking.status === 'confirmed') {
        return true
      } else {
        if (booking.status === 'confirmed' && booking.stripe_token !== null) {
          return true
        }
      }
    },
    isManaged (offer) {
      if (offer.manager) {
        return true
      } else {
        return false
      }
    },
    hasHousework (booking) {
      if (booking.housework && booking.housework_price) {
        return true
      }
    },
    hasBreakfast (services, booking) {
      if (services.breakfast) {
        if (services.breakfastopt && booking.breakfast_opt) {
          return true
        } else if (!services.breakfastopt) {
          return true
        }
      } else {
        return false
      }
    },
    hasBreakfastInclude (service, booking) {
      if (!service.breakfastopt && booking.breakfast_total === 0) {
        return true
      } else {
        return false
      }
    },
    hasLinens (services, booking) {
      if (services.linens) {
        if (services.linensopt && booking.linens_opt) {
          return true
        } else if (!services.linensopt) {
          return true
        }
      } else {
        return false
      }
    },
    hasLinensInclude (service, booking) {
      if (!service.linensopt && booking.linens_total === 0) {
        return true
      } else {
        return false
      }
    },
    hasCleaning (services, booking) {
      if (services.cleaning) {
        if (services.cleaningopt && booking.cleaning_opt) {
          return true
        } else if (!services.cleaningopt) {
          return true
        }
      } else {
        return false
      }
    },
    hasCleaningInclude (service, booking) {
      if (!service.cleaningopt && booking.cleaning_total === 0) {
        return true
      } else {
        return false
      }
    },
    residenceType (residence) {
      // NOTE: Type de logement
      switch (residence) {
        case 'entire_house':
          return 'LogementEntier'
        case 'private_room':
          return 'ChambrePrivee'
        case 'guest_room':
          return 'ChambreDHote'
        case 'unusual_room':
          return 'LogementInsolite'
        case 'tiny_house':
          return 'TinyHouse'
        case 'immersive_house':
          return 'LogementEnImmersion'
      }
    },
    cancelBooking (booking) {
      this.$wait.start('update booking statut')
      if (confirm('Êtes-vous certain de vouloir annuler la réservation ?')) {
        this.$axios
        .put(`/bookings/${booking.id}`, {
          booking: {
            status: 'cancelled'
          }
        })
        .then(res => {
          if (res.status === 200) {
            if (res.data) {
              this.$set(booking, 'status', res.data.status)
            }
          }
          this.$toast.success({
            title: 'Réservation annulé',
            message: 'Votre réservation est annulé.',
            position: 'bottom center',
            timeOut: 3000
          })
        })
        .catch(err => {
          console.error('err', err)
        })
        .finally(() => {
          this.$wait.end('update booking statut')
        })
      }
    },
    cancelWithdrawBooking (booking) {
      this.$wait.start('update booking statut')
      if (confirm('Êtes-vous certain de vouloir annuler la réservation ?')) {
        this.$axios
        .put(`/bookings/${booking.id}`, {
          booking: {
            status: 'withdraw_client'
          }
        })
        .then(res => {
          if (res.status === 200) {
            if (res.data) {
              this.$set(booking, 'status', res.data.status)
            }
          }
          this.$toast.success({
            title: 'Réservation annulé',
            message: 'Votre réservation est annulé.',
            position: 'bottom center',
            timeOut: 3000
          })
        })
        .catch(err => {
          console.error('err', err)
        })
        .finally(() => {
          this.$wait.end('update booking statut')
        })
      }
    },
    showModal () {
      this.isModalVisible = true
    },
    closeModal () {
      this.isModalVisible = false
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.filter-button {
  background: none;
  color: inherit;
  border: none;
  padding: 0;
  font: inherit;
  cursor: pointer;
  outline: inherit;
}

hr {
  border-top: 1px solid $agri-green;
}

.empty {
  margin-left: 25%;
  max-width: 100%;
  @media only screen and (max-width: $breakpoint-mobile-l) {
    margin-left: 0%;
  }
}

.booking-title {
  font-size: 26px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  color: $agri-green;
  font-weight: bold;
}

.counters {
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  color: $agri-green;
  font-size: 16px;
}

.dashboard {
  @media only screen and (max-width: $breakpoint-mobile-m) {
    margin-left: 20px;
    margin-right: 20px;
  }
}

.bookings {
  padding-top: 32px;
  padding-bottom: 32px;
  min-height: 440px;
}

.bookings-list {
  display: grid;
  grid-template-columns: auto;
  grid-gap: 30px;
}

.booking-item {
  min-height: 420px;
  box-shadow: 1px 1px 12px #555;
  border-radius: 15px;
  padding: 10px;

  display: grid;
  grid-template-columns: 20% 80%;
  grid-gap: 20px;

  @media only screen and (max-width: $breakpoint-mobile-l) {
    grid-template-columns: auto;
    height: auto;
    width: 100%;
  }
}

.picture-box {
  @media only screen and (max-width: $breakpoint-mobile-m) {
    display: none;
  }
}

.cloudinary {
  border-radius: 5px !important;
}

.infos-box {
  color: #417267;
  padding-right: 30px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.booking-info {
  font-size: 15px;
  margin-bottom: 30px;
}

.client-info {
  display: grid;
  grid-template-columns: auto auto auto;
  @media only screen and (max-width: $breakpoint-mobile-l) {
    grid-template-columns: auto;
  }
}

.time-info {
  display: grid;
  grid-template-columns: auto auto;
}

.price-info {
  display: grid;
  grid-template-columns: auto auto auto;
  @media only screen and (max-width: $breakpoint-mobile-m) {
    grid-template-columns: auto;
  }
}

.state-info {
  display: grid;
  grid-template-columns: auto auto auto;
  grid-template-rows: auto auto;
  grid-column-gap: 1em;
  grid-row-gap: 1em;
  @media only screen and (max-width: $breakpoint-laptop-generic) {
    grid-template-columns: auto auto;
    grid-row-gap: 2em;
  }
  @media only screen and (max-width: $breakpoint-mobile-m) {
    grid-template-columns: auto;
    grid-row-gap: 2em;
  }
 @media only screen and (max-width: $breakpoint-tablet) {
    grid-template-columns: auto;
    grid-row-gap: 1em;
  }
  .btn {
    font-size: 16px;
    width: 92%;
    @media only screen and (max-width: $breakpoint-tablet) {
      width: 92%;
    }
  }
}

.services-statut {
  display: flex;
  justify-content: space-between;

  .services-info {
    display: grid;
    grid-template-columns: auto auto auto auto auto;
    gap: 1em;
  }

}

.services-title {
  text-decoration: underline;
}

.btn-status {
  background-color: white;
  border: 2px solid $agri-green;
  color: black;
  padding: 10px 15px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 14px;
  margin: 4px 2px;
  transition-duration: 0.4s;
  cursor: pointer;
}

.btn-status:hover {
  background-color: $agri-green;
  color: white;
}
</style>
