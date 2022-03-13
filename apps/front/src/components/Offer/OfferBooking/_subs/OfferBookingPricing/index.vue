<template>
  <div class="offer-booking-pricing">

    <div
      v-if="hasValues"
      class="pricing-line">
      <div class="line-label">
        {{ $t("offer.infos.residencePrice") }} {{ getDaysOffset }} {{ $t("offer.infos.night") }}
      </div>
      <div
        v-if="hasMinDaysOffset"
        class="line-value">
        {{ getOfferPrice | currency }}
      </div>
      <div v-else>&#10060; {{ getDaysOffset }} {{ $t("offer.infos.nightDate") }}</div>
    </div>

    <div
      v-if="!hasValues">
      <div class="line-label">
        <h3>Sélectionnez votre date d'arrivée et de départ</h3>
      </div>
    </div>

    <div
      v-if="
        hasValues &&
          hasMinDaysOffset &&
          hasSupPeople &&
          getOfferAdditionalPrice !== 0
      "
      class="pricing-line"
    >
      <div class="line-label">
        {{ $t("offer.infos.personPrice") }}
      </div>
      <div class="line-value">{{ getOfferAdditionalPrice / 100 }}€</div>
    </div>

    <div
      v-if="hasValues && hasMinDaysOffset && hasDiscount"
      class="pricing-line">
      <div class="line-label">
        {{ $t("offer.infos.reduce") }} <br>
        <div
          v-for="discount in getDiscount"
          :key="discount.id">
          <i><b>Réduction de {{ discount.percentage_discount }}% pour {{ discount.min_nights }} nuits </b></i>
        </div>
      </div>
      <div
        v-if="hasValues && hasMinDaysOffset"
        class="line-value">
        {{ getDiscountPrice | currency }}
      </div>
      <div v-else>{{ $t("offer.infos.noProposed") }}</div>
    </div>

    <div v-if="hasService('linens') && hasValues && hasMinDaysOffset">
      <div
        v-if="hasLinensOptional"
        class="pricing-line">
        <div class="line-label">
          {{ $t("offer.infos.linenService") }}
        </div>
        <div class="line-value">
          <div v-if="getServicePrice('linens') === 0">
            {{ $t("offer.infos.inOption") }}
          </div>
          <div v-else>
            {{ getServicePrice("linens") | currency }}
          </div>
        </div>
      </div>
      <div
        v-else
        class="pricing-line">
        <div class="line-label">
          {{ $t("offer.infos.serviceLinen") }}
        </div>
        <div
          v-if="hasMinDaysOffset"
          class="line-value">
          <div v-if="getServicePrice('linens') === 0">
            {{ $t("offer.infos.include") }}
          </div>
          <div v-else>
            {{ getServicePrice("linens") | currency }}
          </div>
        </div>
      </div>
    </div>

    <div v-if="hasService('cleaning') && hasValues && hasMinDaysOffset">
      <div
        v-if="hasCleaningOptional"
        class="pricing-line">
        <div class="line-label">
          {{ $t("offer.infos.cleaning") }}
        </div>
        <div class="line-value">
          <div v-if="getServicePrice('cleaning') === 0">
            {{ $t("offer.infos.inOption") }}
          </div>
          <div v-else>
            {{ getServicePrice("cleaning") | currency }}
          </div>
        </div>
      </div>
      <div
        v-else
        class="pricing-line">
        <div class="line-label">
          {{ $t("offer.services.cleaning") }}
        </div>
        <div
          v-if="hasMinDaysOffset"
          class="line-value">
          <div v-if="getServicePrice('cleaning') === 0">
            {{ $t("offer.infos.include") }}
          </div>
          <div v-else>
            {{ getServicePrice("cleaning") | currency }}
          </div>
        </div>
      </div>
    </div>

    <div v-if="hasService('breakfast') && hasValues && hasMinDaysOffset">
      <div
        v-if="hasBreakfastOptional"
        class="pricing-line">
        <div class="line-label">
          {{ $t("offer.infos.breakfast") }}
        </div>
        <div class="line-value">
          <div v-if="getServicePrice('breakfast') === 0">
            {{ $t("offer.infos.inOption") }}
          </div>
          <div v-else>
            {{ getServicePrice("breakfast") | currency }}
          </div>
        </div>
      </div>
      <div
        v-else
        class="pricing-line">
        <div class="line-label">
          {{ $t("offer.services.breakfast") }}
        </div>
        <div
          v-if="hasMinDaysOffset"
          class="line-value">
          <div v-if="getServicePrice('breakfast') === 0">
            {{ $t("offer.infos.include") }}
          </div>
          <div v-else>
            {{ getServicePrice("breakfast") | currency }}
          </div>
        </div>
      </div>
    </div>

    <div
      v-if="hasService('host_table') && hasValues"
      class="pricing-line">
      <div class="line-label">
        {{ $t("offer.infos.guestTable") }}
      </div>
      <div
        v-if="hasValues && hasMinDaysOffset"
        class="line-value">
        {{ $t("offer.infos.see") }}
      </div>
      <div v-else>{{ $t("offer.infos.serviceNotProposed") }}</div>
    </div>

    <hr v-if="hasValues && hasMinDaysOffset">
    <div
      v-if="hasValues && hasMinDaysOffset"
      class="pricing-line pricing-line__total"
    >
      <div class="line-label">
        {{ $t("offer.infos.stayRate") }}
      </div>
      <div
        id="total-sejour"
        class="line-value">
        {{ getSubTotal | currency }}
      </div>
    </div>

    <div
      v-if="hasValues && hasMinDaysOffset"
      class="pricing-line">
      <div class="line-label">
        {{ $t("offer.infos.stayTax") }}
        <div class="tooltip">(<span>&#63;</span>)
          <span class="tooltiptext">Les municipalités peuvent demander aux voyageurs séjournant sur leur territoire de payer une taxe de séjour</span>
        </div>
      </div>
      <div
        class="line-value">
        <div v-if="isManaged">
          <div v-if="getTax !== 0">
            {{ getTax | currency }}
          </div>
          <div v-else>
            {{ $t("offer.infos.payedOn") }}
          </div>
        </div>
        <div v-else>
          À régler sur place
        </div>
      </div>
    </div>

    <div
      v-if="hasValues && hasMinDaysOffset"
      class="pricing-line">
      <div class="line-label">
        {{ $t("offer.infos.costsService") }}
        <div class="tooltip">(<span>&#63;</span>)
          <span class="tooltiptext">Afin de contribuer au bon fonctionnement d'AgriVillage et de couvrir les coûts des produits et services que nous fournissons, nous facturons des frais de service lorsqu'une réservation est confirmée.</span>
        </div>
      </div>
      <div
        class="line-value">
        {{ getCommission | currency }}
      </div>
    </div>

    <hr v-if="hasValues && hasMinDaysOffset && hasPromo">

    <div
      v-if="hasPromo"
      class="pricing-line pricing-line__total">
      <div
        v-if="getCode !== null"
        class="line-label">
        {{ $t("offer.infos.code") }} {{ getCode.code }}
      </div>
      <div
        v-else
        class="line-label">
        {{ $t("offer.infos.errorCode") }}
      </div>

      <div
        v-if="getCode !== null"
        class="line-value">
        -{{ getCode.amount }}€
      </div>
    </div>

    <hr v-if="hasValues && hasMinDaysOffset">

    <div
      v-if="hasValues && hasMinDaysOffset"
      class="pricing-line pricing-line__total">
      <div class="line-label">
        {{ $t("offer.infos.priceTotal") }}
      </div>
      <div
        v-if="hasValues && hasMinDaysOffset"
        class="line-value">
        {{ getFinalPrice | currency }}
      </div>
    </div>

  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import differenceInDays from 'date-fns/difference_in_days'
import getOverlappingDaysInRanges from 'date-fns/get_overlapping_days_in_ranges'
import eachDay from 'date-fns/each_day'
import isWeekend from 'date-fns/is_weekend'

export default {
  name: 'OfferBookingPricing',
  computed: {
    ...mapGetters([
      'getOffer',
      'getOffers',
      'getBookingPeopleCount',
      'getBookingDaysOffset',
      'getBookingFromDate',
      'getBookingToDate',
      'getBookingPromocode',
      'getBookingBreakfastOpt',
      'getBookingLinensOpt',
      'getBookingCleaningOpt'
    ]),
    hasValues () {
      return (
        this.getBookingFromDate !== null &&
        this.getBookingToDate !== null &&
        this.getBookingPeopleCount !== null
      )
    },
    hasLinensOptional () {
      return this.getOffer.service.linensopt
    },
    hasBreakfastOptional () {
      return this.getOffer.service.breakfastopt
    },
    hasCleaningOptional () {
      return this.getOffer.service.cleaningopt
    },
    hasSupPeople () {
      if (this.getBookingPeopleCount > this.getOffer.sleeps_count) {
        return true
      } else {
        return false
      }
    },
    isManaged () {
      if (this.getOffer.manager) {
        return true
      }
    },
    getBasePrice () {
      // NOTE: Prix de base de la nuit
      if (this.getOffer.price_period.length) {
        let priceDef
        this.getOffer.price_period.forEach(date => {
          let start = date.start_date.slice(0, 10)
          let finish = date.end_date.slice(0, 10)
          let overlap = getOverlappingDaysInRanges(
            start,
            finish,
            this.getBookingFromDate,
            this.getBookingToDate
          )
          let delta = differenceInDays(
            this.getBookingToDate,
            this.getBookingFromDate
          )
          if (overlap > 0) {
            var price =
              (overlap * date.price_period +
                (delta - overlap) * this.getOffer.price_per_person) /
              delta
            priceDef = price
          }
        })
        if (priceDef) {
          return priceDef
        } else {
          return this.getOffer.price_per_person
        }
      } else {
        return this.getOffer.price_per_person
      }
    },
    getMinNights () {
      let minDays = this.getOffer.min_days
      let greatestMinDays = minDays
      if (this.getOffer.price_period.length && this.hasValues) {
        this.getOffer.price_period.forEach(period => {
          let overlapWithDates = getOverlappingDaysInRanges(
            period.start_date.slice(0, 10),
            period.end_date.slice(0, 10),
            this.getBookingFromDate,
            this.getBookingToDate
          )
          if (overlapWithDates > 0) {
            if (period.min_days > greatestMinDays) {
              greatestMinDays = period.min_days
            }
          }
        })
      }
      return greatestMinDays
    },
    getDaysOffset () {
      return this.getBookingDaysOffset
    },
    hasMinDaysOffset () {
      if (this.getDaysOffset >= this.getMinNights) {
        return true
      } else {
        return false
      }
    },
    getOfferPeopleCount () {
      return this.getOffer.people_count
    },
    getOfferAdditionalPrice () {
      return this.getOffer.additional_traveler_price
    },
    getOfferPrice () {
      // Prix du logement
      if (this.getBookingPeopleCount > this.getOffer.people_count) {
        return (
          this.getBasePrice * this.getBookingDaysOffset +
          (this.getBookingPeopleCount - this.getOffer.people_count) *
            this.getOffer.additional_traveler_price *
            this.getBookingDaysOffset +
          this.getPriceWeekend
        )
      } else {
        return (
          this.getBasePrice * this.getBookingDaysOffset + this.getPriceWeekend
        )
      }
    },
    getDiscount () {
      var l = this.getOffer.price_discount.length - 1
      if (l !== -1) {
        return this.getOffer.price_discount
      }
    },
    hasWeekend () {
      const priceWeekend = this.getOffer.price_weekend
      if (!priceWeekend) {
        return false
      } else {
        return true
      }
    },
    hasDiscount () {
      var l = this.getOffer.price_discount.length - 1
      if (l === -1) {
        return false
      } else {
        if (this.getOffer.price_discount[l].percentage_discount > 0) {
          return true
        } else {
          return false
        }
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
        this.getOffer.promocodes.find(promocode => {
          if (
            promocode.code === this.getBookingPromocode.toUpperCase() &&
            promocode.state === true
          ) {
            promo = promocode
          }
        })
      }
      return promo
    },
    getDiscountPrice () {
      // Prix du logement * %Discount if daysoffset > min
      var l = this.getOffer.price_discount.length - 1
      var p = this.getOffer.price_period.length - 1
      var availableDiscounts = []
      var discountAuthorised = true
      if (l === -1) {
        // Si il n'y a pas de reductions
        return 0
      } else {
        if (p === -1) {
          // Si il n'y a pas de period de prix
          this.getOffer.price_discount.forEach(discount => {
            if (!!discount.min_nights && discount.min_nights <= this.getBookingDaysOffset) {
              availableDiscounts.push(discount.min_nights)
            }
          })

          if (availableDiscounts.length !== 0) {
            var maxVal = Math.max.apply(Math, availableDiscounts)
            var result = 0
            this.getOffer.price_discount.forEach(discount => {
              if (discount.min_nights === maxVal) {
                result = ((-this.getOfferPrice * discount.percentage_discount) / 100)
              }
            })
            return result
          } else {
            return 0
          }
        } else {
          // Si il y a des period de prix
          this.getOffer.price_period.forEach(date => {
            let start = date.start_date.slice(0, 10)
            let finish = date.end_date.slice(0, 10)
            let overlap = getOverlappingDaysInRanges(
              start,
              finish,
              this.getBookingFromDate,
              this.getBookingToDate
            )
            if (overlap > 0 && date.use_discount === true) {
              // Si il y a des jours dans cette period de prix et que les reductions sont autoriser
              this.getOffer.price_discount.forEach(discount => {
                if (!!discount.min_nights && discount.min_nights <= this.getBookingDaysOffset) {
                  availableDiscounts.push(discount.min_nights)
                }
              })
            } else if (overlap > 0 && date.use_discount === false) {
              discountAuthorised = false
              return 0
            }
          })
          if (availableDiscounts.length !== 0) {
            maxVal = Math.max.apply(Math, availableDiscounts)
            result = 0
            this.getOffer.price_discount.forEach(discount => {
              if (discount.min_nights === maxVal) {
                result = ((-this.getOfferPrice * discount.percentage_discount) / 100)
              }
            })
            return result
          } else {
            // Si il n'y pas de period dans la range
              this.getOffer.price_discount.forEach(discount => {
              if (!!discount.min_nights && discount.min_nights <= this.getBookingDaysOffset) {
                availableDiscounts.push(discount.min_nights)
              }
            })

            if (availableDiscounts.length !== 0 && discountAuthorised === true) {
              maxVal = Math.max.apply(Math, availableDiscounts)
              result = 0
              this.getOffer.price_discount.forEach(discount => {
                if (discount.min_nights === maxVal) {
                  result = ((-this.getOfferPrice * discount.percentage_discount) / 100)
                }
              })
              return result
            } else {
              return 0
            }
          }
        }
      }
    },
    getSubTotal () {
      // Tarif pour le séjour
      return (
        this.getOfferPrice +
        this.getDiscountPrice +
        this.getServicePrice('linens') +
        this.getServicePrice('cleaning') +
        this.getServicePrice('breakfast') +
        this.getServicePrice('host_table')
      )
    },
    getTax () {
      // taxe sejour
      if (this.getOffer.tourist_tax !== 0) {
        return (
          this.getOffer.tourist_tax *
          this.getBookingPeopleCount *
          this.getBookingDaysOffset
        )
      } else {
        return 0
      }
    },
    getCommission () {
      //  commissison service (12%) que sur les nuits
      if (this.getOffer.manager) {
        return 0
      } else {
        return this.getSubTotal * 0.12
      }
    },
    /**
     * Returns a list of days between the from & to dates.
     * @function getDaysFromRange
     * @returns {Array} days
     */
    getDaysFromRange () {
      const from = this.getBookingFromDate
      const to = this.getBookingToDate

      if (!to || !from) {
        return []
      }

      return eachDay(from, to)
    },
    /**
     * Returns the price for the weekend days according to the dates
     * specified by the user.
     * @function getPriceWeekend
     * @returns {Number} price
     */
    getPriceWeekend () {
      var specialPeriod = false
      var l = this.getOffer.price_period.length - 1
      if (l === -1) {
        specialPeriod = false
      } else {
        if (
          this.getOffer.price_period[l].start_date !== null &&
          this.getOffer.price_period[l].end_date !== null &&
          this.getOffer.price_period[l].price_period > 0
        ) {
          var start = this.getOffer.price_period[l].start_date.slice(0, 10)
          var finish = this.getOffer.price_period[l].end_date.slice(0, 10)
          var overlap = getOverlappingDaysInRanges(
            start,
            finish,
            this.getBookingFromDate,
            this.getBookingToDate
          )
          if (overlap > 0) {
            specialPeriod = true
          } else {
            specialPeriod = false
          }
        } else {
          specialPeriod = false
        }
      }

      const priceWeekend = this.getOffer.price_weekend

      if (priceWeekend !== undefined) {
        const price = this.getOffer.price_weekend.price
        const weekendDays = this.getDaysFromRange.filter(day => isWeekend(day))

        if (
          price !== null &&
          price > 0 &&
          specialPeriod === false &&
          this.getBookingDaysOffset < 3
        ) {
          return (
            price * weekendDays.length * 100 -
            this.getOffer.price_per_person * weekendDays.length
          )
        } else {
          return 0
        }
      } else {
        return 0
      }
    },
    getTotal () {
      if (this.getOffer.manager) {
        return this.getCommission + this.getTax + this.getSubTotal
      } else {
        return this.getCommission + this.getSubTotal
      }
    },
    getFinalPrice () {
      if (this.getCode !== null) {
        if (this.getTotal - this.getCode.amount * 100 < 0) {
          return 0
        } else {
          return this.getTotal - this.getCode.amount * 100
        }
      } else {
        return this.getTotal
      }
    },
    hasBreakfastOpt () {
      if (this.getOffer.service.breakfastopt) {
        if (this.getBookingBreakfastOpt) {
          return true
        }
      }
    },
    hasLinensOpt () {
      if (this.getOffer.service.linensopt) {
        if (this.getBookingLinensOpt) {
          return true
        }
      }
    },
    hasCleaningOpt () {
      if (this.getOffer.service.cleaningopt) {
        if (this.getBookingCleaningOpt) {
          return true
        }
      }
    }
  },
  methods: {
    hasService (service) {
      return this.getOffer.service[service]
    },
    getServicePrice (service) {
      switch (service) {
        case 'host_table':
          return (
            this.getOffer.service[service + '_price'] *
            this.getOffer.service[service]
          )
        case 'linens':
          if (this.getOffer.service.linensopt) {
            if (this.getBookingLinensOpt) {
              return (
                this.getOffer.service[service + '_price'] *
                this.getOffer.service[service] *
                this.getBookingPeopleCount
              )
            } else {
              return 0
            }
          } else {
            return (
              this.getOffer.service[service + '_price'] *
              this.getOffer.service[service] *
              this.getBookingPeopleCount
            )
          }
        case 'cleaning':
          if (this.getOffer.service.cleaningopt) {
            if (this.getBookingCleaningOpt) {
              return (
                this.getOffer.service[service + '_price'] *
                this.getOffer.service[service]
              )
            } else {
              return 0
            }
          } else {
            return (
              this.getOffer.service[service + '_price'] *
              this.getOffer.service[service]
            )
          }
        case 'breakfast':
          if (this.getOffer.service.breakfastopt) {
            if (this.getBookingBreakfastOpt) {
              return (
                this.getOffer.service[service + '_price'] *
                this.getOffer.service[service] *
                this.getBookingPeopleCount *
                this.getBookingDaysOffset
              )
            } else {
              return 0
            }
          } else {
            return (
              this.getOffer.service[service + '_price'] *
              this.getOffer.service[service] *
              this.getBookingPeopleCount *
              this.getBookingDaysOffset
            )
          }
        default:
      }
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.tooltip {
  position: relative;
  display: inline-block;
  border-bottom: 1px dotted black;
}

.tooltip .tooltiptext {
  visibility: hidden;
  width: 300px;
  background-color: #79BC53;
  color: #fff;
  border-radius: 6px;
  padding: 5px 5px;

  /* Position the tooltip */
  position: absolute;
  z-index: 1;

  bottom: 100%;
  left: 50%;
  margin-left: -60px; /* Use half of the width (120/2 = 60), to center the tooltip */

  @media only screen and (max-width: $breakpoint-tablet) {
    width: 200px;
  }
}

.tooltip:hover .tooltiptext {
  visibility: visible;
}

.offer-booking-pricing {
  color: white;
  font-size: 10px;

  .pricing-line {
    display: flex;
    justify-content: space-between;
    padding: 2px;

    .line-label {
      color: white;
      font-size: 16px;
    }

    .line-value {
      color: white;
      font-size: 17px;
    }

    &__total {
      .line-value {
        font-size: 19px;
      }
    }
  }

  hr {
    border: none;
    background-color: white;
    height: 1px;
  }
}
</style>
