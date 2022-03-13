<template>
  <div>
    <div
      v-if="$parent.$parent.expl == true"
      class="wrapper">
      <div class="offer">
        <div
          v-if="hasFarmPictures"
          class="pictures-container">
          <offer-banner />
          <offer-pictures class="house-pictures-box" />
          <offer-farmpictures class="farm-pictures-box" />
        </div>
        <div
          v-else
          class="pictures-container-solo">
          <offer-banner />
          <offer-pictures />
        </div>

        <offer-popup />

        <div class="offer-container">
          <div class="main-content">

            <Crumbs />

            <div class="content-box">
              <h3 class="content-title">{{ $t("offer.titles.residence") }}</h3>

              <div class="divider" />

              <offer-content v-if="getOffer.description.residence">
                <offer-adjectifs v-if="getOffer.adjectif" />

                <read-more
                  :text="getOffer.description.residence"
                  :max-chars="300"
                  class="content-desc"
                  more-str="En savoir plus"
                  link="#"
                />
              </offer-content>
            </div>

            <offer-equipments v-if="getOffer.equipment" />

            <offer-hygiene v-if="getOffer.equipment" />

            <offer-confort v-if="getOffer.equipment" />

            <offer-kitchen v-if="getOffer.equipment" />

            <offer-calm v-if="getOffer.equipment" />

            <div class="content-box">
              <offer-services v-if="getOffer.service" />
            </div>
            <div class="content-box">
              <offer-benefit v-if="getOffer.benefit" />
            </div>

            <div class="content-box">
              <offer-animals v-if="getOffer.animal" />
            </div>

            <offer-tags v-if="getOffer.tag" />

            <div class="content-box">
              <h3 class="content-title">{{ $t("offer.titles.activities") }}</h3>

              <div class="divider" />

              <offer-content>
                <div class="activity-list-wrap">
                  <div
                    v-for="(activity, k) in activitiesList"
                    :key="k"
                    class="activity-item"
                  >
                    <div class="activity-item-block">
                      <i
                        :class="activity.className"
                        class="agri-others2 activity-item-icon"
                      />
                      <span class="activity-item-name">{{ activity.name }}</span>
                    </div>
                  </div>
                </div>

                <read-more
                  :text="getOffer.description.activities"
                  :max-chars="200"
                  class="content-desc"
                  more-str="En savoir plus"
                  link="#"
                />
              </offer-content>
            </div>

            <div class="content-main-box">
              <h3 class="content-title">{{ $t("offer.titles.farm") }}</h3>

              <div class="divider" />

              <offer-content
                v-if="getOffer.description.farm"
                class="content-desc">
                <read-more
                  :text="getOffer.description.farm"
                  :max-chars="300"
                  class="content-desc"
                  more-str="En savoir plus"
                  link="#"
                />
              </offer-content>
            </div>

            <div class="content-box">
              <OfferServicesAnnexes
                v-if="getOffer.manager"
              />
            </div>
          </div>

          <!-- BOOKING CALCULATOR -->
          <div class="aside-content">
            <offer-booking
              v-sticky="{ stickyTop: 120, zIndex: 5 }"
              :can-submit="!isFarmer"
            />

            <offer-modal v-if="!isClient" />

            <div
              v-if="isClient && !isManaged"
              class="chatroom">
              <nuxt-link
                :to="{
                  name: 'ChatRoom',
                  params: {
                    id: getOffer.id
                  }
                }"
              >
                {{ $t("offer.buttons.contactAgri") }}
              </nuxt-link>
            </div>

            <div
              v-if="isClient && isManaged"
              class="chatroom">
              <nuxt-link
                :to="{
                  name: 'ChatRoomTiny',
                  params: {
                    id: getOffer.id
                  }
                }"
              >
                {{ $t("offer.buttons.contactAgri") }}
              </nuxt-link>
            </div>
          </div>

        </div>

        <div class="farmer-box">

          <CalendarOffer
            :date="getCurrentOfferBookings"
            class="mobile-calendar"
          />

          <offer-farmer-details />

        </div>

        <div class="rules-box">

          <offer-rules v-if="getOffer.settlement" />

          <offer-farmer-location />

        </div>

        <OfferSimilar :offer="getOffer"/>

        <offer-reviews v-if="getOffer.reviews.length > 0" />

      </div>
    </div>
    <div
      v-else
      :class="{ 'no-wrap': getOffersMeta.total_count == 0 }"
      class="wrap"
      style="max-width: 100vw; margin: 0; width: 100%"
    >
      <home-hero v-model="data.address" />
      <empty-results v-if="getOffersMeta.total_count == 0" />
      <offers-list
        v-else
        ref="list"
      />
      <div
        v-if="
          getOffersMeta.total_count != 0 ||
            getOffersMeta.total_count != undefined
        "
        class="pagin"
      >
        <paginate
          v-model="getOffersMeta.current_page"
          :page-count="getOffersMeta.total_pages"
          :container-class="'pagination'"
          :prev-text="'<'"
          :next-text="'>'"
          :click-handler="clickCallback"
        />
        <div class="info-filters">
          <p
            class="text-center filters-quote"
            style="font-weight: 500; font-size: 14px; color: #476458"
          >
            {{ $t("search.footer")[0] }} <br >
            {{ $t("search.footer")[1] }} <br >
            {{ $t("search.footer")[2] }} <br >
            {{ $t("search.footer")[3] }}
          </p>
          <img
            :src="sacredCow"
            alt="" >
        </div>
      </div>
      <offers-footer />
    </div>
  </div>
