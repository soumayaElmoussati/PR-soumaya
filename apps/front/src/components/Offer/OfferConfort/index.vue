<template>
  <div
    v-if="equipmentsSize > 0"
    class="offer-equipments">
    <div class="equipment-box">
      <div class="icon-side">
        <img
          src="~assets/img/equipments/confort.svg"
          class="equipment-icon"
          alt="confort"
        >
      </div>

      <div class="content-side">
        <h6 class="offer-equipments-title">
          {{ $t("offer.titles.comfort") }}
        </h6>

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
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'OfferConfort',
  data () {
    return {
      equipments: [
        {
          key: 'fireplace',
          name: this.$t('offer.equipments.fireplace'),
          className: 'icon-firepit'
        },
        {
          key: 'heater',
          name: this.$t('offer.equipments.heater'),
          className: 'icon-world'
        },
        {
          key: 'swimming_pool',
          name: this.$t('offer.equipments.swimming_pool'),
          className: 'icon-swim'
        },
        {
          key: 'clim',
          name: this.$t('offer.equipments.clim'),
          className: 'icon-world'
        },
        {
          key: 'fitness',
          name: this.$t('offer.equipments.fitness'),
          className: 'icon-world'
        },
        {
          key: 'garden_lounge',
          name: this.$t('offer.equipments.garden_lounge'),
          className: 'icon-world'
        },
        {
          key: 'bbq',
          name: this.$t('offer.equipments.bbq'),
          className: 'icon-world'
        }
      ]
    }
  },
  computed: {
    ...mapGetters(['getOffer']),
    equipmentsList () {
      return this.equipments.filter(v => {
        const equipmentObj = this.getOffer.equipment
        return equipmentObj[v.key]
      })
    },
    equipmentsSize () {
      return this.equipmentsList.length
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.equipment-box {
  display: grid;
  grid-template-columns: 35px auto;
}

.equipment-icon {
  width: 25px;
}

.icon-side {
  margin-top: 30px;
}

.offer-equipments {
  h2 {
    font-size: 20px;
    font-weight: 400;
    color: $primary-text;
  }

  &-title {
    width: 100%;
    text-transform: uppercase;
    margin-bottom: 5px;
    color: #476458;
    font-weight: bold;
  }

  &-list {
    display: flex;
    flex-wrap: wrap;

    .equipment-item {
      display: flex;
      flex-direction: row;
      align-items: center;

      width: 25%;

      // margin-right: 4px;
      margin-bottom: 10px;
      @media only screen and (max-width: $breakpoint-tablet) {
        width: 33%;
      }

      &:last-child {
        margin-right: 0;
      }

      &-block {
        display: flex;
        // border: 1px solid $primary;
        border-radius: 6px;
        height: 78px;
        width: 78px;
        margin: 0 auto;

        .agri-animals,
        .agri-others {
          color: $primary;
          font-size: 42px;
          margin: auto;
        }
        .icon-deck-chair:before {
          color: unset;
        }
      }

      &-name {
        color: $agri-green;
        font-size: 14px;
        text-align: left;
        width: 100%;
        font-weight: bold;
        @media only screen and (max-width: $breakpoint-tablet) {
          font-size: 11px;
        }
      }
    }
  }
}
</style>
