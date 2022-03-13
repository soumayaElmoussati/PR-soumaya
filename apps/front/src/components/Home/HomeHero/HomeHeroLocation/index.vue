<template>
  <div
    v-click-outside="() => (dialogOpen = false)"
    id="region"
    class="home-hero-location cust searchbar-field-location cust-fullsearch searchbar-location"
  >
    <i
      id="icon-geo"
      class="icon-geo agri-others"
      aria-hidden="true" />

    <div class="home-hero-location__field">
      <input
        id="address"
        ref="input"
        v-model="tempValue.street_name"
        :placeholder="$t('home.placeholder.goOn')"
        data-vv-as="addresse"
        label=""
        class="input-address"
        name="address"
        type="text"
      >
      <button
        v-if="tempValue.street_name"
        class="home-hero-location__field__value"
        type="button"
        @click="dialogOpen = true"
      >
        {{ tempDistance }}&nbsp;km
      </button>
    </div>

    <transition name="modal-fade">
      <searchbar-distance
        v-if="dialogOpen"
        v-model="tempDistance"
        @close="dialogOpen = false"
      />
    </transition>
  </div>
</template>

<script>
import SearchbarDistance from '@/components/Home/SearchbarDistance'

export default {
  name: 'HomeHeroLocation',
  components: {
    SearchbarDistance
  },
  props: {
    placeholder: {
      type: String,
      default: 'Où voulez-vous partir ?'
    },
    value: {
      type: Object,
      default: () => ({})
    },
    distance: {
      type: Number,
      default: 50
    }
  },
  data () {
    return {
      mapsLoaded: false,
      dialogOpen: false
    }
  },
  computed: {
    tempValue: {
      get () {
        return this.value
      },
      set (v) {
        this.$emit('input', v)
      }
    },
    tempDistance: {
      get () {
        return this.distance
      },
      set (v) {
        this.$emit('update:distance', v)
      }
    }
  },
  mounted () {
    this.loadMaps()

    if (!this.mapsLoaded) {
      window.addEventListener('maps-module:loaded', () => {
        this.loadMaps()
      })
    }
  },
  methods: {
    loadMaps () {
      if (this.$google) {
        this.mapsLoaded = true
        const autocomplete = new this.$google.maps.places.Autocomplete(
          this.$refs.input,
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
              v => v === 'administrative_area_level_1'
            )
          )
          const postalCode = addressComponents.find(comp =>
            comp.types.find(v => v === 'postal_code')
          )

          const address = {}
          if (
            addressComponents[0].long_name !== addressComponents[1].long_name
          ) {
            address.street_name = `${addressComponents[0].long_name} ${addressComponents[1].long_name}`
          } else {
            address.street_name = `${addressComponents[0].long_name}`
          }

          /**
           * TODO: This is an incorrect implementation of Google Autocomplete as some values
           * may be undefined.
           */
          if (city) address.city = city.long_name
          if (postalCode) address.postalCode = postalCode.long_name
          if (geometry) {
            address.location = {
              lat: geometry.location.lat(),
              lng: geometry.location.lng()
            }
          }

          this.tempValue = address

          /**
           * Show the distance menu whenever the address has changed.
           */
          this.dialogOpen = true
        })
      }
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

#address {
  @media only screen and (max-width: $breakpoint-laptop-l) {
    width: 11rem;
  }
}
#region {
  @media only screen and (min-width: $breakpoint-laptop-l) {
    width: 100% !important;
  }
}

.home-hero-location {
  position: relative;
}

.home-hero-location__field {
  display: flex;
  align-items: center;
  width: 100%;
  width: calc(100% - 50px);

  input {
    flex: 1;
  }

  &__value {
    background: transparent;
    appearance: none;
    border: none;
    color: rgba(white, 0.75);
    font-size: 14px;
    padding-right: 16px;
    /* margin-left: 16px; */
    height: 45px;

    &:hover {
      cursor: pointer;
    }
  }
}

/* TODO: This CSS was copy-pasted from the rest of the views for simplicity sake, refactor
  the rest as it's duplicated code... */
.searchbar-field-location {
  margin: 0 auto;
  display: flex;
  align-self: center;
  align-items: center;
  padding: 0.6rem auto 0.6rem auto;
  background-color: $agri-green-opacity !important;
  border: 1px solid white;
  border-radius: 50px;
  width: 100%;
  /* height: 66px !important; */
  display: grid;
  grid-template-columns: auto auto;
  input {
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    color: $agri-white;
  }
  i {
    padding: 0.6rem;
  }
  @media only screen and (max-width: $breakpoint-tablet) {
    background-color: transparent;
  }
}
input:focus::placeholder {
  color: transparent;
}
.input-address {
  background-color: rgba(71, 100, 88, 0.2) !important;
  color: $agri-white;
  border: none;
  border-radius: 50px;
  max-width: 200px;
  outline: none;
  background-color: transparent;
}
.cust::v-deep .multiselect {
  background-color: transparent !important;

  .multiselect__option--selected {
    background-color: #a4a8ad;
  }

  .multiselect__tags {
    min-height: 50px;
    background-color: transparent !important;
    border: none;
    border-radius: 50px;
    display: flex;
    align-items: center;
    padding: 0;
  }
  .multiselect__select {
    background-color: transparent !important;
    top: calc(50% - 20px);
  }
  .multiselect__placeholder {
    font-size: 13px;
    line-height: 14px;
    color: $agri-white;
    font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
      Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
    padding: 0;
    margin: 0;
    text-align: start;
    margin-left: 4px;
  }
  .multiselect__input {
    background-color: transparent !important;
    padding-top: 7px !important;
    padding-left: 0px !important;
  }
  .multiselect__tag {
    /* padding: 0 !important; */
    @media only screen and (max-width: $breakpoint-tablet) {
      width: 160px;
    }
  }

  .multiselect__content-wrapper {
    background-color: $agri-white !important;
    text-align: start !important;
    @media only screen and (max-width: $breakpoint-tablet) {
      width: 250px !important;
      margin-left: -50px !important;
      margin-top: 10px;
      /* display: block !important; */
    }
    .multiselect__content {
      background-color: transparent !important;
    }
  }
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 190px;
  }
}

.cust {
  /* position: relative; */
  i {
    text-align: center;
    /* z-index: 100;
          line-height: 0px; */
    font-size: 1.4rem;
    color: white;
    /* transition: 0.3s; */
    /* margin-top: 4vh; */
    @media only screen and (max-width: $breakpoint-tablet) {
      margin-left: 1vh;
    }
  }
}
</style>
