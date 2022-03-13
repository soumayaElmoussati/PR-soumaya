<template>
  <div class="home container">
    <home-hero v-model="data.address" />
    <div class="wrap">
      <empty-results v-if="getOffersMeta.count == 0" />
      <offers-list
        v-else
        ref="list"
      />
      <client-only>
        <div
          v-if="getOffersMeta.count != 0"
          class="pagin">
          <paginate
            v-model="getOffersMeta.current_page"
            :page-count="getOffersMeta.total_pages"
            :container-class="'pagination'"
            :prev-text="'<'"
            :next-text="'>'"
            :click-handler="clickCallback"
          />
        </div>
      </client-only>
    </div>
    <offers-footer />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import 'jquery'
import HomeHero from '@/components/Home/HomeHeroOffersBretagne'
import OffersList from '@/components/OffersBretagneList'
import EmptyResults from '@/components/OffersList/EmptyResults'
import OffersFooter from '@/components/OffersList/OffersFooter'
var VueScrollTo = require('vue-scrollto')

export default {
  components: {
    HomeHero,
    OffersList,
    EmptyResults,
    OffersFooter
  },
  head () {
    return {
      name: 'OffersBretagne',
      title: 'Séjournez en Bretagne, redécouvrez les campagnes bretonnes !',
      titleTemplate: '%s',
      meta: [
        {
          hid: 'description',
          name: 'description',
          content: this.$t('home.meta.bretagne')
        }
      ]
    }
  },
  fetch ({ store, app, route }) {
    return Promise.all([
      store.dispatch('retrieveMetrics'),
      app.$axios
        .get('/v2/offers', {
          params: {
            area: 'bretagne'
          }
        })
        .then(res => {
          if (typeof route.params.transition === 'undefined') {
            store.dispatch('setOffers', res.data.offers)
            store.dispatch('setOffersMeta', res.data.meta)
          }
        })
        .catch(err => {
          console.log('error', err)
        })
    ])
  },
  data () {
    return {
      mapsLoaded: false,
      data: {
        name: null,
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
      home: true,
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
  methods: {
    clickCallback: function (page) {
      if (this.$wait.is('loading more offers')) {
        return
      }

      this.$wait.start('loading more offers')
      VueScrollTo.scrollTo('#offers', 500, { offset: -100 })
      this.$refs.list.filter({
        page,
        area: 'bretagne'
      })
        .finally(() => {
          this.$wait.end('loading more offers')
        })
    },
    loadMore () {
      const meta = this.getOffersMeta
      if (this.$wait.is('loading more offers')) {
        return
      }

      if (meta.next_page === null) {
        return
      }

      this.$wait.start('loading more offers')
      this.$axios
        .get(`/v2/offers?page=${meta.next_page || 0}`)
        .then(res => {
          this.$store.dispatch('pushOffers', res.data.offers)
          this.$store.dispatch('setOffersMeta', res.data.meta)
        })
        .catch(err => {
          console.log('error', err)
        })
        .finally(() => {
          this.$wait.end('loading more offers')
        })
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.home {
  margin-top: 0px;
  .wrap {
    @media only screen and (max-width: $breakpoint-tablet) {
      padding: 0 16px;
      margin-top: 25em;
    }
  }
}
.pagin {
  text-align: center;
}
.pagination {
  display: inline-block;
  padding-left: 0;
  margin: 35px 0px;
  margin-bottom: 10px;
  border-radius: 5px;
  outline: none;
  user-select: none;

  li {
    display: inline;
    outline: none;
    a,
    span {
      position: relative;
      float: left;
      padding: 5px 10px;
      line-height: 30px;
      text-decoration: none;
      color: #262626;
      background-color: white;
      border: 1px solid #d6d6d6;
      margin-left: -1px;
      outline: none;
    }
    &:first-child {
      a,
      span {
        margin-left: 0px;
        border-top-left-radius: 5px;
        border-bottom-left-radius: 5px;
      }
    }
    &:last-child {
      a,
      span {
        border-top-right-radius: 5px;
        border-bottom-right-radius: 5px;
      }
    }
  }

  li a,
  li span {
    &:hover,
    &:focus {
      z-index: 3;
      // color: blue;
      // background-color: #d6d6d6;
      border-color: #d6d6d6;
    }
    &:hover {
      background-color: #d6d6d6;
    }
  }

  .active a,
  .active span {
    &,
    &:hover,
    &:focus {
      z-index: 2;
      color: white;
      background-color: #6d8d4cc7;
      border-color: #d6d6d6;
      cursor: default;
    }
  }

  .disabled {
    span,
    span:hover,
    span:focus,
    a,
    a:hover,
    a:focus {
      color: #262626;
      background-color: white;
      border-color: #d6d6d6;
      cursor: default;
    }
  }
}
</style>
