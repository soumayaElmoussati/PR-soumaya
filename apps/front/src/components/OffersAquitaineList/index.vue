<template>
  <div
    id="offers"
    class="offers-list">
    <div class="offers-list-header">
      <p class="text-center seo-quote">
        {{ $t("offer.paragraphs.aquitaine")[0] }}<br>
        {{ $t("offer.paragraphs.aquitaine")[1] }}<br>
        {{ $t("offer.paragraphs.aquitaine")[2] }}<br>
        {{ $t("offer.paragraphs.aquitaine")[3] }}<br>
        {{ $t("offer.paragraphs.aquitaine")[4] }}<br>
        {{ $t("offer.paragraphs.aquitaine")[5] }}
      </p>
      <div style="display: flex;">
        <h3
          v-if="$wait.is('loading more offers')"
          class="loading-notice">
          {{ $t("offer.titles.loading") }}
        </h3>
      </div>
      <h3 class="offer-count">
        {{
          $tc("offer.offers_available", getOffersMeta.total_count, {
            count: getOffersMeta.total_count
          })
        }}
      </h3>

      <br >

      <div class="filters">
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
            @input="fetchOffers"
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
            @input="fetchOffers"
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
            @input="fetchOffers"
          />
        </div>

        <div
          id="map-btn"
          class="control filter"
          style="cursor: pointer;"
          @click="seen = !seen"
        >
          <p class="mb-0">{{ $t("offer.buttons.card") }}</p>
        </div>

        <div
          id="clean-btn"
          class="control filter"
          style="cursor: pointer;"
          @click="reset"
        >
          <p class="mb-0">{{ $t("offer.buttons.deleteFilter") }}</p>
        </div>
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
                  {{ offer.name }}<br >
                  <p class="marker-location">À {{ offer.address.city }}</p>
                </nuxt-link>
              </l-popup>
            </l-marker>
          </l-map>
        </client-only>
      </div>

      <offer-card
        v-for="offer in getOffers"
        :key="offer.id"
        :offer="offer"
        :id="offer.id"
      />
    </div>
  </div>
</template>

<script>
import Multiselect from 'vue-multiselect'
import { mapGetters } from 'vuex'
import OfferCard from '@/components/OffersList/_subs/OfferCard'
import SearchMixin from '@/mixins/search'

export default {
  name: 'OffersAquitaineList',
  layout: 'clean',
  components: {
    OfferCard,
    Multiselect
  },
  mixins: [
    SearchMixin
  ],
  data () {
    return {
      url: process.env.MAPBOX_URL,
      zoom: 6,
      center: [44.7002222, -0.2995785], // NOTE: Center of Aquitaine
      seen: true,
      housingList: [
        { value: 'entire_house', name: 'Logement entier' },
        { value: 'private_room', name: 'Chambre privée' },
        { value: 'guest_room', name: "Chambre d'hôte" },
        { value: 'unusual_room', name: 'Logement insolite' },
        { value: 'tiny_house', name: 'Tiny house' },
        { value: 'immersive_house', name: 'Logement en immersion' }
      ],
      housings: [],
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
    ...mapGetters(['getAllOffers', 'getOffersMeta'])
  },
  methods: {
    reset () {
      this.resetFilter()
      this.fetchOffers()
    },
    fetchOffers () {
      this.filter({ area: 'aquitaine' })
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.filters {
  display: grid;
  grid-template-columns: 150px 150px 150px 150px 150px;
  grid-column-gap: 40px;
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

.filter::v-deep .multiselect {
  color: black !important;

  .multiselect__tags {
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
  .multiselect__tags-wrap {
    margin-bottom: 11px;
  }
  .multiselect__tag {
    background-color: azure;
    color: #000;
    border-radius: 5px;
    font-size: 13.5px;
    font-weight: 700;
    margin-right: 3px;
    margin-left: 3px;
  }

  .multiselect__placeholder {
    color: $agri-white;
    margin-top: 5px;
    margin-left: 5px;
  }

  .multiselect__select {
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
  input::placeholder {
    color: lightgrey;
  }
  .multiselect__single {
    color: #fff;
    font-weight: 700;
    background-color: transparent;
  }
  .multiselect__content-wrapper {
    background-color: #fff;
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
  grid-column: 1 / 3;
  @media only screen and (max-width: $breakpoint-mobile-l) {
    grid-column: auto;
    height: 352px;
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

.offer-count {
  margin-bottom: 30px;
}

.seo-quote {
  margin-bottom: 80px !important;
  margin-top: 70px !important;
  color: #476458;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.offers-list {
  &-content {
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

  &-header {
    margin: 32px 0;
    @media only screen and (max-width: $breakpoint-tablet) {
      margin: 25px 0;
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
}
.loading-notice {
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding-left: 15px !important;
  font-size: 18px !important;
}
</style>
