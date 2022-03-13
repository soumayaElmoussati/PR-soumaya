<template>
  <div class="offer-animals">
    <h2 class="content-title">
      {{ $t("activity.paragraphs.animalsPresent") }}
    </h2>
    <div class="divider" />
    <div class="offer-animals-list">
      <div
        v-for="(animal, k) in animalsList"
        :key="k"
        class="animal-item"
      >
        <div class="animal-item-block">
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
        <span class="animal-item-name">
          {{ $t('activity.animals.' + animal) }}
        </span>
      </div>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    name: 'ActivityAnimals',
    data () {
      return {
        animals: [
          'cow', 'bee', 'chicken', 'sheep', 'rabbit', 'goose', 'goat', 'duck', 'turkey', 'pig', 'milk_cow', 'donkey', 'snail', 'horse', 'lama'
        ]
      }
    },
    computed: {
      ...mapGetters([
        'getActivity'
      ]),
      animalsList () {
        return this.animals.filter((v) => {
          const animalObj = this.getActivity.animal
          return animalObj[v]
        })
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .divider {
    height: 1px;
    background-color: rgba(black, 0.3);
    margin-top: 16px;
  }

  .offer-animals{
    .content-title {
      text-transform: uppercase;
      color: #476458;
      font-size: 21px;
      font-weight: 900;
    }

    &-list{
      display: flex;
      flex-wrap: wrap;

      margin-top: 20px;

      .animal-item{
        display: flex;
        flex-direction: column;
        margin-right: 16px;
        margin-bottom: 16px;

        border: 1px solid #79BC53;
        border-radius: 15px;

        &:last-child{
          margin-right: 0;
        }

        &-block{
          display: flex;
          height: 78px;
          width: 78px;
          margin: 0 auto;

          .agri-animals, .agri-others2, .lama{
            color: #79BC53;
            font-size: 42px;
            margin: auto;
          }
        }

        &-name{
          color: #79BC53;
          font-size: 9px;
          text-align: center;
          width: 100%;
          max-width: 78px;
        }
      }
    }
  }
</style>
