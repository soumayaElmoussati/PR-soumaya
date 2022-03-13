<template>
  <div
    v-if="equipmentsSize > 0"
    class="offer-equipments">
    <div class="equipment-box">
      <div class="icon-side">
        <img
          src="~assets/img/equipments/bubble.svg"
          class="equipment-icon"
          alt="hygiène"
        >
      </div>

      <div class="content-side">
        <h6 class="offer-equipments-title">
          {{ $t('offer.titles.health') }}
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
  name: 'OfferHygiene',
  data () {
    return {
      equipments: [
        {
          key: 'washing_machine',
          name: this.$t('offer.equipments.washing_machine'),
          className: 'icon-washing-machine'
        },
        {
          key: 'dryer',
          name: this.$t('offer.equipments.dryer'),
          className: 'icon-world'
        },
        {
          key: 'hair_dryer',
          name: this.$t('offer.equipments.hair_dryer'),
          className: 'icon-world'
        },
        {
          key: 'drying_rack',
          name: this.$t('offer.equipments.drying_rack'),
          className: 'icon-world'
        },
        {
          key: 'iron',
          name: this.$t('offer.equipments.iron'),
          className: 'icon-world'
        },
        {
          key: 'wardrobe',
          name: this.$t('offer.equipments.wardrobe'),
          className: 'icon-world'
        },
        {
          key: 'shower',
          name: this.$t('offer.equipments.shower'),
          className: 'icon-world'
        },
        {
          key: 'bath',
          name: this.$t('offer.equipments.bath'),
          className: 'icon-world'
        },
        {
          key: 'baby_bath',
          name: this.$t('offer.equipments.baby_bath'),
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

.equipment-icon {
  width: 25px;
}

.equipment-box {
  display: grid;
  grid-template-columns: 35px auto;
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
    color: $agri-green;
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