</template>

<script>
import CalendarOffer from '@/components/CalendarOffer'
import { mapGetters } from 'vuex'

import OfferPictures from '@/components/Offer/OfferPictures'
import OfferFarmpictures from '@/components/Offer/OfferFarmPictures'
import OfferBanner from '@/components/Offer/OfferBanner'
import OfferPopup from '@/components/Offer/OfferPopup'
import OfferBooking from '@/components/Offer/OfferBooking'
import OfferServices from '@/components/Offer/OfferServices'
import OfferAnimals from '@/components/Offer/OfferAnimals'
import OfferEquipments from '@/components/Offer/OfferEquipments'
import OfferAdjectifs from '@/components/Offer/OfferAdjectifs'
import OfferTags from '@/components/Offer/OfferTags'
import OfferHygiene from '@/components/Offer/OfferHygiene'
import OfferConfort from '@/components/Offer/OfferConfort'
import OfferKitchen from '@/components/Offer/OfferKitchen'
import OfferCalm from '@/components/Offer/OfferCalm'
import OfferActivities from '@/components/Offer/OfferActivities'
import OfferContent from '@/components/Offer/OfferContent'
import OfferFarmer from '@/components/Offer/OfferFarmer'
import OfferModal from '@/components/Offer/OfferModal'
import OfferServicesAnnexes from '@/components/Offer/OfferServicesAnnexes'
import OfferSimilar from '@/components/Offer/OfferSimilar'
import OfferReviews from '@/components/Offer/OfferReviews'
import OfferBenefit from '@/components/Offer/OfferBenefits'
import OfferFarmerLocation from '@/components/Offer/OfferFarmer/_subs/OfferFarmerLocation'
import OfferFarmerDetails from '@/components/Offer/OfferFarmer/_subs/OfferFarmerDetails'
import OfferRules from '@/components/Offer/OfferRules'
import Crumbs from '@/components/Offer/Crumbs'

import OffersList from '@/components/OffersList'
import EmptyResults from '@/components/OffersList/EmptyResults'
import OffersFooter from '@/components/OffersList/OffersFooter'
import sacredCow from '@/assets/img/resultsCards/sacred-cow.png'
import HomeHero from '@/components/Home/HomeHero'
import dateFns from 'date-fns'
var VueScrollTo = require('vue-scrollto')

