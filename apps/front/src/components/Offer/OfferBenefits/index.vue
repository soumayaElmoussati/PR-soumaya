<template>
  <div class="offer-equipments">
    <h2 class="content-title">
      {{ $t("offer.titles.benefit") }}
    </h2>
    <div class="divider" />
    <div
      v-if="benefitsSize > 0"
      class="content-side">
      <div class="offer-equipments-list">
        <div
          v-for="(benefit, k) in benefitsList"
          :key="k"
          class="equipment-item"
        >
          <i
            :class="benefit.className"
            class="house"
          />
          <span class="equipment-item-name">
            {{ benefit.name }}
          </span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'OfferBenefit',
  data () {
    return {
      benefits: [
        {
          key: 'cleaning_kit',
          name: this.$t('offer.benefits.cleaning_kit'),
          className: 'icon-001-cleaning'
        },
        {
          key: 'toilet_paper',
          name: this.$t('offer.benefits.toilet_paper'),
          className: 'icon-002-toilet-paper'
        },
        {
          key: 'soap',
          name: this.$t('offer.benefits.soap'),
          className: 'icon-003-soap'
        },
        {
          key: 'household_linen',
          name: this.$t('offer.benefits.household_linen'),
          className: 'icon-004-clean-linen'
        }
      ]
    }
  },
  computed: {
    ...mapGetters(['getOffer']),
    benefitsList () {
      return this.benefits.filter(v => {
        const benefitObj = this.getOffer.benefit
        return benefitObj[v.key]
      })
    },
    benefitsSize () {
      return this.benefitsList.length
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.house{
  color: $agri-green-light;
  font-size: 32px;
  margin: auto;
}

.equipment-icon {
  width: 25px;
}

.icon-side {
  margin-top: 30px;
}

.divider {
  height: 1px;
  background-color: rgba(black, 0.3);
  margin-top: 16px;
  margin-bottom: 16px;
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
    @media only screen and (max-width: $breakpoint-tablet) {
      display: grid;
      grid-template-columns: 50% 50%;
    }

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
