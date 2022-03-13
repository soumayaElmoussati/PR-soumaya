<template>
  <div class="offer-rules">
    <h2 class="content-title">
      {{ $t("offer.titles.rules") }}
    </h2>
    <ul class="body-1">
      <li>
        {{ $t("booking.rules.babies") }}
        {{ getOffer.settlement.baby_suitable ? "Oui" : "Non" }}
      </li>
      <li>
        {{ $t("booking.rules.kids") }}
        {{ getOffer.settlement.child_suitable ? "Oui" : "Non" }}
      </li>
      <li>
        {{ $t("booking.rules.smoke") }}
        {{ getOffer.settlement.smooking_allowed ? "Oui" : "Non" }}
      </li>
      <li>
        {{ $t("booking.rules.parties") }}
        {{ getOffer.settlement.parties_allowed ? "Oui" : "Non" }}
      </li>
      <li>
        {{ $t("booking.rules.handicap") }}
        {{ getOffer.settlement.accessible ? "Oui" : "Non" }}
      </li>
      <li>
        {{ $t("booking.rules.animals") }}
        {{ getOffer.settlement.animals_welcome ? "Oui" : "Non" }}
      </li>
      <li>
        <div v-if="getOffer.deposit">
          {{ $t("booking.rules.deposit") }} {{ getOffer.deposit | currency }}
        </div>
      </li>
    </ul>
    <div v-if="getOffer.settlement.additional_rules">
      <h3 class="content-title">
        {{ $t('offer.titles.additional') }}
      </h3>
      <ul class="body-1">
        <li>
          {{ getOffer.settlement.additional_rules }}
        </li>
      </ul>
    </div>

    <div class="time-label__fields">
      <p class="body-1 arrival-fields">
        <i
          id="icon-plane-ar"
          class="icon-plane-ar"
          aria-hidden="true" />
        <br >
        <em class="time-title">{{ $t('offer.paragraphs.arriveTime') }}</em>
      </p>

      <p class="body-1 arrival-fields">
        <i
          id="icon-plane-dep"
          class="icon-plane-dep"
          aria-hidden="true" />
        <br >
        <em class="time-title">{{ $t('offer.paragraphs.startTime') }}</em>
      </p>
    </div>

    <div class="time-field__fields">
      <div>
        <p class="arrival-fields">
          {{ getOffer.arriving_time }} <span>H</span> {{ formatArrivalMin }}
        </p>
      </div>

      <div>
        <p class="departure-fields">
          {{ getOffer.departure_time }} <span>H</span> {{ formatDepartureMin }}
        </p>
      </div>
    </div>
    <div style="display: flex">
      <h2 class="content-title">
        {{ $t("offer.titles.conditions") }}
      </h2>
      <img
        src="~assets/img/booking/arrow-down.svg"
        class="arrow-down"
        alt="arrow"
        @click="toggleShowCancel()"
      >
    </div>
    <div :class="{ active3: showCancel }">
      <ul class="cancelling-box">
        <li>
          {{ $t("booking.cancelling.thirtyDays") }}<br >
          {{ $t("booking.cancelling.full") }}
        </li>

        <li>
          {{ $t("booking.cancelling.fiveteenDays") }}<br >
          {{ $t("booking.cancelling.half") }}
        </li>

        <li>
          {{ $t("booking.cancelling.days") }}<br >
          {{ $t("booking.cancelling.none") }}
        </li>

        <li>
          {{ $t("booking.cancelling.pandemia") }}<br >
          {{ $t("booking.cancelling.covid") }}
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'OfferRules',
  data () {
    return {
      showCancel: false
    }
  },
  computed: {
    ...mapGetters(['getOffer']),
    formatArrivalMin () {
      var number = this.getOffer.arriving_min_time
      if (number < 10) {
        var numStr = '0' + number
        return numStr
      }
      if (number >= 10) {
        var numStrclean = number
        return numStrclean
      }
    },
    formatDepartureMin () {
      var number = this.getOffer.departure_min_time
      if (number < 10) {
        var numStr = '0' + number
        return numStr
      }
      if (number >= 10) {
        var numStrclean = number
        return numStrclean
      }
    }
  },
  methods: {
    toggleShowCancel () {
      this.showCancel = !this.showCancel
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.welcome-title {
  font-size: 20px;
}

.arrow-down {
  color: $agri-green-light;
  width: 20%;
  height: 30px;
  margin: auto;
}

.cancelling-box {
  visibility: hidden;
  height: 0;
  transition: opacity 0.3s, height 0.3s 0.1s;
}

.active3 .cancelling-box {
  visibility: visible;
  height: 230px;
  transition: opacity 0.3s 0.1s, height 0.3s;
}

.offer-rules {
  .content-title {
    text-transform: uppercase;
    color: #476458;
    font-size: 21px;
    font-weight: 900;
    margin-top: 20px;
  }

  li {
    font-size: 15px;
    font-weight: bold;
    color: #476458;
    margin-bottom: 5px;
  }

  h3 {
    font-size: 20px;
    font-weight: 400;
    color: $primary-text;
  }
}

.time-label {
  &__fields {
    display: grid;
    grid-template-columns: repeat(2, calc(25%));
    grid-gap: 5px;
    text-align: center;

    @media only screen and (max-width: 768px) {
      grid-template-columns: repeat(2, calc(50%));
    }
  }
}

.time-field {
  &__fields {
    display: grid;
    grid-template-columns: repeat(2, calc(25%));
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
  color: #476458;
  font-size: 14px;
  font-weight: bold;
}

.departure-fields {
  margin-top: 0px;
  margin-bottom: 0px;
  text-align: center;
  color: #476458;
  font-size: 14px;
  font-weight: bold;
}

.time-title {
  color: #476458;
  font-size: 14px;
  font-weight: normal;
}
</style>
