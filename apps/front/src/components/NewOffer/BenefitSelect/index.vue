<template>
  <div class="equipment-select">

    <button
      v-for="(benefit, k) in benefits"
      :key="k"
      :class="{
        active: isActive(benefit.key)
      }"
      type="button"
      class="btn equipment-select__item"
      @click="select(benefit.key)"
    >

      <div
        class="equipment-select__item__name">
        {{ benefit.name }}
      </div>
    </button>

  </div>
</template>

<script>
  export default {
    name: 'BenefitSelect',
    data () {
      return {
        selection: [],
        benefits: [
          {
            key: 'cleaning_kit',
            name: this.$t('offer.benefits.cleaning_kit')
          },
          {
            key: 'toilet_paper',
            name: this.$t('offer.benefits.toilet_paper')
          },
          {
            key: 'soap',
            name: this.$t('offer.benefits.soap')
          },
          {
            key: 'household_linen',
            name: this.$t('offer.benefits.household_linen')
          }
        ]
      }
    },
    methods: {
      isActive (benefit) {
        return this.selection.includes(benefit)
      },
      select (benefit) {
        if (!this.isActive(benefit)) {
          this.selection.push(benefit)
        } else {
          const index = this.selection.findIndex(v => v === benefit)
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

  .headline{
    padding-top:20px;
    text-transform: uppercase;
    font-size: 18px;
    width: 100%;
    font-family: 'Avenir', -apple-system, BlinkMacSystemFont, 'Segoe UI', Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  }

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
      height: 25px;
      width: 33%;
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
          color: #44933b;
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
        color: #466357;
        text-transform: none;
        font-size: 14px;
      }
    }
  }

  @media screen and (max-width: 768px) {

    .equipment-select{

      &__item{
        width: 50%;
      }
    }
  }
</style>
