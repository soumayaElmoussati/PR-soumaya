<template>
  <div
    class="equipment-filter"
  >
    <div
      class="equipment-filter__content"
    >
      <div class="equipment-filter__content__label">
        {{ $t("home.equipments.equipment") }}
      </div>

      <div class="equipment-filter__checkboxes">
        <div
          v-for="(item, k) in items"
          :key="k"
          class="checkbox"
        >
          <input
            :id="item.key"
            v-model="tempValue"
            :value="item.key"
            name="equipments"
            type="checkbox"
          >
          <label
            :for="item.key"
          >
            {{ item.label }}
          </label>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    props: {
      value: {
        type: Array,
        required: true
      }
    },
    data () {
      return {
        items: [
          {
            key: 'fireplace',
            label: 'Cheminée'
          },
          {
            key: 'wifi',
            label: 'Accès internet'
          },
          {
            key: 'swimming_pool',
            label: 'Piscine'
          },
          {
            key: 'parking',
            label: 'Parking'
          },
          {
            key: 'bbq',
            label: 'Barbecue / Plancha'
          },
          {
            key: 'animals_welcome',
            label: 'Animal accepté'
          },
          {
            key: 'accessible',
            label: 'Accès handicapés'
          },
          {
            key: 'breakfast',
            label: 'Petit déjeuner'
          }
        ]
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
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .equipment-filter {
    position: absolute;
    background-color: white;
    width: 500px;
    box-shadow: 0px 3px 16px rgba(black, 0.1);
    z-index: 10;
    top: 60px;
    right: 0;

    @media only screen and (max-width: $breakpoint-tablet) {
      left: 0;
      right: 0;
      margin: 0 auto;
      width: 100%;
    }

    &__content {
      padding: 1rem;
      border: none;

      &__label {
        text-transform: uppercase;
        font-size: 12px;
        font-weight: 500;
        color: $secondary-text;
        margin-bottom: 12px;
      }
    }

    &__checkboxes {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 16px;

      @media only screen and (max-width: $breakpoint-tablet) {
        grid-template-columns: 1fr;
      }

      .checkbox {
        display: flex;
        align-items: center;

        input {
          margin-right: 8px;
        }
      }

      label {
        font-size: 14px;
        white-space: nowrap;
      }
    }
  }
</style>
