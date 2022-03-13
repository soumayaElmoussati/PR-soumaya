<template>
  <div
    class="searchbar-distance"
  >
    <div class="searchbar-distance__content">
      <div class="searchbar-distance__content__label">
        {{ $t("home.paragraphs.rayon") }}
      </div>
      <div class="searchbar-distance__content__slider-container">
        <vue-slider
          v-model="interValue"
          :tooltip-formatter="'{value} km'"
          :data="[10, 50, 100, 200]"
          :marks="val => [min, max].includes(val) ? { label: `${val} km` } : null"
        />
      </div>
    </div>
    <div
      class="searchbar-distance__footer"
    >
      <button
        class="searchbar-distance__footer__clear"
        type="button"
        @click="reset"
      >
        {{ $t("home.buttons.delete") }}
      </button>
      <button
        class="searchbar-distance__footer__validate"
        type="button"
        @click="validate"
      >
        {{ $t("home.buttons.submit") }}
      </button>
    </div>
  </div>
</template>

<script>
  export default {
    props: {
      value: {
        type: Number,
        required: true
      },
      min: {
        type: Number,
        default: 10
      },
      max: {
        type: Number,
        default: 200
      }
    },
    data () {
      return {
        interValue: 0
      }
    },
    mounted () {
      this.interValue = this.value
    },
    methods: {
      /**
       * Reset the slider to it's initial value.
       * @function reset
       */
      reset () {
        this.interValue = this.value
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

  .searchbar-distance {
    position: absolute;
    background-color: white;
    width: 100%;
    max-width: 300px;
    box-shadow: 0px 3px 16px rgba(black, 0.1);
    z-index: 10;
    top: 60px;

    &__content {
      padding: 1rem;

      &__label {
        font-size: 14px;
        margin-bottom: 4px;
      }

      &__slider-container {
        padding: 0 16px 16px 16px;
      }
    }

    &__footer {
      display: flex;
      justify-content: space-between;
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
    }
  }
</style>
