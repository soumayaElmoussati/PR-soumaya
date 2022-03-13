<template lang="html">
  <div class="booking-resume">
    <h1 class="title">{{ $t("booking.card.bookingAt") }} <b>{{ getBooking.offer.name }}</b></h1>
    <p class="body-1 dates">{{ $t("booking.card.from") }} <b class="date">{{ getArrival }}</b> {{ $t("booking.card.toMin") }} <b class="date">{{ getDeparture }}</b></p>
    <p class="body-1"> <b class="people-count">{{ getBooking.people_count }}</b> {{ $t("booking.card.personMin") }}</p>
    <p class="body-1">{{ $t("booking.card.state") }} <b class="status">{{ $t('global.status.'+ getBooking.status) }}</b> </p>
    <p>{{ $t("booking.card.stayPrice") }} <b class="price">{{ getBooking.total | currency }}</b> </p>
    <p>{{ $t("booking.card.arrivalAt") }} <b class="tel">{{ getBooking.offer.arriving_time }}H{{ getBooking.offer.arriving_min_time }}0</b> {{ $t("booking.card.departureAt") }} <b class="tel">{{ getBooking.offer.departure_time }}H{{ getBooking.offer.departure_min_time }}0</b></p>
    <p v-if="getBooking.offer.manager == false">
      <i>* la taxe de séjour est à régler sur place</i>
    </p>
    <hr>

    <h3 class="sub-title">{{ $t("booking.card.yourClient") }}</h3>
    <p class="body-1">{{ getBooking.client.user.first_name }} {{ getBooking.client.user.last_name }}</p>
    <p class="body-1">{{ $t("booking.card.email") }} <b class="email">{{ getBooking.client.user.email }}</b></p>
    <p class="body-1">{{ $t("booking.card.tel") }} <b class="tel">{{ getBooking.contact_number }}</b></p>
    <hr>

    <h3 class="sub-title">Message :</h3>
    <p class="body-1">{{ getBooking.message }}</p>
    <hr>

    <h3 class="sub-title">Services compris :</h3>
    <p
      v-if="getBooking.breakfast_total !== 0"
      class="body-1"> Petit Déjeuner <b class="tel">{{ getBooking.breakfast_total | currency }}</b></p>

    <p
      v-if="getBooking.linens_total !== 0"
      class="body-1"> Linge de lit <b class="tel">{{ getBooking.linens_total | currency }}</b></p>

    <p
      v-if="getBooking.cleaning_total !== 0"
      class="body-1"> Ménage <b class="tel">{{ getBooking.cleaning_total | currency }}</b></p>

    <hr>

    <div v-if="getBooking.annexe_services_total > 0">

      <h3 class="sub-title">Services annexes :</h3>
      <p
        v-if="getBooking.panier_nb !== null"
        class="body-1"> {{ $t("bookingTiny.servicesAnnexes.title")[0].title }} <b class="tel">{{ getBooking.panier_total }}{{ $t("bookingTiny.servicesAnnexes.title")[0].currency }}</b></p>

      <p
        v-if="getBooking.bike_rent_nb !== null"
        class="body-1"> {{ $t("bookingTiny.servicesAnnexes.title")[1].title }} <b class="tel">{{ getBooking.bike_rent_price }}{{ $t("bookingTiny.servicesAnnexes.title")[1].currency }}</b></p>

      <p
        v-if="getBooking.breakfast_nb !== null"
        class="body-1"> {{ $t("bookingTiny.servicesAnnexes.title")[2].title }} <b class="tel">{{ getBooking.breakfast_price }}{{ $t("bookingTiny.servicesAnnexes.title")[2].currency }}</b></p>

      <p
        v-if="getBooking.packed_lunch_nb !== null"
        class="body-1"> {{ $t("bookingTiny.servicesAnnexes.title")[3].title }} <b class="tel">{{ getBooking.packed_lunch_price }}{{ $t("bookingTiny.servicesAnnexes.title")[3].currency }}</b></p>

      <p
        v-if="getBooking.cooking_workshop_nb !== null"
        class="body-1"> {{ $t("bookingTiny.servicesAnnexes.title")[4].title }} <b class="tel">{{ getBooking.cooking_workshop_price }}{{ $t("bookingTiny.servicesAnnexes.title")[4].currency }}</b></p>

      <p
        v-if="getBooking.serenity_nb !== null"
        class="body-1"> {{ $t("bookingTiny.servicesAnnexes.title")[5].title }} <b class="tel">{{ getBooking.serenity_price }}{{ $t("bookingTiny.servicesAnnexes.title")[5].currency }}</b></p>

      <p
        v-if="getBooking.spa_nb !== null"
        class="body-1"> {{ $t("bookingTiny.servicesAnnexes.title")[6].title }} <b class="tel">{{ getBooking.spa_price }}{{ $t("bookingTiny.servicesAnnexes.title")[6].currency }}</b></p>

      <p
        v-if="getBooking.car_rent_nb !== null"
        class="body-1"> {{ $t("bookingTiny.servicesAnnexes.title")[7].title }} <b class="tel">{{ getBooking.car_rent_price }}{{ $t("bookingTiny.servicesAnnexes.title")[7].currency }}</b></p>

      <p
        v-if="getBooking.station_ride_nb !== null"
        class="body-1"> {{ $t("bookingTiny.servicesAnnexes.title")[8].title }} <b class="tel">{{ getBooking.station_ride_price }}{{ $t("bookingTiny.servicesAnnexes.title")[8].currency }}</b></p>

      <p
        v-if="getBooking.animal_space_nb !== null"
        class="body-1"> {{ $t("bookingTiny.servicesAnnexes.title")[9].title }} <b class="tel">{{ getBooking.animal_space_price }}{{ $t("bookingTiny.servicesAnnexes.title")[9].currency }}</b></p>

      <p
        v-if="getBooking.host_table_nb !== null"
        class="body-1"> {{ $t("bookingTiny.servicesAnnexes.title")[10].title }} <b class="tel">{{ getBooking.host_table_price }}{{ $t("bookingTiny.servicesAnnexes.title")[10].currency }}</b></p>

      <p
        v-if="getBooking.washing_kit_nb !== null"
        class="body-1"> {{ $t("bookingTiny.servicesAnnexes.title")[11].title }} <b class="tel">{{ getBooking.washing_kit_price }}{{ $t("bookingTiny.servicesAnnexes.title")[11].currency }}</b></p>

      <p
        v-if="getBooking.bbq_nb !== null"
        class="body-1"> {{ $t("bookingTiny.servicesAnnexes.title")[12].title }} <b class="tel">{{ getBooking.bbq_price }}{{ $t("bookingTiny.servicesAnnexes.title")[12].currency }}</b></p>

      <p
        v-if="getBooking.riding_lesson_nb !== null"
        class="body-1"> {{ $t("bookingTiny.servicesAnnexes.title")[13].title }} <b class="tel">{{ getBooking.riding_lesson_price }}{{ $t("bookingTiny.servicesAnnexes.title")[13].currency }}</b></p>

      <p
        v-if="getBooking.horse_ride_nb !== null"
        class="body-1"> {{ $t("bookingTiny.servicesAnnexes.title")[14].title }} <b class="tel">{{ getBooking.horse_ride_price }}{{ $t("bookingTiny.servicesAnnexes.title")[14].currency }}</b></p>

      <p
        v-if="getBooking.riding_course_nb !== null"
        class="body-1"> {{ $t("bookingTiny.servicesAnnexes.title")[15].title }} <b class="tel">{{ getBooking.riding_course_price }}{{ $t("bookingTiny.servicesAnnexes.title")[15].currency }}</b></p>

      <p
        v-if="getBooking.riding_introduction_nb !== null"
        class="body-1"> {{ $t("bookingTiny.servicesAnnexes.title")[16].title }} <b class="tel">{{ getBooking.riding_introduction_price }}{{ $t("bookingTiny.servicesAnnexes.title")[16].currency }}</b></p>

      <p
        v-if="getBooking.immersion_nb !== null"
        class="body-1"> {{ $t("bookingTiny.servicesAnnexes.title")[17].title }} <b class="tel">{{ getBooking.immersion_price }}{{ $t("bookingTiny.servicesAnnexes.title")[17].currency }}</b></p>

      <p class="body-1">
        Les services annexes seront a payer sur place
      </p>

      <hr>

    </div>

    <div v-if="getBooking.receipt_url">

      <h3 class="sub-title">Reçu :</h3>
      <a
        :href="getBooking.receipt_url"
        class="btn btn-green"
        target="_blank">Voir mon reçu</a>

      <hr>

    </div>

    <div v-if="getBooking.reviews.length !== 0 && getBooking.reviews[0].state === 'validate'">

      <h3 class="sub-title">Avis de {{ getBooking.client.user.first_name }} sur son séjour :</h3>

      <h4 class="sub-title">
        Dans quel cadre êtes-vous partis ?
      </h4>

      <p>{{ $t("review.situation." + getBooking.reviews[0].situation) }}</p>

      <h4 class="sub-title">
        Quelle note donneriez-vous à votre séjour ?
      </h4>

      <p>{{ getBooking.reviews[0].star }}/5</p>

      <h4 class="sub-title">
        Votre séjour a t’il été à la hauteur de vos attentes ?
      </h4>

      <h5>Le logement</h5>

      <star-rating
        v-model="getBooking.reviews[0].lodging"
        :star-size="30"
        :read-only="true"
        :show-rating="false"
        active-color="#476458"/>

      <h5>L’activité découverte</h5>

      <star-rating
        v-model="getBooking.reviews[0].activity"
        :star-size="30"
        :read-only="true"
        :show-rating="false"
        active-color="#476458"/>

      <h5>Les options choisies (petit déjeuner, spa, vélo...)</h5>

      <star-rating
        v-model="getBooking.reviews[0].services"
        :star-size="30"
        :read-only="true"
        :show-rating="false"
        active-color="#476458"/>

      <h5>Le contact avec vos hôtes</h5>

      <star-rating
        v-model="getBooking.reviews[0].contact"
        :star-size="30"
        :read-only="true"
        :show-rating="false"
        active-color="#476458"/>

      <h5>Quel conseil donneriez-vous à l’agriculteur pour améliorer son offre ?</h5>

      <p>{{ getBooking.reviews[0].trip_note }}</p>

      <br>

      <h4 class="sub-title">
        Recommanderiez-vous un séjour à la ferme à votre entourage ?
      </h4>

      <p>{{ $t("review.answers." + getBooking.reviews[0].reference) }}</p>

      <h4 class="sub-title">
        Commentaire général de la réservation (celui-ci sera visible sur l’annonce) :
      </h4>

      <p>{{ getBooking.reviews[0].comment }}</p>

      <hr>

    </div>

    <h3 class="sub-title">{{ $t("booking.card.adress") }}</h3>
    <h4 class="address">{{ getBooking.offer.address.street_name }}, {{ getBooking.offer.address.postal_code }} {{ getBooking.offer.address.city }}</h4>

    <div class="map">

      <client-only>
        <l-map
          :zoom="zoom"
          :center="position"
          style="height: 100%; width: 100%;z-index: 1;"
        >
          <l-marker :lat-lng="position" />
          <l-tile-layer :url="url" />
        </l-map>
      </client-only>

    </div>

  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import moment from 'moment'

