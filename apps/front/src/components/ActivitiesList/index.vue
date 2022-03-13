<template>

  <div
    id="offers"
    class="offers-list">
    <div class="offers-list-header">
      <p class="text-center seo-quote">
        {{ $t("activity.paragraphs.exit") }} <br>
        {{ $t("activity.paragraphs.booked") }}<br>
        {{ $t("activity.paragraphs.realised") }}<br>
        {{ $t("activity.paragraphs.land") }} <br>
        {{ $t("activity.paragraphs.notWait") }}
      </p>
      <div style="display: flex;">
        <h3
          v-if="$wait.is('loading more offers')"
          class="loading-notice">
          {{ $t("activity.paragraphs.loadingResult") }}
        </h3>
      </div>
      <h3 class="offer-count">
        {{ $tc('offer.offers_available', getActivities.length, {
          count: getActivities.length
        }) }}
      </h3>

      <br>

      <!-- <div
        class="filters">
        <div
          class="filter">
          <multiselect
            v-model="filters.housings"
            :options="housingList"
            :multiple="true"
            :close-on-select="false"
            :clear-on-select="false"
            :preserve-search="true"
            :deselect-label="''"
            :select-label="''"
            :selected-label="''"
            :open-direction="'bottom'"
            :limit="1"
            :limit-text="count => `${count} filtres`"
            label="name"
            track-by="value"
            placeholder="Type de logement"
            style="cursor: pointer;"
          />
        </div>

        <div
          class="filter">
          <multiselect
            v-model="filters.agricultures"
            :options="agricultureList"
            :multiple="true"
            :close-on-select="false"
            :clear-on-select="false"
            :preserve-search="true"
            :deselect-label="''"
            :select-label="''"
            :selected-label="''"
            :open-direction="'bottom'"
            :limit="1"
            :limit-text="count => `${count} filtres`"
            label="name"
            track-by="value"
            placeholder="Type d'agriculture"
            style="cursor: pointer;"
          />
        </div>

        <div
          class="filter">
          <multiselect
            v-model="filters.animals"
            :options="animalList"
            :multiple="true"
            :close-on-select="false"
            :clear-on-select="false"
            :preserve-search="true"
            :deselect-label="''"
            :select-label="''"
            :selected-label="''"
            :open-direction="'bottom'"
            :limit="1"
            :limit-text="count => `${count} filtres`"
            label="name"
            track-by="value"
            placeholder="Type d'animaux"
            style="cursor: pointer;"
          />
        </div>

        <div
          id="map-btn"
          class="control filter"
          style="cursor: pointer;"
          @click="seen = !seen">
          <p class="mb-0">Carte des offres</p>
        </div>

      </div> -->
    </div>

    <div
      class="offers-list-content">

      <div
        v-if="seen"
        id="hide"
        class="offers-map">

        <client-only>

          <l-map
            v-if="getActivities.length"
            :zoom="zoom"
            :center="center"
            style="height: 100%; width: 100%;z-index: 1;"
          >

            <l-tile-layer :url="url" />

            <l-marker
              v-for="(activity, k) in getActivities"
              :key="k"
              :activity="activity"
              :lat-lng="[activity.activity_address.lat, activity.activity_address.lng]" >

              <l-popup
                class="marker-card">

                <nuxt-link
                  :to="{
                    name: 'Activity',
                    params: {
                      id: activity.id,
                      slug: activity.slug
                    }
                  }"
                  target="_blank"
                  class="marker-text"
                >

                  {{ activity.name }}<br>
                  <p class="marker-location">
                    À {{ activity.activity_address.city }}
                  </p>

                </nuxt-link>

              </l-popup>

            </l-marker>

          </l-map>

        </client-only>

      </div>

      <activity-card
        v-for="(activity, k) in getActivities"
        :key="k"
        :activity="activity"
        :id="activity.id"
      />

    </div>

  </div>
</template>

