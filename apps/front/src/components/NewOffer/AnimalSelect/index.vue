<template>
  <div class="animal-select">
    <div class="animal-select__items">
      <button
        v-for="(animal, k) in animals"
        :key="k"
        :class="{
          active: isActive(animal)
        }"
        type="button"
        class="btn animal-select__item"
        @click="select(animal)"
      >
        <div class="animal-select__item__block">
          <i
            v-if="animal != 'bee' && animal != 'lama'"
            :class="[`icon-${animal === 'milk_cow' ? 'milk-cow' : animal}`]"
            class="agri-animals"
          />
          <i
            v-if="animal == 'bee'"
            class="agri-others2 icon-bee"
          />
          <i
            v-if="animal == 'lama'"
            class="lama icon-lama"
          />
        </div>
        <div class="animal-select__item__name">
          {{ $t('offer.animals.' + animal) }}
        </div>
      </button>
    </div>

    <div
      v-if="error"
      class="animal-select__error"
    >
      {{ error }}
    </div>
  </div>
</template>

<script>
  export default {
    name: 'AnimalSelect',
    props: {
      error: {
        type: String,
        default: null
      }
    },
    data () {
      return {
        selection: [],
        animals: [
          'cow', 'chicken', 'sheep', 'rabbit', 'goose', 'goat', 'duck', 'turkey', 'pig', 'milk_cow', 'donkey', 'snail', 'horse', 'bee', 'lama'
        ]
      }
    },
    methods: {
      isActive (animal) {
        return this.selection.includes(animal)
      },
      select (animal) {
        if (!this.isActive(animal)) {
          this.selection.push(animal)
        } else {
          const index = this.selection.findIndex(v => v === animal)
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

  .animal-select{
    display: flex;
    flex-direction: column;
    width: 45%;
    @media only screen and (max-width: $breakpoint-tablet) {
      width: 90%;
    }

    &__items{
      display: grid;
      /* flex-wrap: wrap; */
      grid-template-columns: 1fr 1fr 1fr 1fr 1fr 1fr 1fr;
      grid-template-rows: 1fr 1fr 1fr;
    }

    &__error{
      color: $danger;
      font-size: 16px;
      border-top: 1px solid $danger;
      padding-top: 4px;
    }

    &__item{
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-content: flex-start;
      line-height: initial;
      margin-bottom: 16px;
      margin-right: 45px;
      padding: 0;

      &:focus{
        .animal-select__item__block{
          @include shadow(gray);
        }
      }

      &.active{
        .animal-select__item__name{
          color: #7BBA59;
        }

        .animal-select__item__block{
          border-color: #7BBA59;

          .agri-animals, .agri-others2, .lama{
            color: #7BBA59;
          }
        }

        &:focus{
          .animal-select__item__block{
            @include shadow(#7BBA59);
          }
        }
      }

      &__block{
        position: relative;
        display: flex;
        border: 1px solid rgba(black, 0.3);
        border-radius: 15px;
        height: 78px;
        width: 78px;
        margin: 0 auto;

        .agri-animals, .agri-others2, .lama{
          color: rgba(black, 0.5);
          font-size: 42px;
          margin: auto;
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
        color: rgba(black, 0.5);
        font-size: 14px;
        text-align: center;
        width: 100%;
        max-width: 78px;
        text-transform: none;
      }
    }
  }
</style>
