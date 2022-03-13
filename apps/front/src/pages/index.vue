<template>
  <div class="home container">
    <home-hero v-model="data.address" />
    <div
      v-if="$parent.$parent.expl == true"
      class="wrapper">
      <home-base />
      <home-footer />
    </div>
    <div
      v-else
      :class="{ 'no-wrap': getOffersMeta.total_count == 0 }"
      class="wrap"
      style="max-width: 100vw; margin: 0; width: 100%"
    >
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
    </div>

    <offers-footer />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import sacredCow from '@/assets/img/resultsCards/sacred-cow.png'
import HomeHero from '@/components/Home/HomeHero'
import HomeBase from '@/components/Home/HomeBase'
import HomeMap from '@/components/Home/HomeMap'
import HomeFooter from '@/components/Home/HomeFooter'
import OffersList from '@/components/OffersList'
import EmptyResults from '@/components/OffersList/EmptyResults'
import OffersFooter from '@/components/OffersList/OffersFooter'
import dateFns from 'date-fns'
var VueScrollTo = require('vue-scrollto')

export default {
  components: {
    HomeHero,
    OffersList,
    EmptyResults,
    OffersFooter,
    HomeFooter,
    HomeBase,
    HomeMap
  },
  head () {
    return {
      script: [
        {
          src:
            'https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js'
        }
      ],
      title: this.$t('home.meta.title'),
      titleTemplate: 'AgriVillage - %s',
      meta: [
        {
          hid: 'description',
          name: 'description',
          content: this.$t('home.meta.description')
        }
      ]
    }
  },
  fetch ({ store }) {
    return store.dispatch('retrieveMetrics')
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
      housings: ['entire_house', 'private_room', 'guest_room', 'unusual_room', 'tiny_house', 'immersive_house'],
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
      ]
    }
  },
  computed: {
    ...mapGetters(['getOffersMeta', 'getSearchQuery', 'getSearchParams'])
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
    submittedcard (param) {
      /**
       * TODO: Why use french key names instead of the enum values right away?
       * Replace this.
       */
      const params = {}
      switch (param) {
        case 'entier':
          params.residence_type = 'entire_house'
          break
        case 'insolite':
          params.residence_type = 'unusual_room'
          break
        case 'hote':
          params.residence_type = 'guest_room'
          break
        case 'tinyHouse':
          params.residence_type = 'tiny_house'
          break
        case 'immersiveHouse':
          params.residence_type = 'immersive_house'
          break
        case 'elevage':
          params.farm_types = 'breeder'
          break
        case 'viticulture':
          params.farm_types = 'winegrower'
          break
        case 'apiculture':
          params.farm_types = 'beekeeper'
          break
        case 'biologique':
          params.agriculture_types = 'biological'
          break
        case 'chevre':
          params.animals = 'goat'
          break
        case 'mouton':
          params.animals = 'sheep'
          break
        case 'vache':
          params.animals = 'milk_cow'
          break
        case 'cheval':
          params.animals = 'horse'
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
