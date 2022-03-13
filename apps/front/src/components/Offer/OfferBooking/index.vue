<template>
  <form
    class="offer-booking"
    @submit.prevent="formSubmitted">
    <div class="offer-booking-fields">
      <p class="booking-title">{{ $t("offer.titles.organise") }}</p>

      <div class="booking-fields">
        <div class="dates">
          <div class="dates2-inputs">
            <datepicker
              ref="datepicker1"
              :disabled-dates="CatchEnd"
              :monday-first="true"
              :format="'dd-MM-yy'"
              :language="fr"
              v-model="from"
              :input-class="'input2 input-booking'"
              :editable="false"
              :placeholder="$t('home.placeholder.arrive')"
              :highlighted="highlightedDates"
              :error="errors.first('arrival_date')"
            />

            <datepicker
              ref="datepicker2"
              :disabled-dates="CatchStart"
              :open-date="from"
              :monday-first="true"
              :format="'dd-MM-yy'"
              :language="fr"
              v-model="to"
              :input-class="'input2 input-booking second-calendar'"
              :editable="false"
              :placeholder="$t('home.placeholder.depart')"
              :highlighted="highlightedDates"
              :error="errors.first('departure_date')"
              class="vdp-datepicker fullscreen-when-on-mobile"
            />
          </div>
        </div>

        <div class="people_count">
          <div id="numberPeople">
            <select
              id="people_count"
              v-model="peopleCount"
              name="people_count"
              class="input input-people-count"
              required
              @input="setBookingPeopleCount(peopleCount)"
            >
              <option
                v-for="(count, k) in getPeopleCount"
                :key="k"
                :value="count"
              >
                {{
                  $tc("offer.fields.peopleCount", count, {
                    count
                  })
                }}
              </option>
            </select>
          </div>
        </div>
      </div>

      <div class="promocode">
        <label for="promocode">{{ $t("offer.infos.haveCode") }}</label>
        <div>
          <input
            id="promocode"
            v-model="promocode"
            name="promocode"
            type="text"
            class="input"
            @input="setBookingPromocode(promocode)"
          >
        </div>
      </div>

      <div class="services">
        <div v-if="getOffer.service.breakfastopt === true && from && to && getOffer.service.breakfast === true">
          <input
            id="checkboxBreakfast"
            v-model="breakfastopt"
            type="checkbox"
            name="breakfast"
            @input="setBookingBreakfastOpt(!breakfastopt)"
          >

          <label for="checkboxBreakfast">
            {{ $t("offer.services.breakfast") }}
          </label>
        </div>

        <div v-if="getOffer.service.linensopt === true && from && to && getOffer.service.linens === true">
          <input
            id="checkboxLinens"
            v-model="linensopt"
            type="checkbox"
            name="linens"
            @input="setBookingLinensOpt(!linensopt)"
          >

          <label for="checkboxLinens">
            {{ $t("offer.infos.serviceLinen") }}
          </label>
        </div>

        <div v-if="getOffer.service.cleaningopt === true && from && to && getOffer.service.cleaning === true">
          <input
            id="checkboxCleaning"
            v-model="cleaningopt"
            type="checkbox"
            name="cleaning"
            @input="setBookingCleaningOpt(!cleaningopt)"
          >

          <label for="checkboxCleaning">
            {{ $t("offer.services.cleaning") }}
          </label>
        </div>
      </div>
    </div>
    <offer-booking-pricing ref="offerBookingPricing" />

    <input
      v-if="canSubmit"
      id="bookingbtn"
      type="submit"
      value="Reserver maintenant"
      class="btn connect-btn"
    >
  </form>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import {
  format,
  addDays,
  subDays,
  parse,
  compareAsc,
  eachDay,
  isBefore,
  isAfter,
  startOfDay
} from 'date-fns'
import OfferBookingPricing from './_subs/OfferBookingPricing'
import Datepicker from 'vuejs-datepicker'

