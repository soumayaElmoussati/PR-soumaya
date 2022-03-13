<template>
  <div class="offer-card">
    <div class="card-farm">
      <div class="img-details">
        <img
          v-if="offer.certificated"
          :src="certified"
          class="macaron"
          alt="membre certifié"
        >

        <mq-layout mq="lg">
          <vueper-slides
            v-if="offer.pictures.length"
            ref="myVueperSlides"
            :pause-on-hover="pauseOnHover"
            :breakpoints="{ 800: { visibleSlides: 1, slideMultiple: 1 } }"
            :duration="8000"
            autoplay
            fixed-height="270px"
            style="width: 100%"
            @autoplay-pause="internalAutoPlaying = false"
            @autoplay-resume="internalAutoPlaying = true"
          >
            <template v-slot:arrow-left>
              <i
                class="fas fa-arrow-circle-left"
                style="color: rgb(71, 100, 88); font-size: 45px"
              />
            </template>

            <template v-slot:arrow-right>
              <i
                class="fas fa-arrow-circle-right"
                style="color: rgb(71, 100, 88); font-size: 45px"
              />
            </template>
            <vueper-slide
              v-for="(photo, i) in offer.pictures.slice(0, 5)"
              :key="i">
              <template v-slot:content>
                <div
                  :style="
                    'background-image: url(' +
                      `https://res.cloudinary.com/agrivillage/image/upload/w_430,h_270,c_fill,f_jpg,fl_progressive/${photo.public_id}` +
                      '); width: 100%; background-size: cover'
                  "
                  class="vueperslide__content-wrapper"
                />
              </template>
            </vueper-slide>
          </vueper-slides>
          <div
            v-if="offer.pictures.length === 0"
            class="offer-card-image__empty">
            <span>
              {{ $t("offer.titles.no_images") }}
            </span>
          </div>
        </mq-layout>
        <mq-layout mq="md">
          <vueper-slides
            v-if="offer.pictures.length"
            ref="myVueperSlides"
            :pause-on-hover="pauseOnHover"
            :breakpoints="{ 800: { visibleSlides: 1, slideMultiple: 1 } }"
            :duration="8000"
            autoplay
            fixed-height="270px"
            style="width: 100%"
            @autoplay-pause="internalAutoPlaying = false"
            @autoplay-resume="internalAutoPlaying = true"
          >
            <template v-slot:arrow-left>
              <i
                class="fas fa-arrow-circle-left"
                style="color: rgb(71, 100, 88); font-size: 45px"
              />
            </template>

            <template v-slot:arrow-right>
              <i
                class="fas fa-arrow-circle-right"
                style="color: rgb(71, 100, 88); font-size: 45px"
              />
            </template>
            <vueper-slide
              v-for="(photo, i) in offer.pictures.slice(0, 5)"
              :key="i">
              <template v-slot:content>
                <div
                  :style="
                    'background-image: url(' +
                      `https://res.cloudinary.com/agrivillage/image/upload/w_430,h_270,c_fill,f_jpg,fl_progressive/${photo.public_id}` +
                      '); width: 100%; background-size: cover'
                  "
                  class="vueperslide__content-wrapper"
                />
              </template>
            </vueper-slide>
          </vueper-slides>
          <div
            v-if="offer.pictures.length === 0"
            class="offer-card-image__empty">
            <span>
              {{ $t("offer.titles.no_images") }}
            </span>
          </div>
        </mq-layout>
        <mq-layout mq="sm">
          <cloudinary
            v-if="offer.pictures.length"
            :public-id="offer.pictures[0].public_id"
            :itemkey="offer.id.toString()"
            :transformations="{
              w: 214,
              h: 260,
              c: 'fill',
              f: 'jpg',
              fl: 'progressive'
            }"
            :alt="offer.name"
          />
          <div
            v-else
            class="offer-card-image__empty"
          >
            <span>
              {{ $t('offer.titles.no_images') }}
            </span>
          </div>
        </mq-layout>

        <nuxt-link

        >
          <div class="name-equipment">
            <div class="farm-name">
              <div class="name">
                {{ residenceTypeAdress }}
                <img
                  :src="mark"
                  alt="location" >
                <span v-if="offer.address.city.length < 10">
                  {{ offer.address.city }} ({{ offer.address.postal_code.substr(0, 2) }}) </span>
                <span v-else>{{
                  offer.address.city.substring(0, 10) + "..."
                }}</span>
              </div>

              <div class="farm-equipment">
                <img
                  v-if="equipmentData.includes('wifi')"
                  :src="wifi"
                  alt="wifi"
                >
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
                  alt="train"
                >
                <img
                  v-if="settlementData.includes('animals_welcome')"
                  :src="animalsImage"
                  alt="animaux autorisés"
                >
                <img
                  v-if="equipmentData.includes('private_garden')"
                  :src="terrace"
                  alt="jardin privé"
                >
                <img
                  v-if="equipmentData.includes('kitchen')"
                  :src="kitchen"
                  alt="acces cuisine"
                >
                <img
                  v-if="equipmentData.includes('bbq')"
                  :src="bbq"
                  alt="barbecue"
                >
                <img
                  v-if="settlementData.includes('accessible')"
                  :src="handicap"
                  alt="mobilité réduite"
                >
                <img
                  v-if="settlementData.includes('baby_suitable')"
                  :src="baby"
                  alt="bébé autorisé"
                >
              </div>

              <!-- <div class="services-icons">
                <i
                  v-for="(icon, k) in servicesIcons"
                  :key="icon + k"
                  :class="icon"
                />
              </div> -->
              <!-- Traduction des exploitations -->
              <div class="farm-type-mobile">
                <div
                  v-if="farmType(offer.farm_types)[0] == 'agroforestry'"
                  class="exploitation-type"
                >
                  {{ $t("offer.farmTypes.agroforestry") }}
                </div>
                <div
                  v-if="farmType(offer.farm_types)[0] == 'arborist'"
                  class="exploitation-type"
                >
                  {{ $t("offer.farmTypes.arborist") }}
                </div>
                <div
                  v-if="farmType(offer.farm_types)[0] == 'beekeeper'"
                  class="exploitation-type"
                >
                  {{ $t("offer.farmTypes.beekeeper") }}
                </div>
                <div
                  v-if="farmType(offer.farm_types)[0] == 'breeder'"
                  class="exploitation-type"
                >
                  {{ $t("offer.farmTypes.breeder") }}
                </div>
                <div
                  v-if="farmType(offer.farm_types)[0] == 'brewer'"
                  class="exploitation-type"
                >
                  {{ $t("offer.farmTypes.brewer") }}
                </div>
                <div
                  v-if="farmType(offer.farm_types)[0] == 'cereal'"
                  class="exploitation-type"
                >
                  {{ $t("offer.farmTypes.cereal") }}
                </div>
                <div
                  v-if="farmType(offer.farm_types)[0] == 'cheese_production'"
                  class="exploitation-type"
                >
                  {{ $t("offer.farmTypes.cheese_production") }}
                </div>
                <div
                  v-if="farmType(offer.farm_types)[0] == 'cider_maker'"
                  class="exploitation-type"
                >
                  {{ $t("offer.farmTypes.cider_maker") }}
                </div>
                <div
                  v-if="farmType(offer.farm_types)[0] == 'horticulturist'"
                  class="exploitation-type"
                >
                  {{ $t("offer.farmTypes.horticulturist") }}
                </div>
                <div
                  v-if="farmType(offer.farm_types)[0] == 'market_gardener'"
                  class="exploitation-type"
                >
                  {{ $t("offer.farmTypes.market_gardener") }}
                </div>
                <div
                  v-if="farmType(offer.farm_types)[0] == 'mushroom_grower'"
                  class="exploitation-type"
                >
                  {{ $t("offer.farmTypes.myciculture") }}
                </div>
                <div
                  v-if="farmType(offer.farm_types)[0] == 'oyster_farmer'"
                  class="exploitation-type"
                >
                  {{ $t("offer.farmTypes.oyster_farmer") }}
                </div>
                <div
                  v-if="farmType(offer.farm_types)[0] == 'riding_stable'"
                  class="exploitation-type"
                >
                  {{ $t("offer.farmTypes.riding_stable") }}
                </div>
                <div
                  v-if="farmType(offer.farm_types)[0] == 'winegrower'"
                  class="exploitation-type"
                >
                  {{ $t("offer.farmTypes.winegrower") }}
                </div>
              </div>
              <!-- END -->
            </div>
            <div class="price">
              <div class="total">
                <p>
                  {{ $t("search.card.from") }}

                  <span>{{ getBestPrice | currency }}</span
                  >{{ $t("search.card.per_night") }}
                </p>
              </div>
            </div>
            <div >
              <button
                type="button"
                class="btn booking-button" >
                Réserver
              </button>
            </div>
          </div>

        </nuxt-link>

      </div>
      <nuxt-link
        :to="{
          name: 'Offer',
          params: {
            id: offer.id,
            slug: offer.slug,
            domaine: residenceType
          }
        }"
        target="_blank"
        class="details-activity"
      >
        <div
          v-if="hasPromotion"
          class="promotion-box">
          <img
            alt="promotion"
            class="chicken"
            src="@/assets/img/offer/chicken.svg"
            width="35"
            height="35"
          >

          <div class="promotion-text">
            <p>
              <span class="promotion-amount">-{{ getPromotion.amount }}%</span> {{ $t("offer.titles.from") }}
              {{ getStartDate }} {{ $t("offer.titles.at") }} {{ getEndDate }}
            </p>
          </div>
        </div>
        <div class="number-pers">
          <img
            :src="persons"
            alt="persons" >
          {{
            $tc("search.card.people", offer.max_people_count, {
              number: offer.max_people_count
            })
          }}
        </div>
        <div class="number-rooms">
          <img
            :src="bed"
            alt="bed" >
          {{
            $tc("search.card.rooms", offer.rooms_count, {
              number: offer.rooms_count
            })
          }}
        </div>
        <div class="number-bathrooms">
          <img
            :src="bathtub"
            alt="" >
          {{
            $tc("search.card.bathrooms", offer.bathrooms_count, {
              number: offer.bathrooms_count
            })
          }}
        </div>
        <div class="services-icons">
          <i
            v-for="(icon, k) in servicesIcons"
            :key="icon + k"
            :class="icon" />
        </div>
        <div class="line-separate" />
        <!-- Traduction des exploitations -->
        <div class="farm-type">
          <div
            v-if="farmType(offer.farm_types)[0] == 'agroforestry'"
            class="exploitation-type"
          >
            {{ $t("offer.farmTypes.agroforestry") }}
          </div>
          <div
            v-if="farmType(offer.farm_types)[0] == 'arborist'"
            class="exploitation-type"
          >
            {{ $t("offer.farmTypes.arborist") }}
          </div>
          <div
            v-if="farmType(offer.farm_types)[0] == 'beekeeper'"
            class="exploitation-type"
          >
            {{ $t("offer.farmTypes.beekeeper") }}
          </div>
          <div
            v-if="farmType(offer.farm_types)[0] == 'breeder'"
            class="exploitation-type"
          >
            {{ $t("offer.farmTypes.breeder") }}
          </div>
          <div
            v-if="farmType(offer.farm_types)[0] == 'brewer'"
            class="exploitation-type"
          >
            {{ $t("offer.farmTypes.brewer") }}
          </div>
          <div
            v-if="farmType(offer.farm_types)[0] == 'cereal'"
            class="exploitation-type"
          >
            {{ $t("offer.farmTypes.cereal") }}
          </div>
          <div
            v-if="farmType(offer.farm_types)[0] == 'cheese_production'"
            class="exploitation-type"
          >
            {{ $t("offer.farmTypes.cheese_production") }}
          </div>
          <div
            v-if="farmType(offer.farm_types)[0] == 'cider_maker'"
            class="exploitation-type"
          >
            {{ $t("offer.farmTypes.cider_maker") }}
          </div>
          <div
            v-if="farmType(offer.farm_types)[0] == 'horticulturist'"
            class="exploitation-type"
          >
            {{ $t("offer.farmTypes.horticulturist") }}
          </div>
          <div
            v-if="farmType(offer.farm_types)[0] == 'market_gardener'"
            class="exploitation-type"
          >
            {{ $t("offer.farmTypes.market_gardener") }}
          </div>
          <div
            v-if="farmType(offer.farm_types)[0] == 'mushroom_grower'"
            class="exploitation-type"
          >
            {{ $t("offer.farmTypes.myciculture") }}
          </div>
          <div
            v-if="farmType(offer.farm_types)[0] == 'oyster_farmer'"
            class="exploitation-type"
          >
            {{ $t("offer.farmTypes.oyster_farmer") }}
          </div>
          <div
            v-if="farmType(offer.farm_types)[0] == 'riding_stable'"
            class="exploitation-type"
          >
            {{ $t("offer.farmTypes.riding_stable") }}
          </div>
          <div
            v-if="farmType(offer.farm_types)[0] == 'winegrower'"
            class="exploitation-type"
          >
            {{ $t("offer.farmTypes.winegrower") }}
          </div>
        </div>
        <!-- END -->
        <!-- Traduction des agricultures -->
        <div class="agri-type">
          <div
            v-if="agriType(offer.agriculture_types)[0] == 'agroecological'"
            class="agriculture-type"
          >
            {{ $t("offer.agricultureTypes.agroecology") }}
          </div>
          <div
            v-if="agriType(offer.agriculture_types)[0] == 'agroecology'"
            class="agriculture-type"
          >
            {{ $t("offer.agricultureTypes.agroecology") }}
          </div>
          <div
            v-if="agriType(offer.agriculture_types)[0] == 'biological'"
            class="agriculture-type"
          >
            {{ $t("offer.agricultureTypes.bio") }}
          </div>
          <div
            v-if="agriType(offer.agriculture_types)[0] == 'conventional'"
            class="agriculture-type"
          >
            {{ $t("offer.agricultureTypes.conventional") }}
          </div>
          <div
            v-if="agriType(offer.agriculture_types)[0] == 'durable'"
            class="agriculture-type"
          >
            {{ $t("offer.agricultureTypes.durable") }}
          </div>
          <div
            v-if="agriType(offer.agriculture_types)[0] == 'hydroponics'"
            class="agriculture-type"
          >
            {{ $t("offer.agricultureTypes.hydroponics") }}
          </div>
          <div
            v-if="agriType(offer.agriculture_types)[0] == 'permaculture'"
            class="agriculture-type"
          >
            {{ $t("offer.agricultureTypes.permaculture") }}
          </div>
          <div
            v-if="agriType(offer.agriculture_types)[0] == 'reliability'"
            class="agriculture-type"
          >
            {{ $t("offer.agricultureTypes.conventional") }}
          </div>
          <div
            v-if="agriType(offer.agriculture_types)[0] == 'ringing'"
            class="agriculture-type"
          >
            {{ $t("offer.agricultureTypes.ringing") }}
          </div>
          <!-- END -->
        </div>

        <div class="img">
          <div class="activities">
            <!-- <i class="fas fa-shoe-prints" />
              <i class="fas fa-skiing-nordic" /> -->
            <div
              v-for="(icon, k) in thirdIcon"
              :key="icon + k"
              class="show-activities"
            >
              <i
                :class="'agri-others2' + ' ' + icon"
                aria-hidden="true"
                style="font-size: 20px"
              />
            </div>
            <i
              v-if="!showIcons && lastIcons.length !== 0"
              class="fas fa-ellipsis-h"
              style="z-index: 1000; position: relative"
            />
            <div
              v-for="(icon, k) in lastIcons"
              :key="icon + k">
              <i
                v-if="showIcons"
                :class="'agri-others2' + ' ' + icon"
                aria-hidden="true"
                style="font-size: 20px"
                class="hidden-activities"
              />
            </div>
          </div>
          <div class="animals">
            <div
              v-for="(animal, k) in thirdAnimals"
              :key="animal + k"
              class="show-animals"
            >
              <i :class="animal" />
            </div>
            <i
              v-if="!showIconsAnimals && lastAnimals.length !== 0"
              class="fas fa-ellipsis-h"
              style="z-index: 1000; position: relative"
            />
            <div
              v-for="(icon, k) in lastAnimals"
              :key="icon + k">
              <i
                v-if="showIconsAnimals"
                :class="icon"
                aria-hidden="true" />
            </div>
          </div>
          <div class="price-mobile">
            <div class="total">
              <p>
                {{ $t("search.card.from") }}
                <span>{{ getBestPrice | currency }}</span
                >{{ $t("search.card.per_night") }}
              </p>
            </div>
          </div>
        </div>
      </nuxt-link>
    </div>
  </div>
