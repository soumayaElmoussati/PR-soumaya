<template>
  <div class="offer-equipments">
    <h5>
      {{ $t('farmer.titles.speaking') }}
    </h5>
    <!-- <ul>
      <li
        v-for="(equipment, k) in equipments"
        :key="k"
      >
        {{ $t('offer.equipments.' + equipment) }}
      </li>
    </ul> -->
    <div class="offer-equipments-list">
      <div
        v-for="(equipment, k) in equipmentsList"
        :key="k"
        class="equipment-item"
      >
        <span class="equipment-item-name">
          {{ equipment.name }}
        </span>
      </div>
    </div>
  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    name: 'FarmerEquiments',
    data () {
      return {
        equipments: [
          {
            key: 'english',
            name: this.$t('farmer.equipments.english'),
            className: 'language'
          },
          {
            key: 'spanish',
            name: this.$t('farmer.equipments.spanish'),
            className: 'language'
          },
          {
            key: 'german',
            name: this.$t('farmer.equipments.german'),
            className: 'language'
          },
          {
            key: 'italian',
            name: this.$t('farmer.equipments.italian'),
            className: 'language'
          },
          {
            key: 'portuguese',
            name: this.$t('farmer.equipments.portuguese'),
            className: 'language'
          },
          {
            key: 'russian',
            name: this.$t('farmer.equipments.russian'),
            className: 'language'
          },
          {
            key: 'dutch',
            name: this.$t('farmer.equipments.dutch'),
            className: 'language'
          },
          {
            key: 'french',
            name: this.$t('farmer.equipments.french'),
            className: 'language'
          }
        ]
      }
    },
    computed: {
      ...mapGetters([
        'getFarmer'
      ]),
      equipmentsList () {
        return this.equipments.filter((v) => {
          const equipmentObj = this.getFarmer.equipment
          return equipmentObj[v.key]
        })
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .offer-equipments{

    h2{
      font-size: 20px;
      font-weight: 400;
      color: $primary-text;
    }

    &-title {
      width: 100%;
      text-transform: uppercase;
      margin-bottom: 5px;
    }

    &-list{
      display: flex;
      flex-wrap: wrap;

      .equipment-item{
        display: flex;
        flex-direction: row;
        align-items: center;

        width: 25%;

        // margin-right: 4px;
        margin-bottom: 10px;

        &:last-child{
          margin-right: 0;
        }

        &-block{
          display: flex;
          // border: 1px solid $primary;
          border-radius: 6px;
          height: 78px;
          width: 78px;
          margin: 0 auto;

          .agri-animals, .agri-others{
            color: $primary;
            font-size: 42px;
            margin: auto;
          }
          .icon-deck-chair:before {
            color: unset;
          }
        }

        &-name{
          // color: $primary;
          color: black;
          font-size: 14px;
          text-align: left;
          width: 100%;
          // max-width: 78px;
        }
      }
    }
  }
</style>
