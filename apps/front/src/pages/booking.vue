<template lang="html">
  <div class="booking-resume">
    <div>
      <a
        :href="getBooking.receipt_url"
        class="btn btn-green"
        target="_blank">Voir mon reçu</a>

      <br>

      <button
        class="btn btn-green"
        @click="getPdf(getBooking.offer.name, getBooking.id)"
      >Télécharger PDF</button>
    </div>

    <div :id="'pdfDom'+getBooking.id">
      <div class="infos">
        <div
          class="logo">
          <img
            :src="img1"
            alt="logo"
          >
        </div>
        <div class="text">
          <p> {{ $t("booking.card.email") }} : {{ $t("booking.infos.email") }} </p>
          <p> {{ $t("booking.card.phone") }} :  {{ $t("booking.infos.tel") }} </p>
        </div>
      </div>

      <hr>

      <div>
        <h2 class="title"> {{ $t("booking.titles.hote") }} </h2>
        <div>
          <p> {{ $t("booking.card.name") }} : <span> {{ getBooking.offer.farmer.user.first_name }} {{ getBooking.offer.farmer.user.last_name }} </span></p>
          <p> {{ $t("booking.card.email") }} : <span>{{ getBooking.offer.farmer.user.email }} </span></p>
          <p> {{ $t("booking.card.phone") }} : <span> {{ getBooking.offer.farmer.user.cellphone }} </span></p>
        </div>
      </div>

      <hr>

      <h2 class="title"> {{ $t("booking.titles.details") }} </h2>

      <div>
        <p> {{ $t("booking.card.name") }} : <span class="tel"> {{ getBooking.offer.name }} </span> </p>

        <p> {{ $t("booking.card.adress") }} : <span class="tel"> {{ getBooking.offer.address.street_name }} </span></p>

        <p> {{ $t("booking.card.postalCode") }} : <span class="tel"> {{ getBooking.offer.address.postal_code }} </span> </p>

        <p> {{ $t("booking.card.city") }} : <span class="tel"> {{ getBooking.offer.address.city }} </span> </p>

        <p> {{ $t("booking.card.arrival") }} : <span class="tel"> {{ getArrival }} </span></p>

        <p> {{ $t("booking.card.departure") }} : <span class="tel"> {{ getDeparture }} </span> </p>

        <p> {{ $t("booking.card.timeArrival") }} : <span class="tel"> {{ getBooking.offer.arriving_time }}H{{ getBooking.offer.arriving_min_time }}0</span></p>

        <p> {{ $t("booking.card.timeDeparture") }} : <span class="tel"> {{ getBooking.offer.departure_time }}H{{ getBooking.offer.departure_min_time }}0 </span> </p>

        <p> {{ $t("booking.card.number") }} : <span class="tel"> {{ getBooking.people_count }} </span></p>

        <p> {{ $t("booking.card.state") }} : <span class="tel"> {{ $t('global.status.'+ getBooking.status) }} </span></p>

        <p> {{ $t("booking.card.stayPrice") }} : <span class="tel"> <b>{{ getBooking.total | currency }}</b> </span></p>

        <p v-if="getBooking.offer.manager == false">
          <i>* la taxe de séjour est à régler sur place</i>
        </p>

      </div>

      <hr>

      <h3 class="title">{{ $t("booking.titles.annexe") }}</h3>
      <p class="body-1">{{ getBooking.offer.annexe_information }}</p>

      <hr>

      <h3 class="title">{{ $t("booking.titles.services") }}</h3>

      <div v-if="hasBreakfast(getBooking.offer.offer_service, getBooking)">
        <p
          v-if="getBooking.offer.offer_service.breakfast && getBooking.breakfast_total !== 0"
          class="body-1"> {{ $t("booking.services.breakfast") }} <b class="tel">{{ getBooking.breakfast_total | currency }}</b></p>

        <p
          v-if="getBooking.offer.offer_service.breakfast && getBooking.breakfast_total === 0"
          class="body-1"> {{ $t("booking.services.breakfast") }} <b class="tel">Inclus</b></p>

      </div>

      <div v-if="hasLinens(getBooking.offer.offer_service, getBooking)">
        <p
          v-if="getBooking.offer.offer_service.linens && getBooking.linens_total !== 0"
          class="body-1"> {{ $t("booking.services.bedding") }} <b class="tel">{{ getBooking.linens_total | currency }}</b></p>

        <p
          v-if="getBooking.offer.offer_service.linens && getBooking.linens_total === 0"
          class="body-1"> {{ $t("booking.services.bedding") }} <b class="tel">Inclus</b></p>

      </div>

      <div v-if="hasCleaning(getBooking.offer.offer_service, getBooking)">
        <p
          v-if="getBooking.offer.offer_service.cleaning && getBooking.cleaning_total !== 0"
          class="body-1"> {{ $t("booking.services.cleaning") }} <b class="tel">{{ getBooking.cleaning_total | currency }}</b></p>

        <p
          v-if="getBooking.offer.offer_service.cleaning && getBooking.cleaning_total === 0"
          class="body-1"> {{ $t("booking.services.cleaning") }} <b class="tel">Inclus</b></p>

      </div>

      <hr>

      <h3 class="title">{{ $t("booking.services.subtitle") }}</h3>
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

      <p
        v-if="getBooking.annexe_services_total > 0"
        class="body-1"> Total des services <b class="tel">{{ getBooking.annexe_services_total / 100 }}€</b></p>

      <p class="body-1">
        Les services annexes seront a payer sur place
      </p>

      <nuxt-link
        v-if="
          getBooking.status === 'payed' && isManaged(getBooking.offer) && getBooking.annexe_services_total === 0
        "
        :to="{
          name: 'TinyBooking',
          params: {
            id: getBooking.offer.id,
            bookingId: getBooking.id,
            slug: residenceType(getBooking.offer.residence_type)
          }
        }"
        class="btn btn-agri-contact"
      >{{ $t("booking.services.subtitle") }}</nuxt-link
      >

      <hr>

      <div v-if="getBooking.farmer_reviews.length !== 0 && getBooking.farmer_reviews[0].state === 'validate'">

        <h3 class="title">Avis de {{ getBooking.offer.farmer.user.first_name }} sur votre séjour</h3>
        <p
          class="body-1"> Propreté du logement à son départ
        </p>

        <star-rating
          v-model="getBooking.farmer_reviews[0].cleanliness"
          :star-size="30"
          :read-only="true"
          :show-rating="false"
          active-color="#476458"/>

        <p
          class="body-1"> Communication claire</p>

        <star-rating
          v-model="getBooking.farmer_reviews[0].communication"
          :star-size="30"
          :read-only="true"
          :show-rating="false"
          active-color="#476458"/>

        <p
          class="body-1"> Réspect du réglement inéterieur</p>

        <star-rating
          v-model="getBooking.farmer_reviews[0].respect"
          :star-size="30"
          :read-only="true"
          :show-rating="false"
          active-color="#476458"/>

        <p
          class="body-1"> Expérience générale </p>

        <star-rating
          v-model="getBooking.farmer_reviews[0].experience"
          :star-size="30"
          :read-only="true"
          :show-rating="false"
          active-color="#476458"/>

        <br>

        <p
          class="body-1"> Souhaiteriez-vous accueillir ce vacancier à nouveau ? <b class="tel">{{ $t("review.answers." + getBooking.farmer_reviews[0].welcome) }}</b></p>

        <br>

        <p
          class="body-1"> Commentaire général de la réservation :</p>

        <p
          class="body-1"> {{ getBooking.farmer_reviews[0].comment }}</p>

        <hr>

      </div>

      <h3 class="title">{{ $t("booking.card.adress") }}</h3>
      <p class="body-1">{{ getBooking.offer.address.street_name }}, {{ getBooking.offer.address.postal_code }} {{ getBooking.offer.address.city }}</p>

      <br>

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

  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import moment from 'moment'
import img1 from '@/assets/img/icon.png'

export default {
  name: 'Booking',
  middleware: 'auth',
  data () {
    return {
      zoom: 8,
      url: process.env.MAPBOX_URL,
      img1
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
  margin-top: 10vw;
  margin-bottom: 5vw;
  p {
    font-size: 14px;
    margin: auto;
    line-height: 20px;
  }
}

.tel {
  float: right;
}

.btn-pdf {
  background-color: $agri-yellow;
  height: 37px;
  border-radius: 10px;
  text-transform: uppercase;
  font-weight: 600;
  padding: 0 20px;
  font-size: 13px;
  float: right;
  cursor: pointer;
}

.logo {
  width: 14%;
  margin-right: 5%;
  img{
    width: 100%;
  }
}

.title {
  font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  font-size: 18px;
  text-align: center;
  margin: auto;
  color: $agri-green;
  font-weight: bolder;
}

.infos {
  clip-path: inset(0 100% 0 0);
  display: flex;
  justify-content: flex-end;
}

.map {
  width: 100%;
  height: 250px;
}
</style>
