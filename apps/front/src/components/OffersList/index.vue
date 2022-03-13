<template>
  <div
    id="offers"
    class="offers-list">
    <div
      class="offers-list-header">
      <div class="title-headers">
        <p class="text-center seo-quote">
          {{ $t("search.header.description")[0] }}<br >
          {{ $t("search.header.description")[1] }} <br >
          {{ $t("search.header.description")[2] }} <br >
          {{ $t("search.header.description")[3] }}
        </p>
        <div class="charli">
          <img
            :src="charli"
            alt="" >
          <div class="symbols">
            <div class="border" />
            <i class="fas fa-quote-left" />
          </div>
          <p>
            {{ $t("offer.paragraphs.charly")[0] }}<br>
            {{ $t("offer.paragraphs.charly")[1] }}
          </p>
        </div>
      </div>
      <div style="display: flex;">
        <h3
          v-if="$wait.is('loading more offers')"
          class="loading-notice">
          {{ $t("search.header.loading") }}
        </h3>
      </div>

      <br >
      <div
        v-if="showModal"
        class="modal-mask">
        <div
          class="modal-wrapper"
          @click="toggleModal" />
        <div class="modal-container">
          <div class="title-button">
            <h3>{{ $t("offer.titles.search") }}</h3>
            <button
              class="cross"
              @click="toggleModal">
              <i class="fas fa-times" />
            </button>
          </div>
          <p>
            {{
              $tc("search.header.offers_available", getOffersMeta.total_count, {
                count: getOffersMeta.total_count
              })
            }}
          </p>
          <div class="border" />
          <div class="filters">
            <price-filters :price.sync="filters.price" />
            <div class="filter">
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
                :placeholder="$t('home.placeholder.lodgeType')"
                label="name"
                track-by="value"
                style="cursor: pointer;"
              />
            </div>
            <div class="filterMobile">
              <multiselect
                v-model="filters.housings"
                :options="housingList"
                :multiple="true"
                :taggable="true"
                :searchable="false"
                :close-on-select="false"
                :clear-on-select="false"
                :preserve-search="true"
                :deselect-label="''"
                :select-label="''"
                :selected-label="''"
                :open-direction="'bottom'"
                :limit="1"
                :limit-text="count => `${count} filtres`"
                :placeholder="$t('home.placeholder.lodgeType')"
                label="name"
                track-by="value"
                style="cursor: pointer;"
              />
            </div>

            <div class="filter">
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
                :placeholder="$t('home.placeholder.agriType')"
                label="name"
                track-by="value"
                style="cursor: pointer;"
              />
            </div>
            <div class="filterMobile">
              <multiselect
                v-model="filters.agricultures"
                :options="agricultureList"
                :multiple="true"
                :taggable="true"
                :searchable="false"
                :close-on-select="false"
                :clear-on-select="false"
                :preserve-search="true"
                :deselect-label="''"
                :select-label="''"
                :selected-label="''"
                :open-direction="'bottom'"
                :limit="1"
                :limit-text="count => `${count} filtres`"
                :placeholder="$t('home.placeholder.agriType')"
                label="name"
                track-by="value"
                style="cursor: pointer;"
              />
            </div>

            <div class="filter">
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
                :placeholder="$t('home.placeholder.animalsType')"
                label="name"
                track-by="value"
                style="cursor: pointer;"
              />
            </div>

            <div class="filter">
              <multiselect
                v-model="filters.farmTypes"
                :options="farmTypesList"
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
                :placeholder="$t('home.placeholder.exploitationType')"
                label="name"
                track-by="value"
                style="cursor: pointer;"
              />
            </div>

            <equipments-filter v-model="filters.equipments" />

            <div class="filterMobile">
              <multiselect
                v-model="filters.animals"
                :options="animalList"
                :multiple="true"
                :taggable="true"
                :searchable="false"
                :close-on-select="false"
                :clear-on-select="false"
                :preserve-search="true"
                :deselect-label="''"
                :select-label="''"
                :selected-label="''"
                :open-direction="'bottom'"
                :limit="1"
                :limit-text="count => `${count} filtres`"
                :placeholder="$t('home.placeholder.animalsType')"
                label="name"
                track-by="value"
                style="cursor: pointer;"
              />
            </div>
            <div class="filterMobile">
              <multiselect
                v-model="filters.farmTypes"
                :options="farmTypesList"
                :multiple="true"
                :taggable="true"
                :searchable="false"
                :close-on-select="false"
                :clear-on-select="false"
                :preserve-search="true"
                :deselect-label="''"
                :select-label="''"
                :selected-label="''"
                :open-direction="'bottom'"
                :limit="1"
                :limit-text="count => `${count} filtres`"
                :placeholder="$t('home.placeholder.exploitationType')"
                label="name"
                track-by="value"
                style="cursor: pointer;"
              />
            </div>

            <!-- <div
              id="map-btn"
              class="control filter"
              style="cursor: pointer;"
              @click="seen = !seen"
            >
              <p class="mb-0">{{ $t("search.header.map") }}</p>
            </div> -->
          </div>
          <div class="filters__footer">
            <div class="charli-modal">
              <div class="charli-img">
                <img
                  :src="charli"
                  alt="" >
              </div>
              <div class="symbol">
                <i class="fas fa-quote-left" />
              </div>
              <div class="line" />
              <div class="charli-txt">
                {{ $t("offer.paragraphs.search") }}
              </div>
            </div>

            <div class="buttons">
              <div
                class="button-refresh"
                style="cursor: pointer;"
                @click="resetFilter"
              >
                <img
                  :src="refresh"
                  alt="refresh" >
              </div>
              <div
                id="loupe"
                class="button-refresh"
                style="cursor: pointer;"
                @click="filter"
              >
                <img
                  :src="loupe"
                  alt="loupe" >
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- END MODAL -->
    </div>

    <div class="allResults">
      <div class="result-button">
        <p
          v-if="$route.query.location"
          class="search-params">
          Séjour à {{ $route.query.location }}
        </p>
        <p
          v-if="$route.query.date_arrive && $route.query.date_depart"
          class="search-params">
          Du {{ moment($route.query.date_arrive).locale('fr').format('L') }} au {{ moment($route.query.date_depart).locale('fr').format('L') }}
        </p>
        <p
          v-if="$route.query.people_count"
          class="search-params">
          Pour {{ $route.query.people_count }} personnes
        </p>

        <h3 class="offer-count">
          {{
            $tc("search.header.offers_available", getOffersMeta.total_count, {
              count: getOffersMeta.total_count
            })
          }}
        </h3>

        <div>
          <!-- <button
            class="btn btn-agri view-filter"
            @click= "orderBy(getOffers)"
          >
            filtrer par vue
          </button> -->
        </div>

        <div>
          <a
            href="#"
            class="btn-filter-desktop"
            @click="toggleModal"
          ><img
            :src="filterSearch"></a
            >
        </div>
        <div>
          <a
            href="#"
            class="btn-filter"
            @click="toggleModal"
          >{{ $t("offer.buttons.searchFilter") }}</a
          >
        </div>

      </div>
      <div class="offers-list-content">
        <div
          v-if="seen"
          id="hide"
          class="offers-map">
          <client-only>
            <l-map
              v-if="getOffers.length"
              :zoom="zoom"
              :center="center"
              style="height: 100%; width: 100%;z-index: 1;"
            >
              <l-tile-layer :url="url" />

              <l-marker
                v-for="offer in getOffers"
                :key="offer.id"
                :offer="offer"
                :lat-lng="[offer.address.lat, offer.address.lng]"
              >
                <l-popup class="marker-card">
                  <nuxt-link
                    :to="{
                      name: 'FarmerProfile',
                      params: {
                        id: offer.farmer.id,
                        slug: `hote-${offer.farmer.user.first_name}`
                      }
                    }"
                    target="_blank"
                    class="marker-text"
                  >
                    <div v-if="offer.pictures.length">
                      <img
                        v-for="picture in offer.pictures.slice(0, 1)"
                        :key="picture.public_id"
                        :src="address + picture.public_id"
                        :alt="offer.name"
                        style="width: 100%"
                      >
                    </div>
                    {{ offer.name }}<br >
                    <p class="marker-location">À {{ offer.address.city }}</p>
                  </nuxt-link>
                </l-popup>
              </l-marker>
            </l-map>
          </client-only>
        </div>
        <offer-card-test
          v-for="offer in getOffers"
          :key="offer.id"
          :offer="offer"
          :id="offer.id"
        />
      </div>
    </div>
  </div>
