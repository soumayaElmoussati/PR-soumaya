<template>
  <form
    class="offer-booking"
    @submit.prevent="formSubmitted">
    <div class="offer-booking-fields">
      <p class="booking-title">{{ $t("activity.titles.organise") }}</p>

      <div class="booking-fields">

        <div class="dates">
          <div class="dates2-inputs">
            <datepicker
              ref="datepicker1"
              :disabled-dates="CatchEnd"
              :monday-first="true"
              :format="'jj-MM-aaaa'"
              :language="fr"
              v-model="from"
              :input-class="'input2 input-booking'"
              :editable="false"
              :placeholder="$t('home.placeholder.arrive')"
              :highlighted="highlightedDates"
            />
          </div>
        </div>

        <div class="people_count">
          <div>
            <select
              id="people_count"
              v-model="peopleCount"
              name="people_count"
              class="input"
              required
              @input="setBookingPeopleCount(peopleCount)"
            >
              <option
                v-for="(count, k) in getPeopleCount"
                :key="k"
                :value="count">
                {{ $tc('activity.fields.peopleCount', count, {
                  count
                }) }}
              </option>
            </select>
          </div>
        </div>

      </div>

      <div class="time-infos">

        <div class="time-label__fields">

          <p class="body-1 arrival-fields">
            <i
              id="icon-plane-ar"
              class="icon-plane-ar"
              aria-hidden="true"
            />
            <br>
            <em class="time-title">{{ $t("activity.paragraphs.finishTime") }}</em>
          </p>

          <p class="body-1 arrival-fields">
            <i
              id="icon-plane-dep"
              class="icon-plane-dep"
              aria-hidden="true"
            />
            <br>
            <em class="time-title">{{ $t("activity.paragraphs.startTime") }}</em>
          </p>

        </div>

        <div class="time-field__fields">

          <div>
            <p class="arrival-fields">{{ getActivity.arriving_time }} <span>H</span> {{ formatArrivalMin }} </p>
          </div>

          <div >
            <p class="departure-fields">{{ getActivity.departure_time }} <span>H</span> {{ formatDepartureMin }} </p>
          </div>

        </div>

      </div>

      <div class="promocode">
        <label for="promocode">{{ $t("activity.legend.code") }}</label>
        <div>
          <input
            id="promocode"
            v-model="promocode"
            name="promocode"
            type="text"
            class="input"
            @input="setBookingPromocode(promocode)">
        </div>
      </div>

      <div class="people_count">
        <div/>
      </div>

    </div>
    <activity-booking-pricing ref="activityBookingPricing" />

    <input
      v-if="canSubmit && isClient"
      id="bookingbtn"
      type="submit"
      value="Demande de réservation"
      class="btn booking-button"
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
import ActivityBookingPricing from './_subs/ActivityBookingPricing'

import Datepicker from 'vuejs-datepicker'

export default {
  name: 'ActivityBooking',
  components: {
    ActivityBookingPricing,
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
      fr: {
        language: 'French',
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
      return this.getCurrentActivityBookings
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
    minDate () {
      return format(addDays(new Date(), 1), 'YYYY-MM-DD')
    },
    minTargetDate () {
      return this.from
        ? format(this.from, 'YYYY-MM-DD')
        : format(addDays(new Date(), 1), 'YYYY-MM-DD')
    },
    getPeopleCount () {
      return Array.from(new Array(this.getActivity.max_people_count)).map(
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
    ...mapGetters([
      'getBookingFromDate',
      'getBookingPeopleCount',
      'getBookingPromocode',
      'getActivity',
      'getCurrentActivityBookings',
      'isClient',
      'isFarmer'
    ]),
    hasBookingButton () {
      return this.$route.name === 'Activity'
    },
    canBook () {
      return this.getBookingFromDate !== null
    }
  },
  methods: {
    ...mapActions([
      'setBookingFromDate',
      'setBookingToDate',
      'setBookingPeopleCount',
      'setBookingPromocode'
    ]),
    formSubmitted () {
      if (this.canBook) {
        this.$router.push({
          name: 'ActivityBooking',
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

.time-infos {
  margin-top: 2vh;
}

.time-label{
  &__fields{
    display: grid;
    grid-template-columns: repeat(2, calc(50%));
    grid-gap: 5px;
    text-align: center;

    @media only screen and (max-width: 768px) {
      grid-template-columns: repeat(2, calc(50%));
    }
  }
}

.time-field{
  &__fields{
    display: grid;
    grid-template-columns: repeat(2, calc(50%));
    grid-gap: 10px;

    @media only screen and (max-width: 768px) {
      grid-template-columns: repeat(2, calc(50%));
    }
  }
}

.arrival-fields {
  margin-top: 0px;
  margin-bottom: 0px;
  text-align: center;
  color: white;
  font-size: 14px;
  font-weight: bold;
}

.departure-fields {
  margin-top: 0px;
  margin-bottom: 0px;
  text-align: center;
  color: white;
  font-size: 14px;
  font-weight: bold;
}

.time-title {
  color: white;
  font-size: 14px;
  font-weight: normal;
}

.icon-plane-ar:before {
  color: white !important;
}

.icon-plane-dep:before {
  color: white !important;
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

  background-color: #466357;
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
    width: 30%;
    margin-top: 8px;
    padding: 0 20px;
    border-radius: 50px;
    background-color: #44933b;
    color: white;
    border: 1px solid white;
  }

  .people_count {

  }

  #people_count {
    width: 100%;
  }

  .booking-button {
    margin: auto;
    margin-bottom: 1vw;

    background-color: #EFCE4A;
    color: black;
    padding: 5px 20px;
    border-radius: 50px;
    box-shadow: 1px 1px 12px #555;

    @media only screen and (max-width: $breakpoint-tablet) {
      width: 100%;
    }
  }

  .contact-btn {
    margin: auto;
    background-color: $agri-green;
    color: white;
    padding: 0px 10px;
    border-radius: 50px;
    margin-top: 5px;
    margin-bottom: 10px;
    font-size: 12px;

    @media only screen and (max-width: $breakpoint-tablet) {
      width: 100%;
      padding: 0px 0px;
    }
  }

  .promocode {
    margin-top: 16px;
  }
}

/////////

.booking-title {
  font-size: 18px;
  text-transform: uppercase;
  text-align: center;
  font-weight: bold;
  color: white;
}

.offer-booking-fields {
  background-color: #43943C;
  padding: 30px 15px;
  border-radius: 30px 30px 0px 0px;
}

.booking-fields {
  display: grid;
  grid-template-columns: 55% 35%;
  column-gap: 10px;
  @media only screen and (max-width: $breakpoint-mobile-l) {
    grid-template-columns: auto;
    grid-row-gap: 1ch;
  }
}

.dates2-inputs {
  display: grid;
  grid-template-columns: auto;
  @media only screen and (max-width: $breakpoint-mobile-l) {
    grid-template-columns: auto;
    border-radius: 25px;
  }

  border-radius: 50px;
  background-color: #44933B;
  padding: 0 20px;

  color: black;
  border: 1px solid white;

}

#people_count {
  border-radius: 50px;
  background-color: #44933B;
  color: white;
  border: 1px solid white;
}

.offer-booking-pricing {
  padding: 32px;
  padding-bottom: 1vw;
  color: white;
}
</style>