export default {
  name: 'BookingFarmer',
  middleware: 'auth',
  data () {
    return {
      zoom: 8,
      url: process.env.MAPBOX_URL
    }
  },
  fetch ({ store, app, route, error }) {
    return Promise.all([
      app.$axios.get(`/bookings/${route.params.id}`)
    ])
      .then(values => {
        if (values[0].status === 200) {
          store.dispatch('setBooking', values[0].data)
        }
      })
      .catch(() => {
        error({
          statusCode: 404,
          message: "Cette réservation n'existe pas ou plus"
        })
      })
  },
  computed: {
    ...mapGetters(['getBooking']),
    getArrival () {
      return moment(this.getBooking.arrival_date).locale('fr').format('L')
    },
    getDeparture () {
      return moment(this.getBooking.departure_date).locale('fr').format('L')
    },
    position () {
      return [
        this.getBooking.offer.address.lat,
        this.getBooking.offer.address.lng
      ]
    }
  },
  methods: {
    isManaged () {
      if (this.getBooking.offer.manager === true) {
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
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

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

.booking-resume {
  margin: 0 auto;
  width: 50%;
  margin-top: 5vw;
  margin-bottom: 5vw;
}

.title {
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
}

.date {
  color: $agri-green;
}

.people-count {
  color: $agri-green;
}

.status {
  color: $agri-green;
}

.price {
  color: $agri-green;
}

.hours {
  color: $agri-green;
}

.email {
  color: $agri-green;
}

.tel {
  color: $agri-green;
}

.map {
  width: 100%;
  height: 250px;
}

.sub-title {
  color: $agri-green;
}

.address {
  color: $agri-green;
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
}

</style>