</template>

<script>
import Multiselect from 'vue-multiselect'
import moment from 'moment'
import { mapGetters } from 'vuex'
import OfferCard from '@/components/OffersList/_subs/OfferCard'
import OfferCardTest from '@/components/OffersList/_subs/OfferCardTest'
import charli from '@/assets/img/icones/charli.png'
import loupe from '@/assets/img/button/loupe.png'
import refresh from '@/assets/img/button/refresh.png'
import PriceFilters from '@/components/OffersList/PriceFilters/index.vue'
import EquipmentsFilter from '@/components/OffersList/EquipmentsFilter/index.vue'
import filterSearch from '@/assets/img/button/barre_filtre.png'

import SearchMixin from '@/mixins/search'

export default {
  name: 'OffersList',
  layout: 'clean',
  components: {
    PriceFilters,
    OfferCard,
    Multiselect,
    OfferCardTest,
    EquipmentsFilter
  },
  mixins: [SearchMixin],
  data () {
    return {
      moment,
      loupe,
      refresh,
      url: process.env.MAPBOX_URL,
      zoom: 5,
      center: [47.266963327000084, 2.307975641902913], // NOTE: Center of France
      seen: true,
      housingList: [
        { value: 'entire_house', name: 'Logement entier' },
        { value: 'private_room', name: 'Chambre privée' },
        { value: 'guest_room', name: "Chambre d'hôte" },
        { value: 'unusual_room', name: 'Logement insolite' },
        { value: 'tiny_house', name: 'Tiny house' },
        { value: 'immersive_house', name: 'Logement en immersion' }
      ],
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
      farmTypesList: [
        { value: 'beekeeper', name: 'Apiculture' },
        { value: 'cereal', name: 'Céréalier' },
        { value: 'mushroom_grower', name: 'Champignonnière' },
        { value: 'breeder', name: 'Eleveur' },
        { value: 'horticulturist', name: 'Horticulteur' },
        { value: 'oyster_farmer', name: 'Ostréiculteur' },
        { value: 'market_gardener', name: 'Maraîcher' },
        { value: 'cheese_production', name: 'Production de fromage' },
        { value: 'winegrower', name: 'Viticulteur' },
        { value: 'arborist', name: 'Arboriste' },
        { value: 'brewer', name: 'Brasseur' },
        { value: 'cider_maker', name: 'Cidriculteur' },
        { value: 'riding_stable', name: 'Centre équestre' },
        { value: 'agroforestry', name: 'Agroforesterie' }
      ],
      charli,
      filterSearch,
      similars: [],
      address:
        'https://res.cloudinary.com/agrivillage/image/upload/w_430,h_270,c_fill,f_jpg,fl_progressive/',
      sortKey: '',
      sortSettings: [
          { 'impressions_count': true }
      ],
      desc: true
    }
  },
  computed: {
    ...mapGetters(['getOffersMeta', 'getDataModalSearch'])
  },
  methods: {
    orderBy (array) {
      array.sort((a, b) => {
        return a.impressions_count - b.impressions_count
      }).reverse()
      // this.sort = `${key} > ${direction}`
      // if (direction === 'asc') {
      //   this.getOffers.sort((a, b) => a[key] > b[key] ? 1 : -1)
      // } else {
        // this.getOffers.sort((a, b) => a[key] < b[key] ? 1 : -1)
      // }
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.search-params {
  font-weight: bold;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.title-headers {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-right: 100px;
  @media only screen and (max-width: $breakpoint-tablet) {
    margin-right: 0px;
  }
  p {
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    font-size: 14px;
    line-height: 19px;
    @media only screen and (max-width: $breakpoint-tablet) {
      padding: 0 18px;
      margin-right: 0px;
    }
  }
  .charli {
    background-color: #b4bfbb;
    text-align: center;
    width: 500px;
    margin: 0 0;
    display: flex;
    justify-content: space-between;
    border-top-left-radius: 98.5px;
    border-bottom-left-radius: 98.5px;
    height: 200px;
    p {
      font-weight: 900;
      font-size: 16px;
      line-height: 21px;
      text-align: start;
      align-self: center;
      margin-left: 15px;
      color: #000 !important;
      padding: 0 25px 0 0;
      margin-right: 15px;
      @media only screen and (max-width: $breakpoint-laptop-m) {
        margin: 0;
        padding: 0;
      }
    }
    .symbols {
      display: flex;
      justify-content: center;
      margin-top: 8px;
      i {
        margin-top: 15px 15px;
        @media only screen and (max-width: $breakpoint-tablet) {
          margin-top: 20px;
        }
      }
      .border {
        border-left: 1px solid #476458;
        margin: 35px 0;
        @media only screen and (max-width: $breakpoint-tablet) {
          margin: 50px 0;
        }
      }
      @media only screen and (max-width: $breakpoint-tablet) {
        margin: 0;
      }
    }
    img {
      height: 210px;
      width: 210px;
      margin: auto auto;
      @media only screen and (max-width: $breakpoint-tablet) {
        height: 110px;
        width: 110px;
      }
    }
    @media only screen and (max-width: $breakpoint-tablet) {
      border-top-left-radius: 0;
      border-bottom-left-radius: 0;
      width: 100%;
    }
  }
  @media only screen and (max-width: $breakpoint-tablet) {
    flex-direction: column;
  }
}

.marker-location {
  font-size: 10px;
  margin: auto;
}

.marker-text {
  color: black;
  text-align: center;
  text-decoration: none;
  font-size: 12px;
  font-weight: 800;
  text-transform: uppercase;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

#map-btn {
  background-color: #efce4a;
  border-radius: 50px;
  color: black;
  padding: 15px 25px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  box-shadow: 0px 0px 10px black;
  font-size: 12px;
  font-weight: 500;
  text-transform: uppercase;
  width: 165px;

  flex: initial;
}

#clean-btn {
  background-color: #efce4a;
  border-radius: 50px;
  color: black;
  padding: 15px 25px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  box-shadow: 0px 0px 10px black;
  font-size: 12px;
  font-weight: 500;
  text-transform: uppercase;
  width: 175px;

  flex: initial;
}

.offers-map {
  width: 100%;
  height: 400px;
  // width: 725px;
  // height: 400px;
  margin: 0 auto;
  @media only screen and (max-width: $breakpoint-laptop-l) {
    width: 100%;
    height: 340px;
  }
  @media only screen and (max-width: $breakpoint-tablet) {
    // width: 500px;
    border: 7px solid $agri-green;
    left: 5%;
  }
  @media only screen and (max-width: $breakpoint-mobile-large) {
    // width: 340px;
    height: 340px;
    border: 7px solid $agri-green;
    margin-left: auto;
  }
  @media only screen and (max-width: $breakpoint-mobile-m) {
    // width: 300px;
    height: 300px;
    border: 7px solid $agri-green;
  }
  @media only screen and (max-width: $breakpoint-mobile-s) {
    // width: 300px;
    height: 300px;
    border: 7px solid $agri-green;
  }
}

.btn-discover {
  background-color: #efce4a !important;
  border-radius: 50px;
  color: black;
  padding: 5px 25px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  box-shadow: 0px 0px 10px black;

  font-size: 12px !important;

  @media only screen and (max-width: $breakpoint-tablet) {
    width: 100%;
  }
}

.seo-quote {
  margin-bottom: 20px !important;
  color: #476458;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  @media only screen and (max-width: $breakpoint-tablet) {
    margin-top: 25%;
  }
  @media only screen and (max-width: $breakpoint-mobile-large) {
    margin-top: 10%;
  }
  @media only screen and (max-width: $breakpoint-mobile-m) {
    margin-top: 25vh;
  }
}

.filters-quote {
  color: #476458;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.offers-list {
  @media only screen and (max-width: $breakpoint-mobile-large) {
    margin-top: 30% !important;
    width: 100% !important;
  }
  &-content {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    grid-gap: 8px;

    @media only screen and (max-width: $breakpoint-laptop-l) {
      grid-template-columns: repeat(2, 1fr);
      width: 90%;
      margin: 0 auto;
    }
    @media only screen and (max-width: $breakpoint-laptop-generic) {
      // grid-template-columns: repeat(2, 1fr);
      grid-template-columns: 50% 50%;
      width: 100%;
    }

    @media only screen and (max-width: $breakpoint-laptop-m) {
      grid-template-columns: 50% 50%;
      width: 100%
    }

    @media only screen and (max-width: $breakpoint-tablet-m) {
      grid-template-columns: repeat(1, 1fr);
      grid-gap: 8px;
    }

    @media only screen and (max-width: 600px) {
      display: flex;
      flex-direction: column;
    }

    @media only screen and (max-width: $breakpoint-mobile-l) {
      grid-template-columns: repeat(1, 1fr);
      grid-gap: 18px;
    }

    &__loading {
      text-align: center;
      padding: 64px 0 32px 0;
    }
  }

  &-header {
    margin: 25px 0;
    width: auto;
    @media only screen and (max-width: $breakpoint-tablet) {
      margin: px 0;
    }

    h2,
    h3 {
      margin: 0;
      padding: 0;
    }

    h2 {
      font-size: 28px;
      color: $primary-text;
      font-weight: 400;
    }

    h3 {
      font-weight: 800;
      font-size: 25px;
      font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
        Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
      color: black;
    }
  }

  .offers-list-header {
    width: auto;
    padding: 8px 0;
    margin-left: 40px;
    margin-right: 40px;
    @media only screen and (max-width: $breakpoint-tablet) {
      margin-right: 0px;
      margin-top: 40px;
    }
    margin-top: 60px;
    .text-center {
      font-size: 14px;
      color: #476458;
      font-weight: 500;
      line-height: 19px;
      padding: 0 0 0 18px;
      width: 60%;
      // @media only screen and (max-width: $breakpoint-mobile-l) {
      //   margin-top: 65% !important;
      // }
      // @media only screen and (max-width: $breakpoint-mobile-m) {
      //   margin-top: 25% !important;
      // }
      // @media only screen and (max-width: $breakpoint-mobile-s) {
      //   margin-top: 15% !important;
      // }
      @media only screen and (max-width: $breakpoint-tablet) {
      margin: 20px;
      width: auto;
      }
    }
    @media only screen and (max-width: $breakpoint-laptop-l) {
      width: auto;
    }
    @media only screen and (max-width: $breakpoint-tablet) {
      margin: 0;
    }
  }

  .allResults {
    background-color: $agri-white;
    padding: 25px 12px;
    .result-button {
      display: flex;
      flex-direction: column;
      align-items: flex-start;
        @media only screen and (max-width: $breakpoint-tablet) {
          display: flex;
          align-items: center;
        }
      .btn-filter-desktop {
        width: 80%;
        @media only screen and (max-width: $breakpoint-tablet) {
          display: none;
        }
        img {
          width: 100%;
        }
      }
      .btn-filter {
        display: none;
        margin-left: 44px;
        background-color: #79bc53 !important;
        border: solid 1px #ffffff;
        color: #ffffff;
        border-radius: 50px;
        font-size: 20px;
        font-weight: 900;
        line-height: 0;
        padding: 20px 20px;
        font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
          Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
        box-shadow: 0px 0px 10px black;
        text-decoration: none;
        @media only screen and (max-width: $breakpoint-tablet) {
          display: block;
          margin-bottom: 20px;
          background-color: $agri-green !important;
          padding: 24px 20px;
          margin-left: 0px;
          border: none;
          box-shadow: none;
        }
      }
      h3 {
        @media only screen and (max-width: $breakpoint-tablet) {
          text-align: center;
        }
      }
      @media only screen and (max-width: $breakpoint-tablet) {
        flex-direction: column;
        justify-content: center;
      }
    }
    @media only screen and (max-width: $breakpoint-tablet) {
      padding: 0px;
      width: 100%;
    }
  }

  @media only screen and (max-width: $breakpoint-tablet) {
    margin: 0 auto;
  }
}
.loading-notice {
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding-left: 15px !important;
  font-size: 18px !important;
}

/* MODAL */

.cross {
  i {
    @media only screen and (max-width: $breakpoint-tablet) {
      padding: 0;
      font-size: 18px;
    }
  }
}

.buttons {
  display: flex;
  flex-direction: row;
  @media only screen and (max-width: $breakpoint-tablet) {
    display: flex;
    flex-direction: row;
    margin: 14px auto 0 auto;
  }
}
#loupe {
  align-items: center;
  img {
    width: 30px;
    height: 30px;
  }
}
.button-refresh {
  background-color: $agri-green-light !important;
  border: solid 1px $agri-white;
  color: $agri-white;
  border-radius: 50px;
  font-size: 20px;
  font-weight: 900;
  line-height: 27px;
  margin: 0 0 0 8px;
  padding: 0;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  box-shadow: 0px 0px 10px black;
  justify-content: center;
  display: flex;
  align-items: center;
  width: 101px;

  img {
    margin: 0 auto;
    width: 40px;
    height: 40px;
  }
}

.modal-mask {
  position: fixed;
  z-index: 9998;
  top: 0;
  left: 0;
  padding-top: 200px;
  width: 100%;
  height: 100%;
  background-color: rgba(80, 117, 101, 0.6);
  display: table;
  transition: opacity 0.3s ease;
  @media only screen and (max-width: $breakpoint-tablet) {
    padding-top: 80px;
  }
}

.modal-wrapper {
  display: table-cell;
  vertical-align: middle;
}

.modal-container {
  background-image: linear-gradient(
      to bottom,
      rgba(214, 220, 217, 0.85),
      rgba(214, 220, 217, 0.85)
    ),
    url(~assets/img/modal/tractor.png);
  background-size: 40%;
  width: 70%;
  margin: 0px auto;
  padding: 20px 50px;
  text-align: left;
  background-color: #fff;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.33);
  transition: all 0.3s ease;
  border-radius: 70px;
  @media only screen and (max-width: $breakpoint-tablet) {
    border-radius: 30px;
    width: 90%;
    padding: 14px 30px;
  }
  .title-button {
    position: relative;
    margin: 0 auto;
    text-align: center;
    display: flex;
    justify-content: center;
    button {
      position: absolute;
      right: -20px;
      top: -20px;
      background: none;
      border: none;
      font-size: 40px;
      color: $agri-green;
      cursor: pointer;
    }
    @media only screen and (max-width: $breakpoint-tablet) {
      padding: 4px 0;
    }
  }
  p {
    color: $agri-green;
    text-align: center;
    font-weight: 500;
    @media only screen and (max-width: $breakpoint-tablet) {
      font-size: 14px;
    }
  }
  h3 {
    color: $agri-green;
    text-align: center;
    font-size: 36px;
    font-weight: 900;
    @media only screen and (max-width: $breakpoint-tablet) {
      font-size: 15px;
    }
  }
  .border {
    border-bottom: $agri-green 1px solid;
    width: 176px;
    margin: 0 auto 60px auto;
    @media only screen and (max-width: $breakpoint-tablet) {
      margin: 0 auto 20px auto;
    }
  }
  .filters {
    display: flex;
    justify-content: center;
    @media only screen and (max-width: $breakpoint-tablet) {
      flex-direction: column;
    }
  }

  .filters__footer {
    display: flex;
    justify-content: space-between;
    align-items: center;

    @media only screen and (max-width: $breakpoint-tablet) {
      flex-direction: column-reverse;
    }
  }

  .filter {
    @media only screen and (max-width: $breakpoint-tablet) {
      display: none;
      width: 190px;
      margin: 0 auto;
      margin-bottom: 6px;
    }
  }
  .filterMobile {
    display: none;
    @media only screen and (max-width: $breakpoint-tablet) {
      display: block;
      width: 190px;
      margin: 0 auto;
      margin-bottom: 6px;
    }
  }
  .charli-modal {
    display: flex;
    align-items: center;
    margin-right: 0;

    .charli-txt {
      width: 150px;
      font-size: 18px;
      font-weight: 900;
      line-height: 18px;
      @media only screen and (max-width: $breakpoint-tablet) {
        font-size: 12px;
      }
    }
    .symbol {
      margin-bottom: 80px;
      margin-right: 15px;
      @media only screen and (max-width: $breakpoint-tablet) {
        margin-right: 5px;
      }
    }
    .line {
      height: 60px;
      border: 1px solid $agri-green;
      margin-right: 10px;
    }
    @media only screen and (max-width: $breakpoint-tablet) {
    }
  }
}
.filter::v-deep .multiselect {
  .multiselect__option--selected {
    background-color: #a4a8ad;
  }
  .multiselect__tags {
    background-color: $agri-green;
    border-radius: 47px;
    padding: 8px 30px 0 8px;
    @media only screen and (max-width: $breakpoint-tablet) {
    }
    .multiselect__placeholder {
      color: $agri-white;
    }
  }
}
footer {
  text-align: right;
}

.view-filter {
  margin: 5%;
  position: relative;
  font-weight: bold;
  border-radius: 3%;
  width: max-content;
}
</style>
