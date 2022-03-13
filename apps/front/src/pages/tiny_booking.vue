<template>
  <div class="tinyBookingContainer">
    <div class="infos_tiny">
      <div class="title">
        <h3>{{ getOffer.name }}</h3>
        <div class="nameLogo">
          <img
            :src="farmerLogo"
            :alt="getOffer.name" >
          <p>
            {{ $t("bookingTiny.paragraphs.at") }} {{ getOffer.farmer.user.first_name }}
            {{ getOffer.farmer.user.last_name }}
          </p>
        </div>
        <div class="recap">
          <div class="title">
            <p>{{ $t("bookingTiny.title") }}</p>
            <nuxt-link
              :to="{
                name: 'Offer',
                params: {
                  id: getOffer.id,
                  slug: getOffer.slug,
                  domaine: residenceType(getOffer.residence_type)
                }
              }"
              class="btn btn-agri-contact"
              target="_blank"
            >{{ $t("booking.card.see") }}</nuxt-link
            >
          </div>
          <div class="cadres">
            <div class="lelogement">
              <div class="content">
                <div class="title">
                  <p>{{ $t("bookingTiny.titleLogement") }}</p>
                </div>
                <div class="grid">
                  <div class="elements">
                    <img
                      :src="geoLogo"
                      alt="localisation" >
                    <p>{{ getOffer.address.city }}</p>
                  </div>
                  <div class="elements">
                    <img
                      :src="people"
                      alt="localisation" >
                    <p>
                      {{
                        $tc("search.card.people", getBooking.people_count, {
                          number: getBooking.people_count
                        })
                      }}
                    </p>
                  </div>
                  <div class="elements">
                    <img
                      :src="room"
                      alt="rooms" >
                    <p>
                      {{
                        $tc("search.card.rooms", getOffer.rooms_count, {
                          number: getOffer.rooms_count
                        })
                      }}
                    </p>
                  </div>
                  <div class="elements">
                    <img
                      :src="wc"
                      class="icon-rooms"
                      alt="localisation" >
                    <p>Toilette</p>
                  </div>
                  <div class="elements">
                    <img
                      :src="bath"
                      alt="localisation" >
                    <p>
                      {{
                        $tc("search.card.bathrooms", getOffer.bathrooms_count, {
                          number: getOffer.bathrooms_count
                        })
                      }}
                    </p>
                  </div>
                </div>
              </div>
            </div>
            <div class="laferme">
              <div class="content">
                <div class="title">
                  <p>{{ $t("bookingTiny.titleLaFerme") }}</p>
                </div>
                <div class="elements">
                  <p>{{ $t("bookingTiny.animals.title") }}:</p>
                  <div class="images">
                    <i
                      v-for="(icon, i) in thirdAnimals"
                      :key="i"
                      :class="icon"
                      aria-hidden="true"
                      style="font-size: 30px; color: #476458 !important"
                    />
                    <i
                      v-if="animals.length > 3"
                      class="fas fa-ellipsis-h"
                      style="z-index: 1000; position: relative"
                    />
                  </div>
                </div>
                <div class="elements">
                  <p>{{ $t("bookingTiny.activities.title") }}:</p>
                  <div class="images">
                    <i
                      v-for="(icon, i) in thirdIcon"
                      :key="i"
                      :class="'agri-others2' + ' ' + icon"
                      aria-hidden="true"
                      style="font-size: 30px; color: #476458 !important"
                    />
                    <i
                      v-if="activities.length > 3"
                      class="fas fa-ellipsis-h"
                      style="z-index: 1000; position: relative"
                    />
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div
        v-if="getOffer.pictures.length"
        class="images">
        <img
          :src="
            'https://res.cloudinary.com/agrivillage/image/upload/w_430,h_270,c_fill,f_jpg,fl_progressive/' +
              getOffer.pictures[0].public_id
          "
          class="grandephoto"
          alt=""
        >
        <img
          v-if="getOffer.pictures[1]"
          :src="
            'https://res.cloudinary.com/agrivillage/image/upload/w_430,h_270,c_fill,f_jpg,fl_progressive/' +
              getOffer.pictures[1].public_id
          "
          class="petitephoto1"
          alt=""
        >
        <img
          v-else
          :src="noPhoto"
          class="petitephoto1"
          alt="" >
        <img
          v-if="getOffer.pictures[2]"
          :src="
            'https://res.cloudinary.com/agrivillage/image/upload/w_430,h_270,c_fill,f_jpg,fl_progressive/' +
              getOffer.pictures[2].public_id
          "
          class="petitephoto2"
          alt=""
        >
        <img
          v-else
          :src="noPhoto"
          class="petitephoto2"
          alt="" >
      </div>
    </div>
    <div class="lesplus">
      <p>{{ $t("bookingTiny.lesPlus") }}:</p>
      <img
        v-if="equipmentData.includes('wifi')"
        :src="wifi"
        alt="wifi" >
      <img
        v-if="equipmentData.includes('swimming_pool')"
        :src="pool"
        alt="piscine"
      >
      <img
        v-if="equipmentData.includes('parking')"
        :src="parking"
        alt="parking"
      >
      <img
        v-if="equipmentData.includes('train')"
        :src="train"
        alt="gare" >
      <img
        v-if="equipmentData.includes('animals_welcome')"
        :src="animal"
        alt="animaux"
      >
      <img
        v-if="equipmentData.includes('private_garden')"
        :src="terrace"
        alt="jardin"
      >
      <img
        v-if="equipmentData.includes('kitchen')"
        :src="kitchen"
        alt="acces cuisine"
      >
      <img
        v-if="equipmentData.includes('bbq')"
        :src="bbq"
        alt="barbecue" >
    </div>
    <div class="recapInfos">
      <div class="infos">
        <p>
          <span
          >{{ $t("bookingTiny.duree") }}:
            {{ formatDate(getBooking.arrival_date) }} -
            {{ formatDate(getBooking.departure_date) }}</span
            >
        </p>
        <p>
          <span
          >{{ $t("bookingTiny.nombre") }}:
            {{
              $tc("search.card.people", getBooking.peopleCount, {
                number: getBooking.peopleCount
              })
            }}</span
            >
        </p>
        <p>
          {{ $t("bookingTiny.servicesCompris") }}:
          <span v-if="getOffer.service.linens">{{
            $t("activity.services.linens")
          }}</span>
          <span v-if="getOffer.service.cleaning">{{
            $t("activity.services.cleaning")
          }}</span>
          <span v-if="getOffer.service.breakfast">{{
            $t("activity.services.breakfast")
          }}</span>
          <span
            v-if="
              !getOffer.service.linens &&
                !getOffer.service.cleaning &&
                !getOffer.service.breakfast
            "
          >{{ $t("bookingTiny.paragraphs.service") }}</span
          >
        </p>
      </div>
      <div class="infos">
        <p>
          {{ $t("bookingTiny.heureArrivee") }}: {{ getOffer.arriving_time }}h{{
            getOffer.arriving_min_time
          }}0
        </p>
        <p>
          {{ $t("bookingTiny.heureDepart") }}: {{ getOffer.departure_time }}h{{
            getOffer.departure_min_time
          }}0
        </p>
      </div>
    </div>
    <div class="fraisSup">
      <div class="title">
        <h3>{{ $t("bookingTiny.fraisSup.title") }}:</h3>
      </div>
      <PanierGarnis
        v-if="Object.keys(panierGarnis).length !== 0"
        :offer="panierGarnis"
        @totalPanier="analyseTotalPanier"
        @numberPanier="analyseNumberPanier"
        @questions="updateDescPanier"
      />
      <Velos
        v-if="Object.keys(velos).length !== 0"
        :offer="velos"
        @totalVelo="analyseTotalVelo"
        @numberVelo="analyseNumberVelo"
        @questions="updateDescVelos"
      />
      <PetitDej
        v-if="Object.keys(petitdej).length !== 0"
        :offer="petitdej"
        @totalPetitDej="analyseTotalPetitDej"
        @numberPetitDej="analyseNumberPetitDej"
        @questions="updateDescPetitDej"
      />
      <PanierRepas
        v-if="Object.keys(panierrepas).length !== 0"
        :offer="panierrepas"
        @totalPaniersRepas="analyseTotalPaniersRepas"
        @numberPaniersRepas="analyseNumberPaniersRepas"
        @questions="updateDescRepas"
      />
      <Atelier
        v-if="Object.keys(atelier).length !== 0"
        :offer="atelier"
        @totalAteliers="analyseTotalAteliers"
        @numberAteliers="analyseNumberAteliers"
        @questions="updateDescAtelier"
      />
      <Bienetre
        v-if="Object.keys(bienetre).length !== 0"
        :offer="bienetre"
        @totalBienEtre="analyseTotalBienEtre"
        @numberBienEtre="analyseNumberBienEtre"
        @questions="updateDescActBienEtre"
      />
      <Spa
        v-if="Object.keys(spa).length !== 0"
        :offer="spa"
        @totalSpa="analyseTotalSpa"
        @numberSpa="analyseNumberSpa"
        @questions="updateDescSpa"
      />
      <LocationVoiture
        v-if="Object.keys(voiture).length !== 0"
        :offer="voiture"
        @totalLocation="analyseTotalLocation"
        @numberLocation="analyseNumberLocation"
        @questions="updateDescVoiture"
      />
      <Trajet
        v-if="Object.keys(trajet).length !== 0"
        :offer="trajet"
        @totalTrajet="analyseTotalTrajet"
        @numberTrajet="analyseNumberTrajet"
        @questions="updateDescTrajet"
      />
      <Animaux
        v-if="Object.keys(animaux).length !== 0"
        :offer="animaux"
        @totalAnimaux="analyseTotalAnimaux"
        @numberAnimaux="analyseNumberAnimaux"
        @questions="updateDescAnimaux"
      />
      <Hote
        v-if="Object.keys(hote).length !== 0"
        :offer="hote"
        @totalTableHote="analyseTotalHote"
        @numberTableHote="analyseNumberHote"
        @questions="updateDescHote"
      />
      <WashingKit
        v-if="Object.keys(washingkit).length !== 0"
        :offer="washingkit"
        @totalWashingkit="analyseTotalWashingkit"
        @numberWashingkit="analyseNumberWashingkit"
        @questions="updateDescWashingkit"
      />
      <Bbq
        v-if="Object.keys(bbqservice).length !== 0"
        :offer="bbqservice"
        @totalBbq="analyseTotalBbq"
        @numberBbq="analyseNumberBbq"
        @questions="updateDescBbq"
      />
      <RidingLesson
        v-if="Object.keys(ridinglesson).length !== 0"
        :offer="ridinglesson"
        @totalRidingLesson="analyseTotalRidingLesson"
        @numberRidingLesson="analyseNumberRidingLesson"
        @questions="updateDescRidingLesson"
      />
      <HorseRide
        v-if="Object.keys(horseride).length !== 0"
        :offer="horseride"
        @totalHorseRide="analyseTotalHorseRide"
        @numberHorseRide="analyseNumberHorseRide"
        @questions="updateDescHorseRide"
      />
      <RidingCourse
        v-if="Object.keys(ridingcourse).length !== 0"
        :offer="ridingcourse"
        @totalRidingCourse="analyseTotalRidingCourse"
        @numberRidingCourse="analyseNumberRidingCourse"
        @questions="updateDescRidingCourse"
      />
      <RidingIntroduction
        v-if="Object.keys(ridingintroduction).length !== 0"
        :offer="ridingintroduction"
        @totalRidingIntroduction="analyseTotalRidingIntroduction"
        @numberRidingIntroduction="analyseNumberRidingIntroduction"
        @questions="updateDescRidingIntroduction"
      />
      <Immersion
        v-if="Object.keys(immersion).length !== 0"
        :offer="immersion"
        @totalImmersion="analyseTotalImmersion"
        @numberImmersion="analyseNumberImmersion"
        @questions="updateDescImmersion"
      />
      <div
        v-if="getOffer.annexe_service.length"
        class="total">
        <div />
        <div />
        <div class="text">
          <p>{{ $t("bookingTiny.paragraphs.total") }}</p>
          <p>{{ compt() }}€ {{ $t("bookingTiny.paragraphs.stay") }}</p>
        </div>
      </div>
      <div
        v-if="getOffer.annexe_service.length"
        class="button">
        <button
          class="validate"
          @click="postAnnexeServices(servicesAnnexe.total)"
        >
          {{ $t("bookingTiny.buttons.submit") }}
        </button>
      </div>
      <div
        v-else
        class="title">
        <h3>{{ $t("bookingTiny.fraisSup.noContent") }}</h3>
        <div class="button">
          <nuxt-link
            :to="{
              name: 'DashboardClientBookings'
            }"
            class="validate"
          >
            {{ $t("bookingTiny.buttons.back") }}
          </nuxt-link>
        </div>
      </div>
      <h3>
        Les services annexes seront à payer sur place. <br>
        Les tarifs sont à titre indicatif et susceptibles de changer selon l’hôte et les promotions. <br>
        Attention : certaines activités doivent être réservées plusieurs jours en amont pour que vos hôtes puissent s'organiser et adapter leur emploi du temps.
      </h3>
    </div>
  </div>
