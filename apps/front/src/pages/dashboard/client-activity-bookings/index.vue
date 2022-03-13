<template>
  <div class="bookings">
    <div class="wrap">

      <div class="dashboard">
        <h2 class="booking-title inline">
          {{ $t("dashboard.bookings.my_bookings") }}
        </h2>
        <p class="counters inline">
          {{ $t("dashboard.bookings.pending") }} ({{ pending_count }}) {{ $t("dashboard.bookings.confirmed") }} ({{ confirm_count }}) {{ $t("dashboard.bookings.canceled") }} ({{ cancel_count }})
        </p>

        <div
          v-if="activity_bookings.length"
          class="bookings-list"
        >
          <div
            v-for="(booking, k) in activity_bookings"
            :key="k"
            class="booking-item"
          >

            <div class="picture-box">

              <cloudinary
                v-if="booking.activity.activity_pictures.length"
                :public-id="booking.activity.activity_pictures[0].public_id"
                :itemkey="booking.activity.id.toString()"
                :transformations="{
                  w: 190,
                  h: 230,
                  c: 'fill',
                  f: 'jpg',
                  fl: 'progressive'
                }"
                :alt="booking.activity.name"
              />

            </div>

            <div class="infos-box">

              <div class="booking-info">

                <b>{{ booking.client.user.first_name }}</b> {{ $t("booking.card.booked") }} <b>{{ booking.activity.name }}</b> {{ $t("booking.card.from") }} <b>{{ booking.arrival_date }}</b> {{ $t("booking.card.to") }} <b>{{ booking.departure_date }}</b> {{ $t("booking.card.for") }} <b>{{ booking.people_count }}</b> {{ $t("booking.card.person") }}

              </div>

              <div class="client-info">

                <span v-if="booking.client.user">
                  {{ $t("booking.card.client") }} <b> {{ booking.client.user.first_name }} {{ booking.client.user.last_name }}</b>
                </span>

                <span v-if="booking.client.user">
                  {{ $t("booking.card.email") }} <b>{{ booking.client.user.email }}</b>
                </span>

                <span v-if="booking.client.user">
                  {{ $t("booking.card.phone") }} <b>{{ booking.client.user.phone || booking.client.user.cellphone }}</b>
                </span>

                <span>{{ $t("booking.card.arrival") }} <b>{{ booking.arrival_date }}</b> à <b>{{ booking.activity.arriving_time }}H{{ booking.activity.arriving_min_time }}0</b> </span>

                <span>{{ $t("booking.card.departure") }} <b>{{ booking.departure_date }}</b> à <b>{{ booking.activity.departure_time }}H{{ booking.activity.departure_min_time }}0</b> </span>

              </div>

              <hr>

              <div class="price-info">
                <span>{{ $t("booking.card.price") }} <b>{{ booking.sub_total | currency }}</b> </span>
              </div>

              <div class="state-info">

                <p><b>{{ $t("booking.card.state") }} {{ $t('global.status.'+booking.status) }}</b></p>

                <nuxt-link
                  :to="{
                    name: 'Activity',
                    params: {
                      id: booking.activity.id,
                      slug: booking.activity.slug
                    }
                  }"
                  class="btn btn-agri-l"
                  target="_blank">{{ $t("dashboard.activities.see") }}</nuxt-link>

                  <!-- <button
                  ref="navModal"
                  type="button"
                  class="btn btn-agri-yellow"
                  @click="showModal"
                >
                  Payer la réservation
                </button> -->

                  <!-- <button
                  v-if="booking.status !== 'cancelled' "
                  type="button"
                  class="btn btn-agri-yellow"
                  @click="cancelBooking(booking)">
                  Annuler
                </button> -->

              </div>

            </div>
          </div>
        </div>

        <div
          v-else
        >
          <p class="body-1">
            {{ $t("dashboard.bookings.no_booking") }}
            Vous n'avez aucune réservation pour le moment.
          </p>

          <img
            src="~assets/img/booking/empty.svg"
            alt="empty"
            class="empty">

        </div>

      </div>
    </div>
  </div>
</template>

<script>
  import ModalPayment from '@/components/Activity/BookingPayment'
  import moment from 'moment'
  import Cloudinary from '@/components/Cloudinary'

  export default {
    name: 'ClientActivityBookings',
    middleware: 'auth',
    components: {
      ModalPayment, Cloudinary
    },
    head () {
      return {
        title: 'Tableau de bord'
      }
    },
    data () {
      return {
        activity_bookings: [],
        isModalVisible: false
      }
    },
    computed: {
      pending_count () {
        var pendings = []
        this.activityBookings.map(function (value, key) {
          if (value.status === 'pending') {
            pendings.push(value)
          }
        })
        return `${pendings.length}`
      },
      confirm_count () {
        var confirms = []
        this.activityBookings.map(function (value, key) {
          if (value.status === 'confirmed') {
            confirms.push(value)
          }
        })
        return `${confirms.length}`
      },
      cancel_count () {
        var cancels = []
        this.activityBookings.map(function (value, key) {
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
        this.$axios.$get(`/clients/${this.$auth.user.client.id}/activity_bookings`)
          .then(res => {
            this.activityBookings = res.map(activityBooking => ({
              ...activityBooking,
              arrival_date: moment(activityBooking.arrival_date).locale('fr').format('L'),
              departure_date: moment(activityBooking.departure_date).locale('fr').format('L')
            }))
          })
          .finally(() => {
            this.$wait.end('fetching bookings')
          })
      }
    },
    methods: {
      cancelBooking (booking) {
        this.$wait.start('update booking statut')
        this.$axios.put(`/activity_bookings/${booking.id}`, {
          activity_booking: {
            status: 'cancelled'
          }
        })
          .then((res) => {
            console.log('response', res)
          })
          .catch((err) => {
            console.error('err', err)
          })
          .finally(() => {
            this.$wait.end('update booking statut')
          })
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

  hr {
    border-top: 1px solid $agri-green;
  }

  .empty {
    margin-left: 25%;
  }

  .booking-title {
    font-size: 26px;
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
    color: $agri-green;
    font-weight: bold;
  }

  .counters {
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
    color: $agri-green;
    font-size: 16px;
  }

  .dashboard {
    @media only screen and (max-width: $breakpoint-mobile-m) {
      margin-left: 20px;
      margin-right: 20px;
    }
  }

  .bookings{
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
    height: 300px;
    box-shadow: 1px 1px 12px #555;
    border-radius: 15px;
    padding: 10px;

    display: grid;
    grid-template-columns: 20% 80%;
    grid-gap: 20px;

    @media only screen and (max-width: $breakpoint-mobile-m) {
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
    color: $agri-green;
    padding-right: 30px;
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  }

  .booking-info {
    font-size: 15px;
    margin-bottom: 30px;
  }

  .client-info {
    display: grid;
    grid-template-columns: auto auto auto;
    @media only screen and (max-width: $breakpoint-mobile-m) {
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
  }
</style>