export default {
  name: 'OfferBooking',
  components: {
    OfferBookingPricing,
    Datepicker
  },
  props: {
    canSubmit: {
      type: Boolean,
      default: false
    }
  },
  data () {
    return {
      breakfastopt: false,
      linensopt: false,
      cleaningopt: false,
      fr: {
        language: 'English',
        months: [
          'Janvier',
          'Février',
          'Mars',
          'Avril',
          'Mai',
          'Juin',
          'Juillet',
          'Août',
          'Septembre',
          'Octobre',
          'Novembre',
          'Décembre'
        ],
        monthsAbbr: [
          'Jan',
          'Fév',
          'Mar',
          'Avr',
          'Mai',
          'Juin',
          'Juil',
          'Août',
          'Sep',
          'Oct',
          'Nov',
          'Déc'
        ],
        days: ['Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam'],
        rtl: false,
        ymd: false,
        yearSuffix: ''
      }
    }
  },

  computed: {
    highlightedDates () {
      let dates = []
      this.formattedBookingDates.forEach(booking => {
        let range = eachDay(booking.from, booking.to)
        dates = dates.concat(range)
      })
      // return {
      //   ranges: this.formattedBookingDates,
      //   includeDisabled: true
      // }
      return { dates: dates, includeDisabled: true }
    },

    formattedBookingDates () {
      return this.getCurrentOfferBookings
        .map(booking => {
          return {
            to: startOfDay(parse(booking.end)),
            from: startOfDay(parse(booking.start))
          }
        })
        .sort((a, b) => {
          return compareAsc(a.from, b.from)
        })
    },
    formattedBookingDatesForEnd () {
      return this.formattedBookingDates.map(booking => {
        return {
          to: addDays(booking.to, 1),
          from: addDays(booking.from, 1)
        }
      })
    },
    formattedBookingDatesForStart () {
      return this.formattedBookingDates.map(booking => {
        return {
          to: booking.to,
          from: booking.from
        }
      })
    },
    CatchEnd () {
      var fDate
      var to = new Date(Date.now() - 864e5)
      var bookings = this.formattedBookingDatesForStart
      if (this.to === null) {
        fDate = null
      } else {
        if (this.from == null) {
          // this.from = format(this.from, 'D-MM-YYYY')
        } else {
        }
        fDate = subDays(this.to, 1)
        var closestBookingEndDate = bookings.find(booking => {
          return isAfter(booking.from, to) && isBefore(booking.to, fDate)
        })

        if (closestBookingEndDate) {
          to = subDays(closestBookingEndDate.to, 1)
        }
      }
      return { to: to, from: fDate, ranges: bookings }
    },
    CatchStart () {
      var sDate
      var from
      var bookings = this.formattedBookingDatesForEnd
      if (this.from === null) {
        sDate = new Date()
      } else {
        sDate = addDays(this.from, 1)
        var closestBookingEndDate = bookings.find(booking => {
          return isAfter(booking.from, sDate)
        })
        // this.format(this.from)
        if (closestBookingEndDate) {
          from = addDays(closestBookingEndDate.from, 1)
        }
      }
      return { to: sDate, from: from, ranges: bookings }
    },

    minDate () {
      return format(addDays(new Date(), 1), 'YYYY-MM-DD')
    },
    minTargetDate () {
      return this.from
        ? format(this.from, 'YYYY-MM-DD')
        : format(addDays(new Date(), 1), 'YYYY-MM-DD')
    },
    getPeopleCount () {
      return Array.from(new Array(this.getOffer.max_people_count)).map(
        (_, k) => k + 1
      )
    },
    from: {
      get () {
        // this.setBookingFromDate(this.$root.$children[1].sDate)
        // return this.$root.$children[1].sDate
        return this.getBookingFromDate
      },
      set (value) {
        this.setBookingFromDate(value)
      }
    },
    to: {
      get () {
        // this.setBookingToDate(this.$root.$children[1].fDate)
        // return this.$root.$children[1].fDate
        return this.getBookingToDate
      },
      set (value) {
        this.setBookingToDate(value)
      }
    },
    peopleCount: {
      get () {
        return this.getBookingPeopleCount
      },
      set (value) {
        this.setBookingPeopleCount(value)
      }
    },
    promocode: {
      get () {
        return this.getBookingPromocode
      },
      set (value) {
        this.setBookingPromocode(value)
      }
    },
    breakfastOpt: {
      get () {
        return this.getBookingBreakfastOpt
      },
      set (value) {
        this.setBookingBreakfastOpt(value)
      }
    },
    linensOpt: {
      get () {
        return this.getBookingLinensOpt
      },
      set (value) {
        this.setBookingLinensOpt(value)
      }
    },
    cleaningOpt: {
      get () {
        return this.getBookingCleaningOpt
      },
      set (value) {
        this.setBookingCleaningOpt(value)
      }
    },
    ...mapGetters([
      'getBookingFromDate',
      'getBookingToDate',
      'getBookingPeopleCount',
      'getBookingPromocode',
      'getBookingBreakfastOpt',
      'getBookingLinensOpt',
      'getBookingCleaningOpt',
      'getOffer',
      'getCurrentOfferBookings',
      'isClient',
      'isFarmer'
    ]),
    hasBookingButton () {
      return this.$route.name === 'Offer'
    },
    canBook () {
      return this.getBookingFromDate !== null && this.getBookingToDate !== null
    }
  },
  methods: {
    ...mapActions([
      'setBookingFromDate',
      'setBookingToDate',
      'setBookingPeopleCount',
      'setBookingPromocode',
      'setBookingBreakfastOpt',
      'setBookingLinensOpt',
      'setBookingCleaningOpt'
    ]),
    format (value) {
      if (value == null) {
        // this.from = format(this.from, 'D-MM-YYYY')
      } else {
        let dateFormat = format(value, 'D-MM-YYYY')
        this.from = dateFormat
      }
    },
    formSubmitted () {
      if (this.canBook) {
        this.$router.push({
          name: 'OfferBooking',
          params: {
            id: this.$route.params.id,
            slug: this.$route.params.slug
          }
        })
      }
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";
@import "@/assets/scss/_mixins.scss";

.connect-btn {
  margin: auto;
  border: 1px solid white;
  color: white;
  border-radius: 50px;
  font-size: 12px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI",
    Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  padding: 0px 10px;
  border-radius: 50px;
  margin-top: 5px;
  margin-bottom: 10px;
  @media only screen and (max-width: $breakpoint-tablet) {
    width: 100%;
    padding: 0px 0px;
  }
}

.first-calendar {
  border-right: 1px solid white;
}

.typeform-share:hover {
  color: white !important;
}
.typeform-share {
  display: block;
  text-align: center;
  color: white !important;
}

.input2 {
  width: 100%;
  border: 1px solid #d1d1d1;
  border-radius: 8px;
  height: 50px;
  padding: 0 16px;
  color: $primary-text;
  font-size: 16px;
  font-family: "Roboto", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;

  appearance: none;

  outline: none;
  background-color: white;

  transition: border 200ms;

  &:focus {
    border-color: $primary;
    @include shadow($primary);
  }

  &.has-error {
    border-color: $danger;

    &:focus {
      @include shadow($danger);
    }
  }
}

.offer-booking {
  position: unset !important;

  border: 1px solid #d1d1d1;
  border-radius: 30px 30px 30px 30px;

  background-color: $agri-green;
  color: white;

  label {
    font-size: 18px;
  }

  .dates {
    display: flex;
    flex-direction: column;

    &-inputs {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      grid-gap: 16px;
      margin-top: 8px;

      @media only screen and (max-width: $breakpoint-laptop-m) {
        grid-template-columns: 1fr;
      }
    }
  }

  .promocode {
    margin-top: 16px;
  }

  #promocode {
    width: 40%;
    margin-top: 8px;
    padding: 0 20px;
    border-radius: 50px;
    background-color: $agri-green-booking;
    color: white;
    border: 1px solid white;
    @media only screen and (max-width: $breakpoint-laptop-l) {
      width: 100%;
    }
  }

  .booking-button {
    margin: auto;
    margin-bottom: 1vw;

    background-color: $agri-yellow;
    color: black;
    padding: 5px 20px;
    border-radius: 50px;
    box-shadow: 1px 1px 12px #555;

    @media only screen and (max-width: $breakpoint-tablet) {
      width: 100%;
    }
  }

  .promocode {
    margin-top: 16px;
  }
}

.booking-title {
  font-size: 18px;
  text-transform: uppercase;
  text-align: center;
  font-weight: bold;
  color: white;
}

.offer-booking-fields {
  background-color: $agri-green-booking;
  padding: 30px 15px;
  border-radius: 30px 30px 0px 0px;
}

.booking-fields {
  display: grid;
  grid-template-columns: 55% 30%;
  column-gap: 10px;
  @media only screen and (max-width: $breakpoint-mobile-l) {
    grid-template-columns: auto;
    grid-row-gap: 1ch;
  }
  @media only screen and (max-width: $breakpoint-laptop-l) {
    display: flex;
    flex-direction: column;
  }
}

.dates2-inputs {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  @media only screen and (max-width: $breakpoint-mobile-l) {
    grid-template-columns: auto;
    border-radius: 25px;
  }

  border-radius: 50px;
  background-color: $agri-green-booking;
  padding: 0 20px;

  color: black;
  border: 1px solid white;
}

#numberPeople {
  @media only screen and (max-width: $breakpoint-laptop-l) {
    text-align: center;
  }
}
.people_count {
  select {
    @media only screen and (max-width: $breakpoint-laptop-l) {
      text-align-last: center;
    }
  }
}

#people_count {
  width: 100%;
  border-radius: 50px;
  padding: 5px;
  background-color: $agri-green-booking;
  color: white;
  border: 1px solid white;
  @media only screen and (max-width: $breakpoint-laptop-l) {
    width: 50%;
    text-align: center;
    margin-top: 15px;
  }
}

.offer-booking-pricing {
  padding: 32px;
  color: white;
  padding-bottom: 1vw;
}
</style>
