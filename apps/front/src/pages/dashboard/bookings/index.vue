<template>
  <div class="bookings">
    <div
      id="wrap"
      class="wrap">
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
              @click="filterBookings('declined')">
              {{ $t("dashboard.bookings.refused") }} ({{ decline_count }})
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
                <div class="booking-info">

                  <nuxt-link
                    :to="{
                      name: 'Offer',
                      params: {
                        id: booking.offer.id,
                        slug: booking.offer.slug,
                        domaine: residenceType(booking.offer.residence_type)
                      }
                    }"
                    target="_blank"
                  >
                    <p class="nameOffer"> {{ booking.offer.name }} </p>
                  </nuxt-link>

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
                    {{ $t("booking.card.email") }}
                    <b
                      v-if="
                        booking.status === 'pending' ||
                          booking.status === 'declined'
                      "
                      class="blur"
                    >example@gmail.com</b
                    >
                    <b v-else>{{ booking.client.user.email }}</b>
                  </span>

                  <span v-if="booking.client.user">
                    {{ $t("booking.card.phone") }}
                    <b
                      v-if="
                        booking.status === 'pending' ||
                          booking.status === 'declined'
                      "
                      class="blur"
                    >0474322020</b
                    >
                    <b v-else>{{
                      booking.contact_number
                    }}</b>
                  </span>

                  <span
                  >{{ $t("booking.card.arrival") }}
                    <b>{{ booking.arrival_date }}</b> à
                    <b
                    >{{ booking.offer.arriving_time }}H{{
                      booking.offer.arriving_min_time
                    }}0</b
                    >
                  </span>

                  <span
                  >{{ $t("booking.card.departure") }}
                    <b>{{ booking.departure_date }}</b> à
                    <b
                    >{{ booking.offer.departure_time }}H{{
                      booking.offer.departure_min_time
                    }}0</b
                    >
                  </span>

                  <span
                  >{{ $t("booking.card.number") }}
                    <b
                    >{{
                      $tc("booking.card.people", booking.people_count, {
                        number: booking.people_count
                      })
                    }}
                  </b></span
                  >
                </div>

                <p>
                  Message: <br >
                  {{ booking.message }}
                </p>

                <hr >

                <div class="price-info">
                  <span
                  >{{ $t("booking.card.price") }}
                    <b>{{ booking.sub_total | currency }}</b>
                  </span>
                  <span
                  >{{ $t("booking.card.commission") }}
                    <b>{{ booking.commission_fee | currency }}</b>
                  </span>
                  <span
                  >{{ $t("booking.card.total") }}
                    <b>{{
                      (booking.sub_total - booking.commission_fee) | currency
                    }}</b>
                  </span>
                </div>

                <div v-if="hasHousework(booking)">
                  <p class="services-title"><b>Frais de ménage à payer sur place : {{ booking.housework_price }}€ (prévoir chèque ou liquide)</b></p>
                </div>
                <div
                  v-else
                  class="services-info">
                  <p class="services-title"><b>{{ $t("booking.titles.services") }}</b></p>

                  <div v-if="hasBreakfast(booking.offer.offer_service, booking)">
                    <p>{{ $t("booking.services.breakfast") }} {{ booking.breakfast_total | currency }}</p>
                  </div>

                  <div v-if="hasCleaning(booking.offer.offer_service, booking)">
                    <p>{{ $t("booking.services.cleaning") }} {{ booking.cleaning_total | currency }}</p>
                  </div>

                  <div v-if="hasLinens(booking.offer.offer_service, booking)">
                    <p>{{ $t("booking.services.bedding") }} {{ booking.linens_total | currency }}</p>
                  </div>

                </div>

                <div class="state-info">
                  <p>
                    <b
                    >{{ $t("booking.card.state") }}
                      {{ $t("global.status." + booking.status) }}</b
                      >
                  </p>
                  <br >
                </div>
                <div class="buttons">
                  <!-- <a
                    v-if="booking.status === 'payed' && isStripe && !isManaged(booking)"
                    type="button"
                    class="btn btn-green"
                    style="width: 135px;"
                    @click="cancelBooking(booking)"
                  >
                    {{ $t("booking.demand.canceledFarmer") }}
                  </a>

                  <a
                    v-if="booking.status === 'confirmed' && isStripe && !isManaged(booking)"
                    type="button"
                    class="btn btn-green"
                    style="width: 135px;"
                    @click="cancelBooking(booking)"
                  >
                    {{ $t("booking.demand.canceledFarmer") }}
                  </a> -->

                  <a
                    v-if="booking.status === 'pending' && isStripe && !isManaged(booking)"
                    type="button"
                    class="btn btn-green"
                    style="width: 135px;"
                    @click="confirmBooking(booking)"
                  >
                    {{ $t("booking.card.accept") }}
                  </a>

                  <a
                    v-if="booking.status === 'pending' && isStripe && !isManaged(booking)"
                    type="button"
                    class="btn btn-green"
                    style="width: 135px;"
                    @click="declineBooking(booking)"
                  >
                    {{ $t("booking.card.refuse") }}
                  </a>

                  <nuxt-link
                    :to="{
                      name: 'ChatRoomFarmer',
                      params: {
                        id: booking.offer.id,
                        booking: booking.id
                      }
                    }"
                    class="btn btn-green"
                  >

                    {{ $t("booking.demand.contactClient") }}
                  </nuxt-link>

                  <nuxt-link
                    :to="{
                      name: 'BookingFarmer',
                      params: {
                        id: booking.id
                      }
                    }"
                    class="btn btn-green"
                  >{{ $t("dashboard.bookings.see_farmer") }}</nuxt-link
                  >

                  <nuxt-link
                    v-if="booking.status === 'finished' && booking.farmer_reviews.length < 1"
                    :to="{
                      name: 'NewFarmerReview',
                      params: {
                        booking: booking.id
                      }
                    }"
                    class="btn btn-green"
                  >Ajouter un avis</nuxt-link
                  >

                  <nuxt-link
                    v-if="isStripe && booking.status === 'declined'"
                    :to="{
                      name: 'EditOfferCalendar',
                      params: {
                        id: booking.offer_id
                      }
                    }"
                    class="btn btn-green"
                    style=""
                    target="_blank"
                  >
                    {{ $t("booking.card.calendar") }}
                  </nuxt-link>
                </div>

                <div class="stripe-info">
                  <div
                    v-if="!isStripe"
                    class="payment-box">
                    <p>
                      🚀<b
                      >{{ $t("booking.card.stripe_info_first") }}
                        <a
                          href="https:stripe.com/fr/customers#b2b-platforms"
                          target="_blank"
                        >Stripe</a
                      >{{ $t("booking.card.stripe_info_second") }}</b
                      >🚀
                    </p>
                    <div style="display: flex">
                      <a
                        :href="booking.offer.farmer.stripe_link"
                        class="btn btn-green"
                        style=""
                      >{{ $t("booking.card.complete") }}
                      </a>
                      <a
                        v-if="booking.status === 'pending' && !isStripe && !isManaged(booking)"
                        type="button"
                        class="btn btn-green"
                        style="width: 135px; margin-left: 10px"
                        @click="declineBooking(booking)"
                      >
                        {{ $t("booking.card.refuse_stripe") }}
                      </a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div v-else>
            <p class="body-1">
              {{ $t("dashboard.bookings.no_booking") }}
            </p>

            <img
              src="~assets/img/booking/empty.svg"
              alt="empty"
              class="empty"
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
  name: 'Bookings',
  components: {
    Cloudinary,
    BookingCheckout
  },
  middleware: 'auth',
  head () {
    return {
      title: 'Tableau de bord'
    }
  },
  data () {
    return {
      bookings: []
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
      var confirms = []
      this.bookings.map(function (value, key) {
        if (value.status === 'payed') {
          confirms.push(value)
        }
      })
      return `${confirms.length}`
    },
    decline_count () {
      var declines = []
      this.bookings.map(function (value, key) {
        if (value.status === 'declined') {
          declines.push(value)
        }
      })
      return `${declines.length}`
    },
    cancel_count () {
      var cancels = []
      this.bookings.map(function (value, key) {
        if (value.status === 'cancelled') {
          cancels.push(value)
        }
      })
      return `${cancels.length}`
    },
    isStripe () {
      if (this.$auth.user.farmer.payments_authorisation === true) {
        return true
      } else {
        return false
      }
    }
  },
  created () {
    this.$parent.$parent.expl = false
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
  },
  methods: {
    resetFilter () {
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
    },
    filterBookings (state) {
      if (this.$auth.loggedIn) {
        this.$wait.start('fetching bookings')
        this.$axios
          .$get(`/farmers/${this.$auth.user.farmer.id}/bookings`, { params: { status: state } })
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
    },
    isManaged (booking) {
      if (booking.offer.manager === true) {
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
            status: 'withdraw_agri'
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
    confirmBooking (booking) {
      this.$wait.start('update booking statut')
      this.$axios
        .put(`/bookings/${booking.id}`, {
          booking: {
            status: 'confirmed'
          }
        })
        .then(res => {
          if (res.status === 200) {
            if (res.data) {
              this.$set(booking, 'status', res.data.status)
            }
          }
          this.$toast.success({
            title: 'Réservation confirmé',
            message: 'Votre réservation est confirmé.',
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
    },
    declineBooking (booking) {
      this.$wait.start('update booking statut')
      if (confirm('Êtes-vous certain de vouloir refuser la réservation ?')) {
        this.$axios
          .put(`/bookings/${booking.id}`, {
            booking: {
              status: 'declined'
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
              message: 'Votre réservation est refusé.',
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
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

#wrap {
  @media only screen and (max-width: $breakpoint-tablet) {
    min-height: 1250px;
  }
}

.empty {
  margin-left: 25%;
}

hr {
  border-top: 1px solid $agri-green;
}

.state-info {
  display: grid;
  grid-template-columns: 350px 350px 350px;
  @media only screen and (max-width: $breakpoint-mobile-l) {
    grid-template-columns: auto;
    grid-row-gap: 1em;
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
  margin: 0;
  padding: 8px 10px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  box-shadow: 0px 0px 5px black;
  width: 33% !important;
  @media only screen and (max-width: $breakpoint-tablet) {
    font-size: 16px !important;
    width: 70% !important;
    margin: 0 auto 18px auto !important;
  }
}

.booking-title {
  font-size: 26px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  color: $agri-green;
  font-weight: bold;
}
.buttons {
  display: flex;
  justify-content: space-between;
  @media only screen and (max-width: $breakpoint-tablet) {
    flex-direction: column;
    margin: 0 auto !important;
    justify-content: center;
  }
  .btn-green {
    background-color: $agri-green-light !important;
    border: solid 1px #ffffff;
    color: #ffffff;
    border-radius: 50px;
    font-size: 20px;
    font-weight: 900;
    line-height: 27px;
    margin: 0;
    padding: 8px 10px;
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    box-shadow: 0px 0px 5px black;
    width: 24% !important;
    @media only screen and (max-width: $breakpoint-tablet) {
      font-size: 16px !important;
      width: 100% !important;
      margin: 0 auto 18px auto !important;
    }
  }
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
  @media only screen and (max-width: $breakpoint-laptop-l) {
    min-height: 640px;
  }
}

.bookings-list {
  display: grid;
  grid-template-columns: auto;
  grid-gap: 30px;
}
.blur {
  filter: blur(0.4rem);
}

.booking-item {
  max-height: 680px;
  box-shadow: 1px 1px 12px #555;
  border-radius: 15px;
  padding: 10px;

  display: grid;
  grid-template-columns: 20% 80%;
  grid-gap: 20px;

  @media only screen and (max-width: $breakpoint-mobile-l) {
    grid-template-columns: auto;
    min-height: 1070px;
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
  color: $agri-green;
  padding-right: 30px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  @media only screen and (max-width: $breakpoint-tablet) {
    padding: 0 !important;
  }
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

.services-info {
  display: grid;
  grid-template-columns: auto auto auto auto auto;
}

.services-title {
  text-decoration: underline;
}
.nameOffer {
  text-transform: uppercase;
  font-weight: bold;
  text-decoration: none;
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
