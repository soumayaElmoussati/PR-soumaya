<template>
  <div class="home container">
    <home-hero v-model="data.address" />
    <div class="wrap">
      <empty-results v-if="getActivities.count == 0" />
      <activities-list v-else />
    </div>

    <offers-footer />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import 'jquery'
import HomeHero from '@/components/Home/HomeHeroActivityAll'
import OffersFooter from '@/components/OffersList/OffersFooter'
import ActivitiesList from '@/components/ActivitiesList'
import EmptyResults from '@/components/OffersList/EmptyResults'

export default {
  components: {
    HomeHero,
    ActivitiesList,
    OffersFooter,
    EmptyResults
  },
  head () {
    return {
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
  fetch ({ store, app, route }) {
    return app.$axios
      .get('/activities')
      .then(res => {
        if (typeof route.params.transition === 'undefined') {
          store.dispatch('setActivities', res.data.activities)
          store.dispatch('setActivitiesMeta', res.data.meta)
        }
      })
      .catch(err => {
        console.log('error', err)
      })
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
    ...mapGetters([
      'getActivitiesMeta',
      'getActivities',
      'getSearchQuery',
      'getSearchParams'
    ])
  },
  mounted () {
    this.$parent.$parent.expl = false
    if (Object.keys(this.getSearchParams).length !== 0) {
      this.zip = this.getSearchParams.zip
      this.activity = this.getSearchParams.activity
      this.data.date1 = this.getSearchParams.date1
      this.data.date2 = this.getSearchParams.date2
      this.data.people_count = this.getSearchParams.people_count
    }
    this.loadMaps()
    if (!this.mapsLOaded) {
      window.addEventListener('maps-module:loaded', () => {
        this.loadMaps()
      })
    }
    // this.$axios.get(`/activities/forced_activity`)
    //   .then((res) => {
    //     this.activityOptions = res.data
    //   })
  },
  methods: {
    loadMaps () {
      if (this.$google) {
        this.mapsLoaded = true
        const autocomplete = new this.$google.maps.places.Autocomplete(
          document.querySelector('#address'),
          {
            types: ['geocode']
          }
        )

        autocomplete.setComponentRestrictions({
          country: 'FR'
        })
        autocomplete.setFields(['address_components', 'geometry'])
        autocomplete.addListener('place_changed', () => {
          const place = autocomplete.getPlace()
          const { address_components: addressComponents, geometry } = place

          const city = addressComponents.find(comp =>
            comp.types.find(
              v => v === 'locality' || v === 'administrative_area_level_1'
            )
          )
          const postalCode = addressComponents.find(comp =>
            comp.types.find(v => v === 'postal_code')
          )
          if (
            addressComponents[0].long_name !== addressComponents[1].long_name
          ) {
            this.data.address.street_name = `${addressComponents[0].long_name} ${addressComponents[1].long_name}`
          } else {
            this.data.address.street_name = `${addressComponents[0].long_name}`
          }
          this.data.address.city = city.long_name
          this.data.address.postalCode = postalCode.long_name
          this.data.address.location = {
            lat: geometry.location.lat(),
            lng: geometry.location.lng()
          }
        })
      }
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
