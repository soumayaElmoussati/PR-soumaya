<template>
  <div class="farm-type-select">
    <div class="farm-type-select__items">
      <button
        v-for="(type, k) in types"
        :key="k"
        :class="{
          active: isActive(type)
        }"
        :title="$t('offer.farmTypes.' + type)"
        type="button"
        class="btn equipment-select__item"
        @click="select(type)"
      >
        {{ $t('offer.farmTypes.' + type) }}
      </button>
    </div>
    <div
      v-if="error"
      class="farm-type-select__error"
    >
      {{ error }}
    </div>
  </div>
</template>

<script>
  export default {
    name: 'FarmTypeSelect',
    props: {
      error: {
        type: String,
        default: null
      }
    },
    data () {
      return {
        selection: [],
        types: [
          'beekeeper',
          'cereal',
          'mushroom_grower',
          'breeder',
          'horticulturist',
          'oyster_farmer',
          'market_gardener',
          'cheese_production',
          'winegrower',
          'arborist',
          'brewer',
          'cider_maker',
          'riding_stable',
          'agroforestry'
        ]
      }
    },
    methods: {
      isActive (type) {
        return this.selection.includes(type)
      },
      select (type) {
        if (!this.isActive(type)) {
          this.selection.push(type)
        } else {
          const index = this.selection.findIndex(v => v === type)
          this.selection.splice(index, 1)
        }
        this.$emit('input', this.selection)
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";
  @import "@/assets/scss/_mixins.scss";

  .equipment-select{
    display: flex;
    flex-wrap: wrap;

    .check-icon{
      font-size: 15px;
    }

    &__title{
      width: 100%;
      text-transform: uppercase;
      margin-bottom: 10px;
    }

    &__item{
      display: flex;
      flex-direction: column;
      align-content: flex-start;
      line-height: initial;
      // margin-bottom: 16px;
      // margin-right: 16px;
      padding: 0;
      height: 20px;
      width: 25%;
      @media screen and (max-width: 768px) {
        width: 50%;
      }

      &:focus{
        .equipment-select__item__block{
          @include shadow(gray);
        }
      }

      &.active{
        .equipment-select__item__name{
          color: #466357;
          font-weight: bold;
        }

        .equipment-select__item__block{
          border-color: $primary;

          .agri-animals, .agri-others{
            color: $primary;
          }
        }

        &:focus{
          .equipment-select__item__block{
            @include shadow($primary);
          }
        }
      }

      &__block{
        position: relative;
        display: flex;
        border: 1px solid rgba(black, 0.3);
        border-radius: 6px;
        height: 78px;
        width: 78px;
        margin: 0 auto;

        .agri-animals, .agri-others{
          color: rgba(black, 0.5);
          font-size: 42px;
          margin: auto;
        }
        .icon-deck-chair:before {
          color: unset;
        }

        &__check {
          position: absolute;
          background-color: $primary;
          color: white;
          width: 20px;
          height: 20px;
          line-height: 20px;
          border-radius: 100%;
          font-size: 14px;
          bottom: -5px;
          right: -5px;
        }
      }

      &__name{
        color: #476458;
        text-transform: none;
        font-size: 14px;
      }
    }
  }

  .farm-type-select{
    display: flex;
    flex-direction: column;

    &__items{
      display: flex;
      flex-wrap: wrap;
    }

    &__error{
      color: $danger;
      font-size: 16px;
      border-top: 1px solid $danger;
      padding-top: 4px;
    }

    .btn{
      position: relative;
      margin-right: 16px;
      margin-bottom: 16px;

      border-color: rgba(black, 0.3);
      color: rgba(black, 0.75);
      text-transform: none;
      font-weight: 400;

      &-check{
        position: absolute;
        background-color: $primary;
        color: white;
        width: 20px;
        height: 20px;
        line-height: 20px;
        border-radius: 100%;
        font-size: 14px;
        bottom: -5px;
        right: -5px;
      }

      &.active{
        color: #44933b;
      }
    }
  }
</style>