</template>

<script>
import { VueperSlides, VueperSlide } from 'vueperslides'
import 'vueperslides/dist/vueperslides.css'
import { mapGetters } from 'vuex'
import moment from 'moment'
import Cloudinary from '@/components/Cloudinary'
import mark from '@/assets/img/resultsCards/location.png'
import persons from '@/assets/img/resultsCards/persons.png'
import bed from '@/assets/img/resultsCards/bed.png'
import bathtub from '@/assets/img/resultsCards/bathtub.png'
import wifi from '@/assets/img/equipments/wifi_white.png'
import pool from '@/assets/img/equipments/pool_white.png'
import parking from '@/assets/img/equipments/parking_white.png'
import train from '@/assets/img/equipments/train_white.png'
import animalsImage from '@/assets/img/equipments/animal_white.png'
import bbq from '@/assets/img/equipments/bbq_white.png'
import handicap from '@/assets/img/equipments/handicap_white.png'
import kitchen from '@/assets/img/equipments/kitchen_white.png'
import terrace from '@/assets/img/equipments/terrace_white.png'
import baby from '@/assets/img/equipments/baby_white.png'
import certified from '@/assets/img/resultsCards/Membre_Certifie.png'

export default {
  name: 'OfferCardTest',
  components: {
    Cloudinary,
    VueperSlides,
    VueperSlide
  },
  props: { offer: { type: Object, default: null } },
  data () {
    return {
      mark,
      bed,
      bathtub,
      persons,
      wifi,
      pool,
      baby,
      parking,
      train,
      bbq,
      handicap,
      kitchen,
      terrace,
      animalsImage,
      certified,
      discovery: this.offer.description.discovery ? 'icon-gardening-boots' : '',
      activities: [],
      animals: [],
      services: [],
      equipmentData: [],
      settlementData: [],
      animalsIcons: [],
      activitiesIcons: [],
      lastIcons: [],
      thirdIcon: [],
      thirdAnimals: [],
      lastAnimals: [],
      servicesIcons: [],
      last: [],
      showIcons: false,
      showIconsAnimals: false,
      pauseOnHover: true,
      autoPlaying: true,
      internalAutoPlaying: true,
      transformations: {
        w: 430,
        h: 270,
        c: 'fill',
        f: 'jpg',
        fl: 'progressive'
      },
      slides: [
        {
          id: 'slide-1',
          title: 'Slide <b style="font-size: 1.3em;color: yellow">#1</b>',
          content:
            'Slide title can be HTML.<br>And so does the slide content, <span style="font-size: 1.2em;color: yellow">why not?</span>'
        },
        {
          id: 'slide-2',
          title: 'Slide <b style="font-size: 1.3em;color: red">#1</b>',
          content:
            'Slide title can be HTML.<br>And so does the slide content, <span style="font-size: 1.2em;color: yellow">why not?</span>'
        }
      ]
    }
  },
  computed: {
    ...mapGetters(['getActivity', 'getOffer']),
    // NOTE: Check if Offer have a promotion
    hasPromotion () {
      var l = this.offer.promotions.length - 1
      if (l === -1) {
        return false
      } else {
        return true
      }
    },
    // NOTE: Get the offer promotion
    getPromotion () {
      return this.offer.promotions[0]
    },
    // NOTE: Start date of the promotion
    getStartDate () {
      return moment(this.offer.promotions[0].start_date).format('DD/MM')
    },
    // NOTE: End date of the promotion
    getEndDate () {
      return moment(this.offer.promotions[0].end_date).format('DD/MM')
    },
    residenceType () {
      // NOTE: Type de logement
      switch (this.offer.residence_type) {
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
    residenceTypeAdress () {
      // NOTE: Residence type return French translation
      switch (this.offer.residence_type) {
        case 'entire_house':
          return 'Logement entier'
        case 'private_room':
          return 'Chambre privée'
        case 'guest_room':
          return 'Chambre d\'hote'
        case 'unusual_room':
          return 'Logement insolite'
        case 'tiny_house':
          return 'Tiny House'
        case 'immersive_house':
          return 'Logement en immersion'
      }
    },
    getTransformations () {
      const transformations = this.transformations || {}
      const transformationKeys = Object.keys(transformations)
      const trans = transformationKeys.map(key => {
        return `${key}_${this.transformations[key]}`
      })

      return trans.join(',') + (trans.length > 0 ? '/' : '')
    },
    getBestPrice () {
      var allPrices = []
      var p = this.offer.price_periods.length - 1
      var today = new Date()

      allPrices.push(this.offer.price_per_person)

      if (p !== -1) {
        // Si il n'y a pas de period de prix
        this.offer.price_periods.forEach(period => {
          var periodDate = new Date(period.end_date)
          if (periodDate >= today) {
            allPrices.push(period.price_period)
          }
        })
      }

      var minPrice = Math.min(...allPrices)

      return minPrice
    }
  },
  mounted () {
    this.arrayFunctionDesc()
    this.arrayFunctionAnimals()
    this.arrayFunctionServices()
    this.arrayFunctionEquipment()
    this.arrayFunctionSettlement()
  },
  methods: {
    showMore () {
      this.showIcons = !this.showIcons
    },
    showMoreAnimals () {
      this.showIconsAnimals = !this.showIconsAnimals
    },
    farmType (type) {
      let keys = delete type.id
      keys = Object.keys(type)
      let filtered = keys.filter(function (key) {
        return type[key]
      })
      return filtered
    },
    agriType (type) {
      let keys = delete type.id
      keys = Object.keys(type)
      let filtered = keys.filter(function (key) {
        return type[key]
      })
      return filtered
    },
    arrayFunctionDesc () {
      let newValue = Object.keys(this.offer.description).filter(
        e => this.offer.description[e] === true
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
      this.thirdIcon = this.activitiesIcons.slice(0, 4)
      this.lastIcons = this.activitiesIcons.slice(4, -1)
    },
    arrayFunctionAnimals () {
      let newValue = Object.keys(this.offer.animals).filter(
        e => this.offer.animals[e] === true
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
      this.thirdAnimals = this.animalsIcons.slice(0, 4)
      this.lastAnimals = this.animalsIcons.slice(3, -1)
    },
    arrayFunctionServices () {
      let newValue = Object.keys(this.offer.services).filter(
        e => this.offer.services[e] === true
      )
      this.services = newValue
      newValue.forEach(element => {
        switch (element) {
          case 'breakfast':
            this.servicesIcons.push('agri-animals icon-breakfast')
            break
          case 'linens':
            this.servicesIcons.push('agri-others icon-towel')
            break
          case 'cleaning':
            this.servicesIcons.push('agri-animals icon-clean')
            break
          case 'host_table':
            this.servicesIcons.push('agri-animals icon-dish')
            break
          default:
            break
        }
      })
    },
    arrayFunctionEquipment () {
      let newValue = Object.keys(this.offer.equipment).filter(
        e => this.offer.equipment[e] === true
      )
      this.equipmentData = newValue
    },
    arrayFunctionSettlement () {
      let newValue = Object.keys(this.offer.settlement).filter(
        e => this.offer.settlement[e] === true
      )
      this.settlementData = newValue
    }
  }
}
</script>

<style lang="scss" scoped>
@import "vueperslides/dist/vueperslides.css";
@import "@/assets/scss/_variables.scss";

.chicken {
  @media only screen and (max-width: $breakpoint-tablet) {
    display: none;
    max-width: 100%;
  }
  width: 35px !important;
  height: 35px !important;
}

.promotion-box {

  background-color: #efce4a;
  padding: 0px 10px;
  box-shadow: 0px 0px 10px black;

  display: grid;
  grid-template-columns: auto auto;
  justify-content: space-around;

  border-radius: 10px;

  @media only screen and (max-width: $breakpoint-mobile-large) {
    width: 100px;
  }
}

.promotion-text {
  color: black;
  text-transform: uppercase;
  font-weight: bold;
  font-size: 11px;
  @media only screen and (max-width: $breakpoint-tablet) {
    font-size: 8px;
  }
}

.promotion-amount {
  color: $agri-green;
}

a {
  text-decoration: none;
  margin: 0;
  padding: 0;
}
.offer-card {
  z-index: 1;
  position: relative;
}
.cloudinary {
  /* width: 430px; */
  width: 100%;
  height: 271px;
  @media only screen and (max-width: $breakpoint-mobile-large) {
    /* width: 310px; */
    width: auto;
    /* height: 270px; */
  }
  @media only screen and (max-width: $breakpoint-mobile-m) {
    /* width: 265px; */
    width: auto;
   /*  height: 270px; */
  }
  @media only screen and (max-width: $breakpoint-mobile-s) {
    width: auto;
   /*  height: 270px; */
  }
}
.card-farm {
  display: flex;
  background-color: #476458;
  box-shadow: 1px 1px 5px black;
  width: 600px;
  height: 400px;
  margin: auto auto;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  z-index: 1;
  .img-details {
    @media only screen and (max-width: $breakpoint-laptop-generic) {
      width: 72%;
    }
    img {
      /* width: 430px; */
      width: 100%;
      height: 270px;
      @media only screen and (max-width: $breakpoint-mobile-m) {
        flex-direction: column;
      }
    }
    .macaron {
      position: absolute;
      width: 40px;
      height: 40px;
      margin-top: 243px !important;
      /* margin-left: 390px; */
      left: 57%;
      z-index: 5000;
      @media only screen and (max-width: $breakpoint-mobile-m) {
        /* margin-left: 210px !important;
        margin-top: 120px !important; */
        width: 30px;
        height: 30px;
      }
      @media only screen and (max-width: 1280px) {
        // margin-left: 395px !important;
        width: 35px;
        height: 35px;
      }
      /* @media only screen and (max-width: $breakpoint-mobile-l) {
        margin-left: 210px !important;
        margin-top: 120px !important;
      }
      @media only screen and (max-width: 375px) {
        margin-left: 210px !important;
        margin-top: 120px !important;
      } */
    }
    .offer-card-image__empty {
      background-color: lighten(#d1d1d1, 10%);
      width: 430px;
      height: 270px;
      display: flex;
      justify-content: center;
      align-items: center;
      color: rgba(black, 0.5);
      margin: auto;
      @media only screen and (max-width: $breakpoint-laptop-generic) {
        width: 100%;
      }
      @media only screen and (max-width: $breakpoint-mobile-large) {
        /* width: 310px; */
        width: 100%;
        height: 271px;
      }
      @media only screen and (max-width: $breakpoint-mobile-m) {
        /* width: 265px !important; */
        width: 100%;
        height: 271px;
      }
      @media only screen and (max-width: $breakpoint-mobile-s) {
        /* width: 215px !important; */
        width: 100%;
        height: 271px;
      }
    }
    .name-equipment {
      display: flex;
      justify-content: space-between;
      color: $agri-white;
      margin-top: 25px;
      padding: 5px 0;
      .farm-name {
        .name {
          font-weight: 900;
          font-size: 16px;
          padding: 0 5px;
          font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
            Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
          img {
            margin-right: 2px;
            width: 20px;
            height: 20px;
            color: $agri-white;
          }
          @media only screen and (max-width: $breakpoint-mobile-m) {
            font-size: 12px;
            padding: 5px 5px;
          }
        }
        .farm-equipment {
          padding: 5px 0 0 5px;
          img {
            width: 30px;
            height: 30px;
          }
          @media only screen and (max-width: $breakpoint-mobile-large) {
            display: none;
            padding: 0 0 0 5px;
          }
        }
        .farm-type-mobile {
          display: none;
          @media only screen and (max-width: $breakpoint-mobile-large) {
            display: block;
            font-size: 14px;
            font-weight: 500;
            padding: 0 5px;
          }
        }
      }
      .price {
        border: 1px solid $agri-white;
        width: 160px;
        border-radius: 23px;
        display: flex;
        justify-content: center;
        .total {
          text-align: center;
          padding-top: 5px;
          @media only screen and (max-width: $breakpoint-mobile-m) {
            font-size: 14px;
            padding-top: 0;
          }
          span {
            font-weight: 900;
          }
          p {
            margin: auto auto;
            padding: 0;
          }
        }
        @media only screen and (max-width: $breakpoint-mobile-large) {
          display: none;
        }
      }
      @media only screen and (max-width: $breakpoint-mobile-m) {
        padding: 0;
        justify-content: start;
        margin-left: 10px;
      }
      @media only screen and (max-width: $breakpoint-laptop-l) {
        padding: 2px 0 5px 0;
        margin: 0;
      }
    }
  }
  .details-activity {
    .location,
    .number-rooms,
    .number-bathrooms,
    .line-separate,
    .farm-type,
    .exploitation-type,
    .agri-type {
      @media only screen and (max-width: $breakpoint-mobile-large) {
        display: none !important;
      }
    }
    color: $agri-white;
    padding: 10px;
    font-weight: 500;
    font-size: 14px;
    line-height: 19px;
    .title {
      color: $agri-white;
      font-size: 14px;
      font-weight: 900;
      text-align: center;
      padding: 12px;
    }
    .location {
      padding-top: 12px;
      color: $agri-white;
    }
    .number-pers {
      padding-top: 12px;
      color: $agri-white;
      @media only screen and (max-width: $breakpoint-mobile-m) {
        text-align: center;
      }
      img {
        @media only screen and (max-width: $breakpoint-mobile-large) {
          display: none;
        }
      }
    }
    .number-rooms {
      padding-top: 12px;
      color: $agri-white;
    }
    .number-bathrooms {
      color: $agri-white;
      padding-top: 12px;
    }
    .services-icons {
      display: flex;
      align-items: flex-start;
      font-size: 24px;
      padding-top: 12px;
      i {
        margin-right: 8px;
        @media only screen and (max-width: $breakpoint-mobile-m) {
          margin-right: 5px;
        }
      }
      @media only screen and (max-width: $breakpoint-mobile-m) {
        display: block;
        font-size: 18px;
        margin-left: 2px;
      }
    }
    .line-separate {
      border-bottom: 1px solid $agri-white;
      padding: 4px 0;
      margin: 0 auto;
      width: 108px;
    }
    .farm-type {
      color: $agri-white;
      margin-top: 8px;
      @media only screen and (max-width: $breakpoint-mobile-m) {
        margin: 0;
      }
      .exploitation-type {
        padding-top: 6px;
      }
    }
    .agri-type {
      color: $agri-white;
      .agriculture-type {
        padding-top: 12px;
      }
    }
    .img {
      position: relative;
      .activities {
        padding-top: 12px;
        display: flex;
        color: $agri-white !important;
        position: relative;
        .agri-others2::before {
          color: $agri-white !important;
        }
        i {
          width: 23px;
          height: 23px;
          margin-right: 6px;
          font-size: 20px !important;
          @media only screen and (max-width: $breakpoint-mobile-m) {
            margin: 0;
            font-size: 16px !important;
            margin-right: 3px;
          }
        }
        @media only screen and (max-width: $breakpoint-mobile-m) {
          padding: 0;
          margin-left: 2px;
        }
      }
      .animals {
        display: flex;
        margin-top: 15px;
        i {
          width: 23px;
          height: 23px;
          margin-right: 7px;
          font-size: 20px !important;
          @media only screen and (max-width: $breakpoint-mobile-m) {
            margin: 0;
            font-size: 16px !important;
            margin-right: 1px;
            padding-left: 3px;
          }
        }
        @media only screen and (max-width: $breakpoint-mobile-m) {
          margin-top: 8px;
        }
      }
      @media only screen and (max-width: $breakpoint-mobile-m) {
        padding-top: 8px;
        margin-bottom: 2px;
        margin-top: 0;
      }
    }
    img {
      margin-right: 10px;
      width: 20px;
      height: 20px;
      color: $agri-white;
    }
    .price-mobile {
      display: none;
      .total {
        text-align: center;
        font-size: 11px;
        p {
          padding: 0 3px 0 3px !important;
        }
      }
      @media only screen and (max-width: $breakpoint-mobile-large) {
        display: block;
        border: 1px solid $agri-white;
        width: 90px;
        border-radius: 23px;
        margin-top: 20px;
        display: flex;
        justify-content: center;
      }
    }
  }
  /* .hidden-activities {
    visibility: hidden;
  } */
  .show-activities {
    visibility: visible;
  }

  .booking-button {
    margin: auto;
    margin-bottom: 1vw;

    background-color: #EFCE4A;
    color: black;
    padding: 5px 20px;
    border-radius: 50px;
    box-shadow: 1px 1px 12px #555;

    @media only screen and (max-width: $breakpoint-tablet) {
      width: 100%;
    }
  }

  @media only screen and (max-width: $breakpoint-laptop-l) {
    width: 100%;
    max-width: 600px;
    height: 346px;
  }
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 100%;
    height: 346px;
    // margin-left: 12%;
    margin-left: auto;
  }
  @media only screen and (max-width: $breakpoint-mobile-large) {
    /* width: 425px; */
    width: 100%;
    height: 346px;
    left: 1%;
    margin: 0;
  }
  @media only screen and (max-width: $breakpoint-mobile-m) {
    width: 100%;
    max-width: 375px;
    height: 346px;
  }
  @media only screen and (max-width: $breakpoint-mobile-s) {
    width: 100%;
    max-width: 320px;
    height: 346px;
  }
}
.vueperslide__content-wrapper {
 @media only screen and (max-width: $breakpoint-laptop-generic) {
    width: 85%!important;
    margin: auto 0!important;
  }
  @media only screen and (max-width: $breakpoint-laptop-m) {
    width: 100%!important;
    margin: auto !important;
  }
}
</style>