<script>
  import Multiselect from 'vue-multiselect'
  import { mapGetters } from 'vuex'
  import ActivityCard from './_subs/ActivityCard'

  export default {
    name: 'ActivitiesList',
    layout: 'clean',
    components: {
      ActivityCard,
      Multiselect
    },
    data () {
      return {
        url: process.env.MAPBOX_URL,
        zoom: 5,
        center: [47.266963327000084, 2.307975641902913], // NOTE: Center of France
        seen: true,
        offerListFiltered: [],
        housingList: [
          { value: 'entire_house', name: 'Logement entier' },
          { value: 'private_room', name: 'Chambre privée' },
          { value: 'guest_room', name: 'Chambre d\'hôte' },
          { value: 'unusual_room', name: 'Logement insolite' },
          { value: 'tiny_house', name: 'Tiny house' },
          { value: 'immersive_house', name: 'Logement en immersion' }
        ],
        housings: [],
        filters: {
          housings: [],
          agricultures: [],
          animals: []
        },
        agricultureList: [
          { value: 'biological', name: 'Biologique' },
          { value: 'permaculture', name: 'Permaculture' },
          { value: 'agroecology', name: 'Agroécologie' },
          { value: 'agroecological', name: 'Conversion' },
          { value: 'conventional', name: 'Conventionnelle' },
          { value: 'ringing', name: 'Raisonné' },
          { value: 'durable', name: 'Durable' },
          { value: 'reliability', name: 'Précision' },
          { value: 'hydroponics', name: 'Hydroponie' }
        ],
        agricultures: [],
        animalList: [
          { value: 'pig', name: 'Cochon' },
          { value: 'cow', name: 'Vache' },
          { value: 'milk_cow', name: 'Vache à lait' },
          { value: 'chicken', name: 'Poule' },
          { value: 'sheep', name: 'Mouton' },
          { value: 'goose', name: 'Oie' },
          { value: 'turkey', name: 'Dinde' },
          { value: 'goat', name: 'Chèvre' },
          { value: 'duck', name: 'Canard' },
          { value: 'rabbit', name: 'Lapin' },
          { value: 'donkey', name: 'Âne' },
          { value: 'snail', name: 'Escargot' },
          { value: 'horse', name: 'Cheval' },
          { value: 'bee', name: 'Abeille' },
          { value: 'lama', name: 'Alpaga' }
        ],
        animals: []
      }
    },
    computed: {
      ...mapGetters([
        'getActivities',
        'getAllActivities',
        'getActivitiesMeta'
      ]),
      selectedHousings: function () {
        return this.getOffers.filter(offer => {
          return offer.residence_type.includes(this.housings)
      })
      },
      selectedAgricultures: function () {
        return this.getOffers.filter(function (offer) {
          return this.agricultures.includes(offer.offer_agriculture_type)
        }, this)
      },
      selectedAnimals: function () {
        return this.getOffers.filter(function (offer) {
          return this.animals.includes(offer.offer_animals)
        }, this)
      },

      offerFiltered () {
        var filterList = {
          housings: [],
          agricultures: [],
          animals: []
        }
        if (this.filters.housings.length) {
          this.filters.housings.forEach(housing => {
            filterList.housings.push(housing.value)
          })
        }

        if (this.filters.agricultures.length) {
          this.filters.agricultures.forEach(agri => {
            filterList.agricultures.push(agri.value)
          })
        }

        if (this.filters.animals.length) {
          this.filters.animals.forEach(animal => {
            filterList.animals.push(animal.value)
          })
        }

        if (filterList.housings.length || filterList.agricultures.length || filterList.animals.length) {
          return this.filter(filterList)
        } else {
          return this.getOffers
        }
      }
    },
    // watch: {
    //   filters: {
    //     handler (val) {
    //       var filterList = {
    //         housings: [],
    //         agricultures: [],
    //         animals: []
    //       }

    //       if (val.housings.length) {
    //         val.housings.forEach(housing => {
    //           filterList.housings.push(housing.value)
    //         })
    //       }

    //       if (val.agricultures.length) {
    //         val.agricultures.forEach(agri => {
    //           filterList.agricultures.push(agri.value)
    //         })
    //       }

    //       if (val.animals.length) {
    //         val.animals.forEach(animal => {
    //           filterList.animals.push(animal.value)
    //         })
    //       }

    //       this.filter(filterList)
    //     },
    //     deep: true
    //   }
    // },
    mounted () {
      this.offerListFiltered = this.getOffers
    },
    methods: {
      containsObject (obj, list) {
        var x
        for (x in list) {
          if (list.hasOwnProperty(x) && list[x] === obj) {
            return true
          }
        }
        return false
      },
      hasHousingType (housing, housingsList) {
        if (housingsList.includes(housing)) {
          return true
        } else {
          return false
        }
      },
      hasAgricultureType (agriculture, agriculturesList) {
        if (agriculture.length) {
          for (let i = 0; i < agriculturesList.length; i++) {
            const element = agriculturesList[i]
            if (agriculture.includes(element)) {
              return true
            } else {
              if (i === agriculturesList.length - 1) {
                return false
              } else {
                continue
              }
            }
          }
        } else {
          return false
        }
      },
      hasAnimal (animal, animalsList) {
        if (animal.length) {
          for (let i = 0; i < animalsList.length; i++) {
            const element = animalsList[i]
            if (animal.includes(element)) {
              return true
            } else {
              if (i === animalsList.length - 1) {
                return false
              } else {
                continue
              }
            }
          }
          // animalsList.forEach(anml => {
          //   if (animal.includes(anml)) {
          //     return true
          //   }
          // })
          return false
        } else {
          return false
        }
      },
      filter (filter) {
        this.offerListFiltered = []
        var animals = []
        var agricultureTypes = []

        this.getAllOffers.forEach(offer => {
          agricultureTypes = []
          animals = []

          if (offer.agriculture_types) {
            Object.entries(offer.agriculture_types).forEach(item => {
              if (item[1] === true) {
                agricultureTypes.push(item[0])
              }
            })
          }

          if (offer.animals) {
            Object.entries(offer.animals).forEach(item => {
              if (item[1] === true) {
                animals.push(item[0])
              }
            })
          }

          if (filter.housings.length) {
            if (filter.agricultures.length) {
              if (filter.animals.length) {
                if (this.hasHousingType(offer.residence_type, filter.housings) && this.hasAgricultureType(agricultureTypes, filter.agricultures) && this.hasAnimal(animals, filter.animals)) {
                  if (this.offerListFiltered.length) {
                    if (!this.containsObject(offer, this.offerListFiltered)) {
                      this.offerListFiltered.push(offer)
                    }
                  } else {
                    this.offerListFiltered.push(offer)
                  }
                }
              } else {
                if (this.hasHousingType(offer.residence_type, filter.housings) && this.hasAgricultureType(agricultureTypes, filter.agricultures)) {
                  if (this.offerListFiltered.length) {
                    if (!this.containsObject(offer, this.offerListFiltered)) {
                      this.offerListFiltered.push(offer)
                    }
                  } else {
                    this.offerListFiltered.push(offer)
                  }
                }
              }
            } else {
              if (filter.animals.length) {
                if (this.hasHousingType(offer.residence_type, filter.housings) && this.hasAnimal(animals, filter.animals)) {
                  if (this.offerListFiltered.length) {
                    if (!this.containsObject(offer, this.offerListFiltered)) {
                      this.offerListFiltered.push(offer)
                    }
                  } else {
                    this.offerListFiltered.push(offer)
                  }
                }
              } else {
                if (this.hasHousingType(offer.residence_type, filter.housings)) {
                  if (this.offerListFiltered.length) {
                    if (!this.containsObject(offer, this.offerListFiltered)) {
                      this.offerListFiltered.push(offer)
                    }
                  } else {
                    this.offerListFiltered.push(offer)
                  }
                }
              }
            }
          } else {
            if (filter.agricultures.length) {
              if (filter.animals.length) {
                if (this.hasAgricultureType(agricultureTypes, filter.agricultures) && this.hasAnimal(animals, filter.animals)) {
                  if (this.offerListFiltered.length) {
                    if (!this.containsObject(offer, this.offerListFiltered)) {
                      this.offerListFiltered.push(offer)
                    }
                  } else {
                    this.offerListFiltered.push(offer)
                  }
                }
              } else {
                if (this.hasAgricultureType(agricultureTypes, filter.agricultures)) {
                  if (this.offerListFiltered.length) {
                    if (!this.containsObject(offer, this.offerListFiltered)) {
                      this.offerListFiltered.push(offer)
                    }
                  } else {
                    this.offerListFiltered.push(offer)
                  }
                }
              }
            } else {
              if (filter.animals.length) {
                if (this.hasAnimal(animals, filter.animals)) {
                  if (this.offerListFiltered.length) {
                    if (!this.containsObject(offer, this.offerListFiltered)) {
                      this.offerListFiltered.push(offer)
                    }
                  } else {
                    this.offerListFiltered.push(offer)
                  }
                }
              }
              // else {
              //   this.offerListFiltered = this.getAllOffers
              // }
            }
          }
        })
        this.getActivities.total_count = this.offerListFiltered.length

        return this.offerListFiltered
        /** ******** Filter with "OR" Logic ***********
        // Housing type filter
         (housing == true || typeAgri2 == true || typeAgri3 == true ) &&  (typeLogmnt1 == true || typeLogmnt2 == true || typeLogmnt3 == true )
        if (filter.housings.length) {
          filter.housings.forEach(element => {
            this.getOffers.forEach(offer => {
              if (offer.residence_type.includes(element.value)) {
                this.offerListFiltered.push(offer)
              }
            })
          })
        }
        // Agriculture filter
        if (filter.agricultures.length) {
          filter.agricultures.forEach(element => {
            this.getOffers.forEach(offer => {
              agricultureTypes = []
              if (offer.agriculture_types) {
                Object.entries(offer.agriculture_types).forEach(item => {
                  if (item[1]) {
                    agricultureTypes.push(item[0])
                  }
                })
                agricultureTypes.forEach(agricultureType => {
                  if (agricultureType.includes(element.value)) {
                    if (this.offerListFiltered.length) {
                      if (!this.containsObject(offer, this.offerListFiltered)) {
                        this.offerListFiltered.push(offer)
                      }
                    } else {
                      this.offerListFiltered.push(offer)
                    }
                  }
                })
              }
            })
          })
        }
        // Animals filter
        if (filter.animals.length) {
          filter.animals.forEach(element => {
            this.getOffers.forEach(offer => {
              animals = []
              if (offer.animals) {
                Object.entries(offer.animals).forEach(item => {
                  if (item[1]) {
                    animals.push(item[0])
                  }
                })
                animals.forEach(animal => {
                  if (animal.includes(element.value)) {
                    if (this.offerListFiltered.length) {
                      if (!this.containsObject(offer, this.offerListFiltered)) {
                        this.offerListFiltered.push(offer)
                      }
                    } else {
                      this.offerListFiltered.push(offer)
                    }
                  }
                })
              }
            })
          })
        }
        if (!filter.housings.hasOwnProperty('value') && !filter.agricultures.hasOwnProperty('value') && !filter.animals.hasOwnProperty('value')) {
          this.offerListFiltered = this.getOffers
        }
        */
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .filters {
    display: grid;
    grid-template-columns: 150px 150px 150px 150px;
    grid-column-gap: 20px;
    @media only screen and (max-width: $breakpoint-tablet) {
      grid-template-columns: auto;
    }
  }

  .filter {
    @media only screen and (max-width: $breakpoint-tablet) {
      width: 170px;
      align-self: center;
      justify-self: center;
      margin-bottom: 20px;
    }
  }

  .filter::v-deep .multiselect{

    color: black !important;

    .multiselect__tags{
      background-color: #476458 !important;
      min-height: 50px;
      display: block;
      padding: 12px;
      border-radius: 50px;
      box-shadow: 0px 0px 10px black;
      border: none;
      font-size: 14px;
      height: 57px;
      overflow: overlay;
    }
    .multiselect__tags-wrap{
      margin-bottom: 11px;
    }
    .multiselect__tag{
      background-color: azure;
      color: #000;
      border-radius: 5px;
      font-size: 13.5px;
      font-weight: 700;
      margin-right: 3px;
      margin-left: 3px;
    }

    .multiselect__placeholder{
      color: $agri-white;
      margin-top: 5px;
      margin-left: 5px;
    }

    .multiselect__select{
      // height: 50px;
      top: 8.5px;
      right: -1px;
    }
    .multiselect__select:before {
      border-width: 7px 6px 0;
    }
    input {
      // width: 100% !important;
      border: 0;
      background-color: transparent;
      color: white;
    }
    input::placeholder{
      color: lightgrey;
    }
    .multiselect__single{
      color: #fff;
      font-weight: 700;
      background-color: transparent;
    }
    .multiselect__content-wrapper {
      background-color: #fff !important;
      padding: 10px;
      border: 1px solid lightgray;
      margin-top: 1px;
      width: 133%;
      height: auto;
      overflow: overlay;
      ul {
        list-style: none;
        padding-left: 5px;
        li {
          padding-bottom: 5px;
          font-size: 13.5px;
          cursor: pointer;
        }
      }
    }
  }

  .marker-location {
    font-size: 10px;
  }

  .marker-text {
    color: black;
    text-align: center;
    text-decoration: none;
    font-size: 12px;
    font-weight: 800;
    text-transform: uppercase;
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  }

  #map-btn {
    background-color: #EFCE4A;
    border-radius: 50px;
    color: black;
    padding: 15px 25px;
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
    box-shadow: 0px 0px 10px black;
    font-size: 12px;
    font-weight: 500;
    text-transform: uppercase;
    width: 165px;

    flex: initial;
  }

  .offers-map {
    grid-column: 1 / 3;
    @media only screen and (max-width: $breakpoint-mobile-l) {
      grid-column: auto;
      height: 352px;
    }
  }

  .btn-discover {
    background-color: $agri-green !important;
    border-radius: 50px;
    color: black;
    padding: 5px 25px;
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
    box-shadow: 0px 0px 10px black;

    font-size: 12px !important;

    @media only screen and (max-width: $breakpoint-tablet) {
      width: 100%;
    }
  }

  .offer-count {
    margin-bottom: 30px;
  }

  .seo-quote {
    margin-bottom: 80px !important;
    margin-top: 100px !important;
    color: #476458;
    font-size: 20px;
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  }

  .offers-list{
    &-content{
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      grid-gap: 50px;

      @media only screen and (max-width: $breakpoint-laptop-l) {
        grid-template-columns: repeat(4, 1fr);
      }

      @media only screen and (max-width: $breakpoint-laptop-m) {
        grid-template-columns: repeat(3, 1fr);
      }

      @media only screen and (max-width: $breakpoint-tablet) {
        grid-template-columns: repeat(2, 1fr);
      }

      @media only screen and (max-width: $breakpoint-mobile-l) {
        grid-template-columns: repeat(1, 1fr);
      }

      &__loading {
        text-align: center;
        padding: 64px 0 32px 0;
      }
    }

    &-header{
      margin: 32px 0;

      h2, h3{
        margin: 0;
        padding: 0;
      }

      h2{
        font-size: 28px;
        color: $primary-text;
        font-weight: 400;
      }

      h3{
        font-weight: 800;
        font-size: 25px;
        font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
        color: black;
      }
    }
  }
  .loading-notice {
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding-left: 15px !important;
    font-size: 18px !important;
  }
</style>
