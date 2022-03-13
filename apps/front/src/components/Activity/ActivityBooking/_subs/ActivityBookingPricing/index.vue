<template>
  <div class="offer-booking-pricing">

    <div
      v-if="hasValues && hasMinDaysOffset"
      class="pricing-line">
      <div class="line-label">
        {{ $t("activity.paragraphs.priceBased") }} ({{ getActivityPeopleCount }} {{ $t("activity.titles.people") }})
      </div>
      <div
        v-if="hasValues && hasMinDaysOffset"
        class="line-value"
      >
        {{ getBasePrice | currency }}
      </div>
      <div v-else>-</div>
    </div>

    <div
      v-if="hasValues && hasMinDaysOffset"
      class="pricing-line">
      <div class="line-label">
        {{ $t("activity.paragraphs.personPrice") }}
      </div>
      <div
        class="line-value"
      >
        {{ getActivityAdditionalPrice | currency }}
      </div>
    </div>

    <hr>

    <div
      v-if="hasValues && hasMinDaysOffset"
      class="pricing-line pricing-line__total">
      <div class="line-label">
        {{ $t("activity.paragraphs.activitiesRate") }}
      </div>
      <div
        class="line-value"
      >
        {{ getSubTotal | currency }}
      </div>
    </div>

    <div class="pricing-line">
      <div class="line-label">
        {{ $t("activity.paragraphs.costs") }}
      </div>
      <div
        v-if="hasValues && hasMinDaysOffset"
        class="line-value"
      >
        {{ getCommission | currency }}
      </div>
      <div v-else>-</div>
    </div>

    <div
      v-if="hasPromo"
      class="pricing-line pricing-line__total">

      <div
        v-if="getCode !== null"
        class="line-label">
        {{ $t("activity.paragraphs.code") }} {{ getCode.code }}
      </div>
      <div
        v-else
        class="line-label">
        {{ $t("activity.paragraphs.incorectCode") }}
      </div>

      <div
        v-if="getCode !== null"
        class="line-value"
      >
        -{{ getCode.amount }}€
      </div>

    </div>

    <hr>

    <div class="pricing-line pricing-line__total">
      <div class="line-label">
        {{ $t("activity.paragraphs.priceTotal") }}
      </div>
      <div
        v-if="hasValues && hasMinDaysOffset"
        class="line-value"
      >
        {{ getFinalPrice | currency }}
      </div>
      <div v-else>-</div>
    </div>

  </div>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    name: 'ActivityBookingPricing',
    computed: {
      ...mapGetters([
        'getActivity', 'getActivities', 'getBookingPeopleCount', 'getBookingDaysOffset', 'getBookingFromDate', 'getBookingPromocode'
      ]),
      hasValues () {
        return this.getBookingFromDate !== null && this.getBookingPeopleCount !== null
      },
      getBasePrice () {
      // NOTE: Prix de base de la nuit
        return this.getActivity.price_per_person
      },
      getDaysOffset () {
        return this.getBookingDaysOffset
      },
      hasMinDaysOffset () {
        return true
      },
      getActivityPeopleCount () {
        return this.getActivity.people_count
      },
      getActivityAdditionalPrice () {
        return this.getActivity.additional_traveler_price
      },
      getActivityPrice () {
        // NOTE: Prix du logement
        if (this.getBookingPeopleCount > this.getActivity.people_count) {
          return (this.getBasePrice + (this.getBookingPeopleCount - this.getActivity.people_count) * this.getActivity.additional_traveler_price)
        } else {
          return (this.getBasePrice)
        }
      },
      hasPromo () {
        if (this.getBookingPromocode !== null) {
          return true
        } else {
          return false
        }
      },
      getCode () {
        var promo = null
        if (this.getBookingPromocode !== null) {
          this.getActivity.promocodes.find(promocode => {
            if (promocode.code === this.getBookingPromocode.toUpperCase() && promocode.state === true) {
              promo = promocode
            }
          })
        }
        return promo
      },
      getSubTotal () {
        // Tarif pour le séjour
        return this.getActivityPrice
      },
      getCommission () {
        //  commissison service (12%) que sur les nuits
        return 300
      },
      /**
       * Returns the price for the weekend days according to the dates
       * specified by the user.
       * @returns {Number} price
       */
      getTotal () {
        return this.getCommission + this.getSubTotal
      },
      getFinalPrice () {
        if (this.getCode !== null) {
          return (this.getTotal - (this.getCode.amount * 100))
        } else {
          return this.getTotal
        }
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  .offer-booking-pricing{
    color: white;
    font-size: 10px;

    .pricing-line{
      display: flex;
      justify-content: space-between;
      padding: 2px;

      .line-label{
        color: white;
        font-size: 16px;
      }

      .line-value{
        color: white;
        font-size: 17px;
      }

      &__total{
        .line-value{
          font-size: 19px;
        }
      }
    }

    hr{
      border: none;
      background-color: white;
      height: 1px;
    }
  }
</style>
