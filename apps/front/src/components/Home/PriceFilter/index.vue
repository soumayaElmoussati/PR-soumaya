<template>
  <div
    class="price-filter"
  >
    <div class="price-filter__content">
      <div class="price-filter__content__fields">
        <wi-input
          v-validate="`required|max_value:${Math.ceil(max / 100)}|min_value:${min / 100}`"
          id="min"
          v-model.number="computedMin"
          :label="'Min'"
          :error="errors.first('min')"
          data-vv-as="min"
          name="min"
          type="number"
          required
        />
        <wi-input
          v-validate="`required|max_value:${Math.ceil(max / 100)}|min_value:${min / 100}`"
          id="max"
          v-model.number="computedMax"
          :label="'Max'"
          :error="errors.first('max')"
          data-vv-as="max"
          name="max"
          type="number"
          required
        />
      </div>
      <div class="price-filter__content__slider-container">
        <vue-slider
          v-model="interValue"
          :min="min"
          :max="max"
          :interval="1"
          :tooltip-formatter="v => $options.filters.currency(Math.round(v / 100) * 100)"
        />
      </div>
    </div>
    <div
      class="price-filter__footer"
    >
      <div class="price-filter__footer__label">
        {{ $t("home.paragraphs.location") }}
      </div>
      <div class="price-filter__footer__buttons">
        <button
          class="price-filter__footer__clear"
          type="button"
          @click="reset"
        >
          {{ $t("home.buttons.delete") }}
        </button>
        <button
          class="price-filter__footer__validate"
          type="button"
          @click="validate"
        >
          {{ $t("home.buttons.end") }}
        </button>
      </div>
    </div>
  </div>
</template>

<script>
  import WiInput from '@/components/WiUI/Input'

  export default {
    components: {
      WiInput
    },
    props: {
      value: {
        type: Array,
        required: true
      },
      min: {
        type: Number,
        required: true
      },
      max: {
        type: Number,
        required: true
      }
    },
    data () {
      return {
        interValue: [this.min, this.max]
      }
    },
    computed: {
      computedMin: {
        get () {
          return Math.round(this.interValue[0] / 100)
        },
        set (v) {
          this.interValue[0] = Math.round(v * 100)
        }
      },
      computedMax: {
        get () {
          return Math.round(this.interValue[1] / 100)
        },
        set (v) {
          this.interValue[1] = Math.round(v * 100)
        }
      }
    },
    mounted () {
      this.interValue = [
        Math.max(this.value[0], this.min),
        Math.min(this.value[1], this.max)
      ]
    },
    methods: {
      /**
       * Reset the slider to it's initial value.
       * @function reset
       */
      reset () {
        this.interValue = [this.min, this.max]
      },
      /**
       * @function validate
       */
      validate () {
        this.$emit('input', this.interValue)
        this.$emit('close')
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .price-filter {
    position: absolute;
    background-color: white;
    max-width: 300px;
    box-shadow: 0px 3px 16px rgba(black, 0.1);
    z-index: 10;
    top: 60px;

    @media only screen and (max-width: $breakpoint-tablet) {
      left: 0;
      right: 0;
      margin: 0 auto;
    }

    &__content {
      padding: 1rem;

      &__fields {
        display: flex;
        margin-bottom: 0.5rem;

        .wi-input {
          width: 50%;
        }

        @media only screen and (max-width: $breakpoint-tablet) {
          flex-direction: column;

          .wi-input {
            width: 100%;
          }
        }
      }

      &__slider-container {
        padding: 0 16px 0px 16px;
      }
    }

    &__footer {
      display: flex;
      align-items: center;
      border-top: 1px solid $divider;

      &__clear,
      &__validate {
        appearance: none;
        border: none;
        background: white;
        font-size: 14px;
        font-weight: 500;
        padding: 12px;
        cursor: pointer;
      }

      &__clear {
        color: $secondary-text;
      }

      &__validate {
        color: $agri-green;
      }

      &__buttons {
        display: flex;
        justify-content: space-between;
        align-items: center;

        @media only screen and (max-width: $breakpoint-tablet) {
          justify-content: flex-end;
          margin-left: auto;
        }
      }

      &__label {
        color: $third-text;
        font-size: 12px;
        padding-left: 8px;

        @media only screen and (max-width: $breakpoint-tablet) {
          display: none;
        }
      }
    }
  }
</style>