</template>

<script>
import PanierGarnis from '@/components/BookingTiny/PanierGarnis'
import Velos from '@/components/BookingTiny/Velos'
import PetitDej from '@/components/BookingTiny/PetitDej'
import PanierRepas from '@/components/BookingTiny/PanierRepas'
import Atelier from '@/components/BookingTiny/AtelierCuisine'
import Bienetre from '@/components/BookingTiny/ActiviteBienEtre'
import Spa from '@/components/BookingTiny/Spa'
import LocationVoiture from '@/components/BookingTiny/LocationVoiture'
import Trajet from '@/components/BookingTiny/TrajetGare'
import Animaux from '@/components/BookingTiny/NuitAnimaux'
import Hote from '@/components/BookingTiny/TableHote'
import WashingKit from '@/components/BookingTiny/WashingKit'
import Bbq from '@/components/BookingTiny/Bbq'
import RidingLesson from '@/components/BookingTiny/RidingLesson'
import HorseRide from '@/components/BookingTiny/HorseRide'
import RidingCourse from '@/components/BookingTiny/RidingCourse'
import RidingIntroduction from '@/components/BookingTiny/RidingIntroduction'
import Immersion from '@/components/BookingTiny/Immersion'

import farmerLogo from '@/assets/img/user/farmer_green.png'
import geoLogo from '@/assets/img/resultsCards/location_green.png'
import room from '@/assets/img/resultsCards/bed_green.png'
import bath from '@/assets/img/resultsCards/bath_green.png'
import people from '@/assets/img/resultsCards/people_green.png'
import wc from '@/assets/img/resultsCards/wc_green.png'
import rectangle from '@/assets/img/resultsCards/exemple_act_green.png'
import img1 from '@/assets/img/booking/Rectangle 198.png'
import img2 from '@/assets/img/booking/Rectangle 200.png'
import wifi from '@/assets/img/equipments/wifi_green.png'
import pool from '@/assets/img/equipments/pool_green.png'
import parking from '@/assets/img/equipments/parking_green.png'
import animal from '@/assets/img/equipments/animal_green.png'
import train from '@/assets/img/equipments/train_green.png'
import terrace from '@/assets/img/equipments/terrace_green.png'
import kitchen from '@/assets/img/equipments/kitchen_green.png'
import bbq from '@/assets/img/equipments/barbecue_green.png'