export default {
  name: 'Offer',
  components: {
    OfferPictures,
    OfferFarmpictures,
    OfferBanner,
    OfferPopup,
    OfferBooking,
    OfferAnimals,
    OfferEquipments,
    OfferAdjectifs,
    OfferTags,
    OfferHygiene,
    OfferConfort,
    OfferKitchen,
    OfferCalm,
    OfferServices,
    OfferActivities,
    OfferContent,
    OfferFarmer,
    OfferModal,
    CalendarOffer,
    OfferServicesAnnexes,
    OfferSimilar,
    OfferReviews,
    OfferBenefit,
    OfferFarmerLocation,
    OfferFarmerDetails,
    OfferRules,
    Crumbs,
    OffersList,
    EmptyResults,
    OffersFooter,
    HomeHero
  },
  head () {
    return {
      script: [
        {
          src:
            'https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js'
        }
      ],
      title:
        this.$t('global.labels.housingType.' + this.getOffer.residence_type) + ' ' + this.getOffer.name,
      meta: [
        {
          hid: 'description',
          name: 'description',
          content: this.getOfferMetaDescription
        },
        {
          'property': 'og:title',
          'content': this.getOffer.name,
          'hid': 'og:title'
        },
        {
          'property': 'og:description',
          'content': this.getOfferMetaDescription,
          'hid': 'og:description'
        },
        {
          'property': 'og:image',
          'content': this.getOffer.pictures[0].url,
          'hid': 'og:image'
        }
      ]
    }
  },
  fetch ({ store, app, route, error }) {
    return Promise.all([
      app.$axios.get(`/offers/${route.params.id}`),
      app.$axios.get(`/offers/${route.params.id}/bookings`),
      store.dispatch('retrieveMetrics')
    ])
      .then(values => {
        if (values[0].status === 200) {
          store.dispatch('setOffer', values[0].data)
        }

        if (values[1].status === 200) {
          store.commit('SET_CURRENT_OFFER_BOOKINGS', values[1].data)
        }
      })
      .catch(() => {
        error({
          statusCode: 404,
          message: "Cette offre n'existe pas ou plus"
        })
      })
  },
  data () {
    return {
      sacredCow,
      data: {
        name: null,
        distance: 50,
        address: {
          street_name: null,
          city: null,
          postalCode: null
        },
        people_count: null,
        date1: null,
        date2: null,
        fiscalNumber: null,
        housingType: null,
        housingClassment: null,
        description: null,
        roomsCount: 1,
        complement: {
          bathrooms: 1,
          toilets: 1,
          sleeping: 0,
          maxOccupants: 1
        }
      },
      // housings: ['entire_house', 'private_room', 'guest_room', 'unusual_room', 'tiny_house', 'immersive_house'],
      housingClassments: ['main', 'secondary', 'hotel'],
      position: {
        lat: 0,
        lng: 0
      },
      zoom: 5,
      selection: [],
      explore: true,
      firstMeta: null,
      search: false,
      SearchQuery: null,
      zip: [],
      activity: [],
      activityOptions: [
        {
          name: "Découverte de l'exploitation",
          code: 'discovery'
        },
        {
          name: 'Rencontre avec les animaux',
          code: 'meeting_animals'
        },
        {
          name: 'Participer à la traite',
          code: 'milking_animals'
        },
        {
          name: 'Dégustation de produits',
          code: 'tasting'
        },
        {
          name: 'Assister à des naissances',
          code: 'birth_animal'
        },
        {
          name: 'Balade (en calèche ou tracteur) ',
          code: 'stroll'
        },
        {
          name: 'Participer à la récolte',
          code: 'harvest'
        },
        {
          name: 'Fabrications de produits',
          code: 'craft'
        }
      ],
      zipOptions: [
        {
          name: 'Chargement en cours ...',
          code: 'js'
        }
      ],
      activities: [
        {
          key: 'discovery',
          name: this.$t('offer.activities.discovery'),
          className: 'icon-gardening-boots'
        },
        {
          key: 'meeting_animals',
          name: this.$t('offer.activities.meeting_animals'),
          className: 'icon-binoculars'
        },
        {
          key: 'milking_animals',
          name: this.$t('offer.activities.milking_animals'),
          className: 'icon-cow-milking'
        },
        {
          key: 'tasting',
          name: this.$t('offer.activities.tasting'),
          className: 'icon-taste'
        },
        {
          key: 'birth_animal',
          name: this.$t('offer.activities.birth_animal'),
          className: 'icon-bird-in-broken-egg'
        },
        {
          key: 'stroll',
          name: this.$t('offer.activities.stroll'),
          className: 'icon-tractor'
        },
        {
          key: 'harvest',
          name: this.$t('offer.activities.harvest'),
          className: 'icon-harvest'
        },
        {
          key: 'craft',
          name: this.$t('offer.activities.craft'),
          className: 'icon-stir'
        }
      ]
    }
  },
  jsonld () {
    return {
      '@context': 'https://schema.org',
      '@type': 'Product',
      url: 'https://www.agrivillage.fr/',
      name: this.getOffer.name,
      description: this.getOfferMetaDescription,
      image: [
        this.getOffer.pictures[0].url
      ],
      offers: {
        '@type': 'Offer',
        url: 'https://www.agrivillage.fr' + this.$route.fullPath,
        price: (this.getOffer.price_per_person / 100),
        priceCurrency: 'EUR',
        availability: 'https://schema.org/InStock'
      }
    }
  },
  computed: {
    ...mapGetters([
      'getOffer',
      'isFarmer',
      'isClient',
      'getCurrentOfferBookings',
      'getOffersMeta',
      'getSearchQuery',
      'getSearchParams'
    ]),
    hasFarmPictures () {
      if (this.getOffer.picturesoffer.length > 0) {
        return true
      } else {
        return false
      }
    },
    getBasePrice () {
      // NOTE: Prix de base de la nuit
      return this.getOffer.price_per_person
    },
    getOfferMetaDescription () {
      const { description } = this.getOffer
      if (typeof description !== 'undefined') {
        const possibleDesc = description.residence

        if (possibleDesc.length > 0) {
          return possibleDesc.substring(0, 200)
        }
      }

      return this.$t('home.meta.description')
    },
    activitiesList () {
      return this.activities.filter(v => {
        const serviceObj = this.getOffer.description
        return serviceObj[v.key]
      })
    },
    isManaged () {
      if (this.getOffer.manager === true) {
        return true
      } else {
        return false
      }
    }
  },
   mounted () {
    this.firstMeta = this.getOffersMeta.total_count

    if (Object.keys(this.getSearchParams).length !== 0) {
      this.activity = this.getSearchParams.activity
      this.data.date1 = this.getSearchParams.date1
      this.data.date2 = this.getSearchParams.date2
      this.data.people_count = this.getSearchParams.people_count
      this.data.housingType = this.getSearchParams.housingType
    }

    /**
     * TODO: Do not use plain path for the request URL.
     * Use the queryParams from axios.
     */
    this.SearchQuery = `/v2/offers`

    if (this.$route.query.activity) {
      this.SearchQuery =
        this.SearchQuery + '&activities=' + this.$route.query.activity
      this.activity = this.$route.query.activity.split(',')
    }
    if (this.$route.query.people_count) {
      this.SearchQuery =
        this.SearchQuery + '&people_count=' + this.$route.query.people_count
      this.data.people_count = this.$route.query.people_count
    }
    /**
     * TODO: Use the same key for arrival & departure date.
     */
    if (this.$route.query.date_arrive) {
      this.SearchQuery =
        this.SearchQuery + '&arrival_date=' + this.$route.query.date_arrive
      this.data.date1 = this.$route.query.date_arrive
    }
    if (this.$route.query.date_depart) {
      this.SearchQuery =
        this.SearchQuery + '&departure_date=' + this.$route.query.date_depart
      this.data.date2 = this.$route.query.date_depart
    }

    // this.$axios.get(`/offers/forced_activity`).then(res => {
    //   console.log('res.data', res.data)
    //   this.activityOptions = res.data
    // })
  },
  methods: {
    loadMore () {
      const meta = this.getOffersMeta
      if (this.$wait.is('loading more offers')) {
        return
      }

      if (meta.next_page === null) {
        return
      }

      this.$wait.start('loading more offers')
      this.$store
        .dispatch('retrieveOffers', {
          page: meta.next_page || 0
        })
        .catch(err => {
          console.log('error', err)
        })
        .finally(() => {
          this.$wait.end('loading more offers')
        })
    },
    clickCallback: function (page) {
      if (this.$wait.is('loading more offers')) {
        return
      }

      this.$wait.start('loading more offers')
      VueScrollTo.scrollTo('#offers', 500, { offset: -100 })
      this.$refs.list.filter({
        page
      })
        .finally(() => {
          this.$wait.end('loading more offers')
        })
    },
    requestSearch (params) {
      if (this.$wait.is('searching')) return

      /**
       * The form data is entirely valid
       */
      this.$wait.start('searching')
      this.$store
        .dispatch('retrieveOffers', params)
        .then(res => {
          this.$store.dispatch('setAllOffers', res.data.all_offers)
        })
        .catch(err => {
          console.log('error', err)
        })
        .finally(() => {
          this.$parent.$parent.expl = false
          this.search = true
          window.scrollTo(0, 0)
          this.$wait.end('searching')
        })
    },
    // getCity () {
    //   console.log(document.getElementById('city'))
    // },
    submittedcard (param) {
      /**
       * TODO: Why use french key names instead of the enum values right away?
       * Replace this.
       */
      var region = document.getElementById('region').innerText
      console.log(region)
      var department = document.getElementById('department').innerText
      console.log(department)
      var city = document.getElementById('city').innerText

      const params = {}
      switch (param) {
        case 'region':
          params.location = region
          break
        case 'department':
          params.location = department
          break
        case 'city':
          params.location = city
          break

        default:
      }

      this.requestSearch(params)
    },
    submitted () {
      var urlParam = {
        activity: []
      }

      if ((this.data.date1 !== null) & (this.data.date2 !== null)) {
        this.data.date1 = dateFns.format(this.data.date1, 'YYYY-MM-DD')
        this.data.date2 = dateFns.format(this.data.date2, 'YYYY-MM-DD')
      }

      this.$root.$children[1].sDate = this.data.date1
      this.$root.$children[1].fDate = this.data.date2

      this.search = true
      this.$parent.$parent.expl = false

      this.$validator.validateAll().then(valid => {
        if (valid) {
          if (this.$wait.is('searching')) return

          /**
           * The form data is entirely valid
           */
          this.$wait.start('searching')
          this.SearchQuery = `/v2/offers?`

          // Activités
          var ActivityQuery = ''
          if (this.activity.length !== 0) {
            urlParam.activity = this.activity
            for (var j = 0; j < this.activity.length; j++) {
              ActivityQuery = ActivityQuery + this.activity[j].code + ','
            }
            ActivityQuery = `&activities=${ActivityQuery.slice(0, -1)}`
          }

          // Nombre de personne
          if (
            this.data.people_count !== null &&
            this.data.people_count !== ''
          ) {
            this.SearchQuery =
              this.SearchQuery + `&people_count=${this.data.people_count || 1}`
            urlParam.people_count = `${this.data.people_count}`
          }

          // Date arrive
          if (this.data.date1 !== null) {
            this.data.date1 = dateFns.format(this.data.date1, 'YYYY-MM-DD')
            this.SearchQuery =
              this.SearchQuery + `&arrival_date=${this.data.date1}`
            urlParam.date_arrive = `${this.data.date1}`
          }
          // Date depart
          if (this.data.date2 !== null) {
            this.data.date2 = dateFns.format(this.data.date2, 'YYYY-MM-DD')
            this.SearchQuery =
              this.SearchQuery + `&departure_date=${this.data.date2}`
            urlParam.date_depart = `${this.data.date2}`
          }

          var locationQuery = ''
          if (this.data.address.street_name !== null) {
            locationQuery = `&location=${this.data.address.street_name}`
            locationQuery += `&distance=${this.data.distance}`
          }

          this.$root.$children[1].sDate = this.data.date1
          this.$root.$children[1].fDate = this.data.date2

          this.SearchQuery = this.SearchQuery + ActivityQuery + locationQuery
          if (
            this.SearchQuery === `/v2/offers?` ||
            this.SearchQuery === `/v2/offers?&location=`
          ) {
            this.SearchQuery = '/v2/offers'
          }

          /**
           * TODO: Don't understand the purpose of this.
           * Should be removed as it does not bring anything.
           */
          // ONLY TO DISPLAY PARAMS IN URL

          var urlQuery = '?'
          var urlactivity = ''

          /**
           * TODO: Weirdly made, a simple array map & join is good enough.
           */
          if (urlParam.activity.length) {
            for (var g = 0; g < this.activity.length; g++) {
              urlactivity = urlactivity + this.activity[g].code + ','
            }
            urlactivity = '&activity=' + urlactivity.slice(0, -1)
          }
          if (urlParam.people_count) {
            urlQuery = urlQuery + '&people_count=' + urlParam.people_count
          }

          if (urlParam.date_arrive) {
            urlQuery = urlQuery + '&date_arrive=' + urlParam.date_arrive
          }

          if (urlParam.date_depart) {
            urlQuery = urlQuery + '&date_depart=' + urlParam.date_depart
          }

          if (this.data.address.street_name !== null) {
            locationQuery = `&location=${this.data.address.street_name}`
            locationQuery += `&distance=${this.data.distance}`
          }

          urlQuery = urlQuery + urlactivity + locationQuery

          this.$axios
            .get(this.SearchQuery)
            .then(res => {
              this.$store.dispatch('setOffers', res.data.offers)
              this.$store.dispatch('setOffersMeta', res.data.meta)
              this.$router.push('/' + urlQuery)
            })
            .catch(err => {
              console.log('error', err)
            })
            .finally(() => {
              this.$store.commit('SET_SEARCH_QUERY', this.SearchQuery)
              var data = {
                activity: this.activity,
                date1: this.data.date1,
                date2: this.data.date2,
                people_count: this.data.people_count
              }
              this.$store.commit('SET_SEARCH_PARAMS', data)
              this.$wait.end('searching')
            })
        }
      })
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
@import "@/assets/scss/_mixins.scss";

.chatroom {
  text-align: center;
}

.farmer-box {
  display: grid;
  grid-template-columns: 45% 45%;
  grid-column-gap: 10%;
  padding-right: 50px;
  padding-left: 75px;
  margin-left: 5vw;
  margin-right: 5vw;
  @media only screen and (max-width: $breakpoint-tablet) {
    grid-template-columns: 100%;
    padding-right: 0px;
    padding-left: 0px;
  }
}

.rules-box {
  display: grid;
  grid-template-columns: 45% 45%;
  grid-column-gap: 10%;
  padding-right: 50px;
  padding-left: 75px;
  margin-left: 5vw;
  margin-right: 5vw;
  @media only screen and (max-width: $breakpoint-tablet) {
    grid-template-columns: 100%;
    padding-right: 0px;
    padding-left: 0px;
  }
}

.contact-btn {
  margin: auto;
  background-color: $agri-green;
  color: white;
  padding: 0px 10px;
  border-radius: 50px;
  box-shadow: 1px 1px 12px #555;
  margin-top: 1vw;
  width: 15vw;
  font-size: 12px;

  @media only screen and (max-width: $breakpoint-tablet) {
    width: 100%;
    padding: 0px 0px;
  }
}

.pictures-container {
  display: grid;
  grid-template-columns: 50% 50%;
  grid-column-gap: 5px;
  @media only screen and (max-width: $breakpoint-tablet) {
    grid-row-gap: 5px;
    grid-template-columns: 100%;
  }
}

.mobile-calendar {
  @media only screen and (max-width: $breakpoint-tablet) {
    margin-bottom: 25px;
  }
}

.pictures-container-solo {
  display: grid;
  grid-template-columns: 100%;
}

.offer {
  &-container {
    margin-bottom: 50px;
    display: grid;
    grid-template-columns: 55% 30%;
    grid-gap: 15%;

    background-color: white;
    padding-right: 50px;
    padding-left: 50px;
    margin-left: 5vw;
    margin-right: 5vw;
    padding-bottom: 35px;
    margin-bottom: 0px;

    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;

    @media only screen and (max-width: $breakpoint-laptop-m) {
      margin-left: 0px;
      margin-right: 0px;
    }

    @media only screen and (max-width: $breakpoint-tablet) {
      grid-template-columns: 1fr;
      grid-gap: 0%;
      padding: 0 16px;
    }
  }
  .divider {
    height: 1px;
    background-color: rgba(black, 0.3);
    margin-top: 16px;
  }

  .side-content {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    grid-gap: 16px;

    @media only screen and (max-width: $breakpoint-laptop-m) {
      grid-template-columns: 1fr;
    }
  }

  &-farmer {
    margin-top: 32px;
    @media only screen and (max-width: $breakpoint-mobile-l) {
      padding: 0 16px;
    }
  }
}

.main-content {
  padding-left: 25px;
  @media only screen and (max-width: $breakpoint-mobile-l) {
    padding-left: 0px;
  }
}

.content-main-box {
  margin-top: 20px;
  margin-bottom: 30px;
}

.content-box {
  margin-bottom: 30px;
}

.content-title {
  text-transform: uppercase;
  color: #476458;
  font-size: 21px;
  font-weight: 900;
}

.content-desc {
  font-size: 14px;
  color: #476458;
  white-space: pre-line;
}

// ACTIVITIES

.activity-list-wrap {
  display: grid;
  grid-template-columns: auto auto;
  margin-bottom: 30px;
  @media only screen and (max-width: $breakpoint-mobile-l) {
    grid-template-columns: auto;
  }
}

.activity-item-block {
  margin: 5px;
  span {
    font-size: 16px;
  }
}
.activity-item-icon {
  font-size: 30px;
  padding: 10px;
  color: #79bc53 !important;
}

.activity-item-name {
  font-size: 12px;
  font-weight: bold;
  color: #476458;
}

.info-filters {
  display: flex !important;
  justify-content: space-between !important;
  padding: 40px 80px;
  p {
    text-align: start;
    margin: auto 0;
  }
  img {
    margin-right: 15px;
    @media only screen and (max-width: $breakpoint-tablet) {
      width: 46px;
      height: 46px;
      position: absolute;
      margin-left: 300px;
      margin-top: 140px;
    }
  }
  @media only screen and (max-width: $breakpoint-tablet) {
    flex-direction: column;
    padding: 12px 20px 55px 20px;
  }
}
.home {
  margin-top: 0px;
  @media only screen and (max-width: $breakpoint-mobile-s) {
    width: 110% !important;
  }
  .wrap {
    @media only screen and (max-width: $breakpoint-tablet) {
      margin: 0 auto !important;
      max-width: 100% !important;
    }
  }
}
.no-wrap {
  margin: 0px !important;
  padding: 0px !important;
  width: 100% !important;
}
.pagin {
  text-align: center;
}
.wrapper {
  background-color: white;
  // max-width: 1280px;
  // width: 75%;
  margin: 0 auto;
}
</style>
