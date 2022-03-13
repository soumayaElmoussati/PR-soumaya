<template>
  <div class="offer-equipments">
    <h2 class="content-title">
      {{ $t("offer.titles.equipments") }}
    </h2>
    <div class="divider" />
    <div class="equipment-box">
      <div class="icon-side">
        <img
          src="~assets/img/equipments/tv.svg"
          class="equipment-icon"
          alt="entertainment"
        >
      </div>

      <div
        v-if="equipmentsSize > 0"
        class="content-side">
        <h6 class="offer-equipments-title">
          {{ $t("offer.titles.fun") }}
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
  name: 'OfferEquiments',
  data () {
    return {
      equipments: [
        {
          key: 'wifi',
          name: this.$t('offer.equipments.wifi'),
          className: 'icon-wifi'
        },
        {
          key: 'tv',
          name: this.$t('offer.equipments.tv'),
          className: 'icon-tv'
        },
        {
          key: 'internet',
          name: this.$t('offer.equipments.internet'),
          className: 'icon-world'
        },
        {
          key: 'dvd_player',
          name: this.$t('offer.equipments.dvd_player'),
          className: 'icon-world'
        },
        {
          key: 'games',
          name: this.$t('offer.equipments.games'),
          className: 'icon-world'
        }
        // {
        //   key: 'english_speaking',
        //   name: this.$t('offer.equipments.english_speaking'),
        //   className: 'icon-world'
        // }
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

.divider {
  height: 1px;
  background-color: rgba(black, 0.3);
  margin-top: 16px;
}

.offer-equipments {
  .content-title {
    text-transform: uppercase;
    color: $agri-green;
    font-size: 21px;
    font-weight: 900;
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

      margin-bottom: 10px;
      @media only screen and (max-width: $breakpoint-tablet) {
        width: 33%;
      }

      &:last-child {
        margin-right: 0;
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