import noPhoto from '@/assets/img/servicesTiny/nophoto.jpeg'
import { mapGetters } from 'vuex'
import dateFns from 'date-fns'
export default {
  name: 'TinyBooking',
  components: {
    PanierGarnis,
    Velos,
    PetitDej,
    PanierRepas,
    Atelier,
    Bienetre,
    Spa,
    LocationVoiture,
    Trajet,
    Animaux,
    Hote,
    WashingKit,
    Bbq,
    RidingLesson,
    HorseRide,
    RidingCourse,
    RidingIntroduction,
    Immersion
  },
  data () {
    return {
      farmerLogo,
      geoLogo,
      room,
      bath,
      people,
      wc,
      rectangle,
      img1,
      img2,
      parking,
      pool,
      wifi,
      animal,
      terrace,
      noPhoto,
      train,
      bbq,
      kitchen,
      bookings: [],
      numberPanier: 0,
      equipmentData: [],
      activities: [],
      activitiesIcons: [],
      thirdIcon: [],
      lastIcons: [],
      lastAnimals: [],
      animalsIcons: [],
      thirdAnimals: [],
      animals: [],
      panierGarnis: {},
      velos: {},
      petitdej: {},
      panierrepas: {},
      atelier: {},
      bienetre: {},
      spa: {},
      voiture: {},
      trajet: {},
      animaux: {},
      hote: {},
      washingkit: {},
      bbqservice: {},
      ridinglesson: {},
      horseride: {},
      ridingcourse: {},
      ridingintroduction: {},
      immersion: {},
      servicesAnnexe: {
        total: [
          {
            service: 'panierGarnis',
            total: 0,
            number: 0,
            questions: ''
          },
          {
            service: 'locationvelo',
            number: 0,
            total: 0,
            questions: ''
          },
          {
            service: 'petitdej',
            number: 0,
            total: 0,
            questions: ''
          },
          {
            service: 'panierrepas',
            number: 0,
            total: 0,
            questions: ''
          },
          {
            service: 'atelier',
            number: 0,
            total: 0,
            questions: ''
          },
          {
            service: 'bienetre',
            number: 0,
            total: 0,
            questions: ''
          },
          {
            service: 'spa',
            number: 0,
            total: 0,
            questions: ''
          },
          {
            service: 'locationVoiture',
            number: 0,
            total: 0,
            questions: ''
          },
          {
            service: 'trajet',
            number: 0,
            total: 0,
            questions: ''
          },
          {
            service: 'nuitAnimaux',
            number: 0,
            total: 0,
            questions: ''
          },
          {
            service: 'tableHote',
            number: 0,
            total: 0,
            questions: ''
          },
          {
            service: 'washingKit',
            number: 0,
            total: 0,
            questions: ''
          },
          {
            service: 'bbq',
            number: 0,
            total: 0,
            questions: ''
          },
          {
            service: 'ridingLesson',
            number: 0,
            total: 0,
            questions: ''
          },
          {
            service: 'horseRide',
            number: 0,
            total: 0,
            questions: ''
          },
          {
            service: 'ridingCourse',
            number: 0,
            total: 0,
            questions: ''
          },
          {
            service: 'ridingIntroduction',
            number: 0,
            total: 0,
            questions: ''
          },
          {
            service: 'immersion',
            number: 0,
            total: 0,
            questions: ''
          }
        ]
      },
      totalServices: 0,
      hotePut: {},
      animauxPut: {},
      trajetPut: {},
      voiturePut: {},
      spaPut: {},
      bienetrePut: {},
      atelierPut: {},
      panierrepasPut: {},
      petitdejPut: {},
      velosPut: {},
      panierGarnisPut: {},
      washingkitPut: {},
      bbqPut: {},
      ridinglessonPut: {},
      horseridePut: {},
      ridingcoursePut: {},
      ridingintroductionPut: {},
      immersionPut: {}
    }
  },
  fetch ({ store, app, route }) {
    return app.$axios
      .get(`/offers/${route.params.id}`)
      .then(res => {
        if (res.status === 200) {
          store.dispatch('setOffer', res.data)
          app.$axios
            .get(`/bookings/${route.params.bookingId}`)
            .then(value => {
              if (value.status === 200) {
                store.dispatch('setBooking', value.data)
              }
            })
            .catch(err => {
              console.log('error occured', err)
            })
        }
      })
      .catch(err => {
        console.log('error occured', err)
      })
  },
  computed: {
    ...mapGetters(['getBooking', 'getOffer', 'getTinyBooking'])
  },
  mounted () {
    this.farmType()
    this.arrayFunctionEquipment()
    this.arrayFunctionDesc()
    this.arrayFunctionAnimals()
    this.checkServices()
    this.compt()
  },
  methods: {
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
    farmType () {
      let obj = this.getOffer.farm_types

      let keys = Object.keys(obj)

      let filtered = keys.filter(function (key) {
        return obj[key]
      })
      switch (filtered[1]) {
        case 'breeder':
          return 'Eleveur'
        case 'agroforestry':
          return 'Agroforesterie'
        case 'arborist':
          return 'Arboriste'
        case 'beekeeper':
          return 'Apiculteur'
        case 'brewer':
          return 'brBrasseurewer'
        case 'cereal':
          return 'Céréalier'
        case 'cheese_production':
          return 'Production de fromage'
        case 'cider_maker':
          return 'Cidriculteur'
        case 'horticulturist':
          return 'Horticulteur'
        case 'market_gardener':
          return 'Maraicher'
        case 'mushroom_grower':
          return 'Myciculture'
        case 'oyster_farmer':
          return 'Ostréiculteur'
        case 'riding_stable':
          return 'Centre Equestre'
        case 'winegrower':
          return 'Viticulteur'
      }
    },
    formatDate (date) {
      return dateFns.format(date, 'DD-MM-YYYY')
    },
    arrayFunctionEquipment () {
      let newValue = Object.keys(this.getOffer.equipment).filter(
        e => this.getOffer.equipment[e] === true
      )
      this.equipmentData = newValue
    },
    arrayFunctionDesc () {
      let newValue = Object.keys(this.getOffer.description).filter(
        e => this.getOffer.description[e] === true
      )
      this.activities = newValue
      newValue.forEach(element => {
        switch (element) {
          case 'meeting_animals':
            this.activitiesIcons.push('icon-binoculars')
            break
          case 'discovery':
            this.activitiesIcons.push('icon-gardening-boots')
            break
          case 'milking_animals':
            this.activitiesIcons.push('icon-cow-milking')
            break
          case 'craft':
            this.activitiesIcons.push('icon-stir')
            break
          case 'tasting':
            this.activitiesIcons.push('icon-taste')
            break
          case 'birth_animal':
            this.activitiesIcons.push('icon-bird-in-broken-egg')
            break
          case 'stroll':
            this.activitiesIcons.push('icon-tractor')
            break
          case 'harvest':
            this.activitiesIcons.push('icon-harvest')
            break
          default:
            break
        }
      })
      this.thirdIcon = this.activitiesIcons.slice(0, 3)
      this.lastIcons = this.activitiesIcons.slice(4, -1)
    },
    arrayFunctionAnimals () {
      let newValue = Object.keys(this.getOffer.animals).filter(
        e => this.getOffer.animals[e] === true
      )
      this.animals = newValue
      // :class="[`icon-${animal === 'milk_cow' ? 'milk-cow' : animal}`]"
      // 'cow', 'chicken', 'sheep', 'rabbit', 'goose', 'goat', 'duck', 'turkey', 'pig', 'milk_cow', 'donkey', 'snail', 'horse', 'bee', 'lama'
      newValue.forEach(element => {
        switch (element) {
          case 'chicken':
            this.animalsIcons.push('agri-animals icon-chicken')
            break
          case 'goose':
            this.animalsIcons.push('agri-animals icon-goose')
            break
          case 'cow':
            this.animalsIcons.push('agri-animals icon-cow')
            break
          case 'rabbit':
            this.animalsIcons.push('agri-animals icon-rabbit')
            break
          case 'sheep':
            this.animalsIcons.push('agri-animals icon-sheep')
            break
          case 'goat':
            this.animalsIcons.push('agri-animals icon-goat')
            break
          case 'duck':
            this.animalsIcons.push('agri-animals icon-duck')
            break
          case 'pig':
            this.animalsIcons.push('agri-animals icon-pig')
            break
          case 'milk_cow':
            this.animalsIcons.push('agri-animals icon-milk-cow')
            break
          case 'donkey':
            this.animalsIcons.push('agri-animals icon-donkey')
            break
          case 'snail':
            this.animalsIcons.push('agri-animals icon-snail')
            break
          case 'bee':
            this.animalsIcons.push('agri-others2 icon-bee')
            break
          case 'horse':
            this.animalsIcons.push('agri-animals icon-horse')
            break
          case 'turkey':
            this.animalsIcons.push('agri-animals icon-turkey')
            break
          case 'lama':
            this.animalsIcons.push('lama icon-lama')
            break
          default:
            break
        }
      })
      this.thirdAnimals = this.animalsIcons.slice(0, 3)
      this.lastAnimals = this.animalsIcons.slice(4, -1)
    },
    checkServices () {
      this.getOffer.annexe_service.forEach(element => {
        switch (element.name) {
          case 'Panier garnis':
            this.panierGarnis = element
            return element
          case 'Location de vélo':
            this.velos = element
            return element
          case 'Petit déjeuner':
            this.petitdej = element
            return element
          case 'Panier repas':
            this.panierrepas = element
            return element
          case 'Atelier cuisine':
            this.atelier = element
            return element
          case 'Activité bien-être':
            this.bienetre = element
            return element
          case 'Accès SPA':
            this.spa = element
            return element
          case 'Location de voiture':
            this.voiture = element
            return element
          case 'Trajet gare-ferme':
            this.trajet = element
            return element
          case 'Espace nuit pour animaux':
            this.animaux = element
            return element
          case "Table d'hôte":
            this.hote = element
            return element
          case 'Lave-linge / sèche-linge':
            this.washingkit = element
            return element
          case 'Barbecue':
            this.bbqservice = element
            return element
          case "Cours d'équitation":
            this.ridinglesson = element
            return element
          case 'Balade à cheval / en âne':
            this.horseride = element
            return element
          case "Stage d'équitation":
            this.ridingcourse = element
            return element
          case "Initiation à l'équitation":
            this.ridingintroduction = element
            return element
          case 'Immersion à la ferme':
            this.immersion = element
            return element
        }
      })
    },
    compt () {
      this.totalServices =
        this.servicesAnnexe.total.reduce((a, b) => a + (b['total'] || 0), 0) *
        100
      return this.servicesAnnexe.total.reduce(
        (a, b) => a + (b['total'] || 0),
        0
      )
    },
    analyseTotalImmersion (value) {
      this.servicesAnnexe.total[17].total = value
      this.compt()
    },
    analyseNumberImmersion (value) {
      this.servicesAnnexe.total[17].number = value
      this.compt()
    },
    analyseTotalRidingIntroduction (value) {
      this.servicesAnnexe.total[16].total = value
      this.compt()
    },
    analyseNumberRidingIntroduction (value) {
      this.servicesAnnexe.total[16].number = value
      this.compt()
    },
    analyseTotalRidingCourse (value) {
      this.servicesAnnexe.total[15].total = value
      this.compt()
    },
    analyseNumberRidingCourse (value) {
      this.servicesAnnexe.total[15].number = value
      this.compt()
    },
    analyseTotalHorseRide (value) {
      this.servicesAnnexe.total[14].total = value
      this.compt()
    },
    analyseNumberHorseRide (value) {
      this.servicesAnnexe.total[14].number = value
      this.compt()
    },
     analyseTotalRidingLesson (value) {
      this.servicesAnnexe.total[13].total = value
      this.compt()
    },
    analyseNumberRidingLesson (value) {
      this.servicesAnnexe.total[13].number = value
      this.compt()
    },
    analyseTotalBbq (value) {
      this.servicesAnnexe.total[12].total = value
      this.compt()
    },
    analyseNumberBbq (value) {
      this.servicesAnnexe.total[12].number = value
      this.compt()
    },
    analyseTotalWashingKit (value) {
      this.servicesAnnexe.total[11].total = value
      this.compt()
    },
    analyseNumberWashingKit (value) {
      this.servicesAnnexe.total[11].number = value
      this.compt()
    },
    analyseTotalHote (value) {
      this.servicesAnnexe.total[10].total = value
      this.compt()
    },
    analyseNumberHote (value) {
      this.servicesAnnexe.total[10].number = value
      this.compt()
    },
    analyseTotalAnimaux (value) {
      this.servicesAnnexe.total[9].total = value
      this.compt()
    },
    analyseNumberAnimaux (value) {
      this.servicesAnnexe.total[9].number = value
      this.compt()
    },
    analyseTotalTrajet (value) {
      this.servicesAnnexe.total[8].total = value
      this.compt()
    },
    analyseNumberTrajet (value) {
      this.servicesAnnexe.total[8].number = value
      this.compt()
    },
    analyseTotalLocation (value) {
      this.servicesAnnexe.total[7].total = value
      this.compt()
    },
    analyseNumberLocation (value) {
      this.servicesAnnexe.total[7].number = value
      this.compt()
    },
    analyseTotalSpa (value) {
      this.servicesAnnexe.total[6].total = value
      this.compt()
    },
    analyseNumberSpa (value) {
      this.servicesAnnexe.total[6].number = value
      this.compt()
    },
    analyseTotalBienEtre (value) {
      this.servicesAnnexe.total[5].total = value
      this.compt()
    },
    analyseNumberBienEtre (value) {
      this.servicesAnnexe.total[5].number = value
      this.compt()
    },
    analyseTotalAteliers (value) {
      this.servicesAnnexe.total[4].total = value
      this.compt()
    },
    analyseNumberAteliers (value) {
      this.servicesAnnexe.total[4].number = value
      this.compt()
    },
    analyseTotalPaniersRepas (value) {
      this.servicesAnnexe.total[3].total = value
      this.compt()
    },
    analyseNumberPaniersRepas (value) {
      this.servicesAnnexe.total[3].number = value
      this.compt()
    },
    analyseTotalPetitDej (value) {
      this.servicesAnnexe.total[2].total = value
      this.compt()
    },
    analyseNumberPetitDej (value) {
      this.servicesAnnexe.total[2].number = value
      this.compt()
    },
    analyseTotalVelo (value) {
      this.servicesAnnexe.total[1].total = value
      this.compt()
    },
    analyseNumberVelo (value) {
      this.servicesAnnexe.total[1].number = value
      this.compt()
    },
    analyseTotalPanier (value) {
      this.servicesAnnexe.total[0].total = value
      this.compt()
    },
    analyseNumberPanier (value) {
      this.servicesAnnexe.total[0].number = value
      this.compt()
    },
    updateDescPanier (value) {
      this.servicesAnnexe.total[0].questions = value
    },
    updateDescVelos (value) {
      this.servicesAnnexe.total[1].questions = value
    },
    updateDescPetitDej (value) {
      this.servicesAnnexe.total[2].questions = value
    },
    updateDescRepas (value) {
      this.servicesAnnexe.total[3].questions = value
    },
    updateDescAtelier (value) {
      this.servicesAnnexe.total[4].questions = value
    },
    updateDescActBienEtre (value) {
      this.servicesAnnexe.total[5].questions = value
    },
    updateDescSpa (value) {
      this.servicesAnnexe.total[6].questions = value
    },
    updateDescVoiture (value) {
      this.servicesAnnexe.total[7].questions = value
    },
    updateDescTrajet (value) {
      this.servicesAnnexe.total[8].questions = value
    },
    updateDescAnimaux (value) {
      this.servicesAnnexe.total[9].questions = value
    },
    updateDescHote (value) {
      this.servicesAnnexe.total[10].questions = value
    },
    updateDescWashingKit (value) {
      this.servicesAnnexe.total[11].questions = value
    },
    updateDescBbq (value) {
      this.servicesAnnexe.total[12].questions = value
    },
    updateDescRidingLesson (value) {
      this.servicesAnnexe.total[13].questions = value
    },
    updateDescHorseRide (value) {
      this.servicesAnnexe.total[14].questions = value
    },
    updateDescRidingCourse (value) {
      this.servicesAnnexe.total[15].questions = value
    },
    updateDescRidingIntroduction (value) {
      this.servicesAnnexe.total[16].questions = value
    },
    updateDescImmersion (value) {
      this.servicesAnnexe.total[17].questions = value
    },

    postAnnexeServices (servicesAnnexe) {
      if (servicesAnnexe[0].number !== 0) {
        this.panierGarnisPut = servicesAnnexe[0]
      }
      if (servicesAnnexe[1].number) {
        this.velosPut = servicesAnnexe[1]
      }
      if (servicesAnnexe[2].number) {
        this.petitdejPut = servicesAnnexe[2]
      }
      if (servicesAnnexe[3].number) {
        this.panierrepasPut = servicesAnnexe[3]
      }
      if (servicesAnnexe[4].number) {
        this.atelierPut = servicesAnnexe[4]
      }
      if (servicesAnnexe[5].number) {
        this.bienetrePut = servicesAnnexe[5]
      }
      if (servicesAnnexe[6].number) {
        this.spaPut = servicesAnnexe[6]
      }
      if (servicesAnnexe[7].number) {
        this.voiturePut = servicesAnnexe[7]
      }
      if (servicesAnnexe[8].number) {
        this.trajetPut = servicesAnnexe[8]
      }
      if (servicesAnnexe[9].number) {
        this.animauxPut = servicesAnnexe[9]
      }
      if (servicesAnnexe[10].number) {
        this.hotePut = servicesAnnexe[10]
      }
      if (servicesAnnexe[11].number) {
        this.washingkitPut = servicesAnnexe[11]
      }
      if (servicesAnnexe[12].number) {
        this.bbqPut = servicesAnnexe[12]
      }
      if (servicesAnnexe[13].number) {
        this.ridinglessonPut = servicesAnnexe[13]
      }
      if (servicesAnnexe[14].number) {
        this.horseridePut = servicesAnnexe[14]
      }
      if (servicesAnnexe[15].number) {
        this.ridingcoursePut = servicesAnnexe[15]
      }
      if (servicesAnnexe[16].number) {
        this.ridingintroductionPut = servicesAnnexe[16]
      }
      if (servicesAnnexe[17].number) {
        this.immersionPut = servicesAnnexe[17]
      }

      let panierGarnis = this.panierGarnisPut
      let locVelos = this.velosPut
      let ptitDej = this.petitdejPut
      let panierRepas = this.panierrepasPut
      let atelierCuisine = this.atelierPut
      let bienEtre = this.bienetrePut
      let spa = this.spaPut
      let locVoiture = this.voiturePut
      let trajetGare = this.trajetPut
      let animaux = this.animauxPut
      let hote = this.hotePut
      let washingkit = this.washingkitPut
      let bbq = this.bbqPut
      let ridinglesson = this.ridinglessonPut
      let horseride = this.horseridePut
      let ridingcourse = this.ridingcoursePut
      let ridingintroduction = this.ridingintroductionPut
      let immersion = this.immersionPut
      this.$wait.start('send annexes services')
      this.$axios
        .put(`/bookings/${this.getBooking.id}`, {
          booking: {
            panier_nb: panierGarnis.number,
            panier_msg: panierGarnis.questions,
            panier_total: panierGarnis.total,
            bike_rent_nb: locVelos.number,
            bike_rent_price: locVelos.total,
            bike_rent_msg: locVelos.questions,
            breakfast_nb: ptitDej.number,
            breakfast_price: ptitDej.total,
            breakfast_msg: ptitDej.questions,
            packed_lunch_nb: panierRepas.number,
            packed_lunch_price: panierRepas.total,
            packed_lunch_msg: panierRepas.questions,
            cooking_workshop_nb: atelierCuisine.number,
            cooking_workshop_price: atelierCuisine.total,
            cooking_workshop_msg: atelierCuisine.questions,
            serenity_nb: bienEtre.number,
            serenity_price: bienEtre.total,
            serenity_msg: bienEtre.questions,
            spa_nb: spa.number,
            spa_price: spa.total,
            spa_msg: spa.questions,
            car_rent_nb: locVoiture.number,
            car_rent_price: locVoiture.total,
            car_rent_msg: locVoiture.questions,
            station_ride_nb: trajetGare.number,
            station_ride_price: trajetGare.total,
            station_ride_msg: trajetGare.questions,
            animal_space_nb: animaux.number,
            animal_space_price: animaux.total,
            animal_space_msg: animaux.questions,
            host_table_nb: hote.number,
            host_table_price: hote.total,
            host_table_msg: hote.questions,
            washing_kit_nb: washingkit.number,
            washing_kit_price: washingkit.total,
            washing_kit_msg: washingkit.questions,
            bbq_nb: bbq.number,
            bbq_price: bbq.total,
            bbq_msg: bbq.questions,
            riding_lesson_nb: ridinglesson.number,
            riding_lesson_price: ridinglesson.total,
            riding_lesson_msg: ridinglesson.questions,
            horse_ride_nb: horseride.number,
            horse_ride_price: horseride.total,
            horse_ride_msg: horseride.questions,
            riding_course_nb: ridingcourse.number,
            riding_course_price: ridingcourse.total,
            riding_course_msg: ridingcourse.questions,
            riding_introduction_nb: ridingintroduction.number,
            riding_introduction_price: ridingintroduction.total,
            riding_introduction_msg: ridingintroduction.questions,
            immersion_nb: immersion.number,
            immersion_price: immersion.total,
            immersion_msg: immersion.questions,
            annexe_services_total: this.totalServices,
            status: 'allSet'
          }
        })
        .then(bookingRes => {
          this.$router.push({
            name: 'Booking',
            params: {
              id: this.getBooking.id
            }
          })
        })
        .catch(bookingErr => {
          this.error = true
          console.error('booking error', bookingErr)
        })
        .finally(() => {
          this.loading = false
        })
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.icon-rooms {
  width: 30px;
  height: 30px;
}

a {
  text-decoration: none;
}
.tinyBookingContainer {
  min-height: 1200px;
  .infos_tiny {
    padding: 75px 100px;
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    @media only screen and (max-width: $breakpoint-tablet) {
      grid-template-columns: auto;
      padding: 75px 10px;
    }
    .title {
      font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
        Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
      color: $agri-green;
      h3 {
        font-weight: 400;
      }
      .nameLogo {
        display: flex;
        align-items: center;
        margin-top: 25px;
        p {
          font-weight: 800;
        }
        img {
          width: 30px;
          height: 30px;
          margin-right: 15px;
        }
      }
      .recap {
        .title {
          margin-top: 65px;
        }
        .cadres {
          display: flex;
          @media only screen and (max-width: $breakpoint-tablet) {
            display: grid;
            grid-template-columns: auto;
          }
          .lelogement {
            width: 396px;
            height: 202px;
            border: 1px solid $agri-green;
            border-radius: 30px;
            margin-top: 15px;
            .content {
              width: 100%;
              height: 100%;
              padding: 10px 45px;
              .title {
                margin: 0;
                p {
                  margin: 0;
                  padding: 0;
                  font-size: 18px;
                }
              }
              .grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                grid-template-rows: repeat(6, 1fr);
                grid-gap: 15px;
                margin: 15px auto 0 auto;
                .elements {
                  display: flex;
                  align-items: center;
                  .images {
                    color: $agri-green !important;
                  }
                  p {
                    font-size: 14px;
                    margin-left: 15px;
                    font-weight: 500;
                  }
                }
              }
            }
          }
          .laferme {
            width: 315px;
            height: 202px;
            border: 1px solid $agri-green;
            border-radius: 30px;
            margin-top: 15px;
            margin-left: 40px;
            .content {
              width: 100%;
              height: 100%;
              padding: 10px 45px;
              .title {
                margin: 0;
                p {
                  margin: 0;
                  padding: 0;
                  font-size: 18px;
                }
              }
              .elements {
                display: flex;
                justify-content: flex-end;
                margin-top: 15px;
                align-items: center;
                p {
                  font-size: 14px;
                  margin-right: 10px;
                  font-weight: 500;
                }
                .images {
                  display: grid;
                  grid-template-columns: repeat(4, 1fr);
                  grid-gap: 10px;
                }
              }
            }
          }
        }
      }
    }
    .images {
      display: grid;
      grid-template-areas:
        "grandephoto grandephoto"
        "petitephoto1 petitephoto2";
      width: 50%;
      margin: 0 auto;
      grid-gap: 10px;
      @media only screen and (max-width: $breakpoint-mobile-large) {
        width: 100%;
        grid-template-columns: auto;
      }
      .grandephoto {
        width: 436px;
        height: 329px;
        grid-area: grandephoto;
      }
      .petitephoto1 {
        width: 186px;
        height: 172px;
        grid-area: petitephoto1;
      }
      .petitephoto2 {
        width: 242px;
        height: 172px;
        grid-area: petitephoto2;
      }
    }
    h3 {
      padding: 0;
      margin: 0;
    }
    p {
      margin: 0;
      padding: 0;
    }
  }
  .lesplus {
    background-color: $agri-grey;
    width: 422px;
    height: 55px;
    margin: 0 100px;
    display: flex;
    align-items: center;
    border-radius: 10px;
    padding: 0 15px;
    @media only screen and (max-width: $breakpoint-tablet) {
      margin: 0px;
    }
    p {
      color: $agri-green;
      font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
        Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
      font-weight: 500;
      margin-right: 15px;
    }
    img {
      margin-right: 15px;
      width: 30px;
      height: 30px;
    }
  }
  .recapInfos {
    display: flex;
    @media only screen and (max-width: $breakpoint-tablet) {
      display: grid;
      grid-template-columns: auto;
    }
    .infos {
      padding: 0 100px;
      @media only screen and (max-width: $breakpoint-tablet) {
        grid-template-columns: auto;
        padding: 0 10px;
      }
      p {
        font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
          Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
        color: black;
        font-weight: 200;
        font-size: 20px;
        span {
          color: black;
          font-weight: 700;
          font-size: 20px;
        }
      }
    }
  }
  .fraisSup {
    padding: 0;
    width: 75%;
    margin: 0 auto;
    @media only screen and (max-width: $breakpoint-tablet) {
      width: 100%;
    }
    .title {
      text-align: center;
      h3 {
        font-weight: 500;
        font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
          Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
      }
    }
    .button {
      display: flex;
      justify-content: center;
      @media only screen and (max-width: $breakpoint-mobile-large) {
        display: grid;
        grid-template-columns: auto;
      }
      .validate {
        cursor: pointer;
        background-color: $agri-green-light !important;
        border: solid 1px $agri-white;
        color: $agri-white;
        box-shadow: none !important;
        border-radius: 50px;
        font-size: 20px;
        font-weight: 900;
        line-height: 27px;
        margin: 70px 0 70px 0 !important;
        padding: 8px 20px;
        font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
          Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
        box-shadow: 0px 0px 10px black;
      }
    }
    .total {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      @media only screen and (max-width: $breakpoint-mobile-large) {
        grid-template-columns: auto;
      }
      height: 170px;
      .text {
        display: flex;
        flex-direction: column;
        border-left: 1px solid black;
        p {
          margin: 0;
          padding: 0;
          font-size: 30px;
          font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
            Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
          font-weight: 700;
          margin: 0;
          padding: 0 0 0 55px;
        }
      }
    }
  }
}
</style>
