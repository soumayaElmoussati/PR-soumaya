<template>
  <div
    v-click-outside="() => dialogOpen = false"
    class="price-filters cust cust-fullsearch"
  >
    <div class="price-filters__field">
      <button
        type="button"
        class="price-filters__field__button"
        @click="dialogOpen = true"
      >
        <template
          v-if="tempPrice"
        >
          {{ $t("offer.buttons.price") }} {{ Math.ceil(tempPrice[0] / 100) * 100 | currency }} - {{ Math.ceil(tempPrice[1] /100) * 100 | currency }}
        </template>
        <template
          v-else
        >
          {{ $t("offer.buttons.prices") }}
        </template>
      </button>
    </div>

    <transition
      name="modal-fade"
    >
      <price-filter
        v-if="dialogOpen"
        v-model="tempPrice"
        :min="getMetrics.min_price || 0"
        :max="getMetrics.max_price || 10000"
        @close="dialogOpen = false"
      />
    </transition>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'
  import PriceFilter from '@/components/Home/PriceFilter'

  export default {
    name: 'PriceFilters',
    components: {
      PriceFilter
    },
    props: {
      value: {
        type: Boolean,
        default: false
      },
      price: {
        type: Array,
        required: true
      }
    },
    data () {
      return {
        dialogOpen: false
      }
    },
    computed: {
      ...mapGetters([
        'getMetrics'
      ]),
      tempValue: {
        get () {
          return this.value
        },
        set (v) {
          this.$emit('input', v)
        }
      },
      tempPrice: {
        get () {
          return this.price
        },
        set (v) {
          this.$emit('update:price', v)
        }
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .price-filters {
    position: relative;
    overflow: visible;

    @media only screen and (max-width: $breakpoint-tablet) {
      display: block;
      width: 190px;
      margin: 0 auto;
      margin-bottom: 6px;
    }

    &__field {
      display: flex;
      align-items: center;
      width: 100%;

      &__value {
        color: rgba(white, 0.75);
        font-size: 14px;
        padding-right: 16px;
        margin-left: 16px;
      }

      &__button {
        display: flex;
        align-items: center;
        background-color: $agri-green;
        color: white;
        border-radius: 47px;
        min-height: 40px;
        border: 1px solid rgb(122, 120, 120);
        font-size: 14px;
        padding-left: 8px;
        padding-right: 16px;

        @media only screen and (max-width: $breakpoint-tablet) {
          text-align: left;
          width: 100%;
          min-height: 40px;
          display: block;
          padding: 8px;
          border-radius: 5px;
          border: 1px solid #e8e8e8;
          background: #fff;
          font-size: 14px;
          color: #adadad;
        }
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
