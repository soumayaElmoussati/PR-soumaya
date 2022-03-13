<template>
  <form
    class="booking-form"
    @submit.prevent="formSubmitted">
    <nuxt-link
      :to="{
        name: 'Offer',
        params: {
          id: getOffer.id,
          slug: getOffer.slug,
          domaine: residenceTypeAdress
        }
      }"
      class="btn btn-agri-previous"
      style="width: 150px;"
    >{{ $t("booking.demand.previous") }}</nuxt-link
    >

    <fieldset :disabled="loading">
      <p class="booking-title">
        {{ $t("booking.demand.infos") }}
      </p>
      <div class="form-group">
        <div class="form-input">
          <wi-input
            v-validate="'required|phone:FR'"
            id="phone"
            v-model="tempData.cellphone"
            :label="$t('becomeClient.fields.phone')"
            :error="errors.first('phone')"
            data-vv-as="numéro de téléphone"
            name="phone"
            type="tel"
            required
          />
        </div>

        <p>
          <i>{{ $t("booking.demand.messageDesc") }}</i>
        </p>

        <div class="form-input">
          <wi-textarea
            id="message"
            v-model="tempData.message"
            :label="$t('booking.demand.message')"
            :error="errors.first('message')"
            name="message"
            rows="5"
            word-count
          />
        </div>
      </div>

      <p class="body-1">
        <em>{{ $t("booking.demand.agriContact") }}</em>
      </p>

      <div class="checkbox">
        <input
          v-validate="'required'"
          id="tos"
          type="checkbox"
          name=""
          required
        >
        <label for="tos">
          {{ $t("booking.demand.accept") }}
          <nuxt-link :to="{ name: 'Terms', target: '_blank' }">{{
            $t("booking.demand.cgu")
          }}</nuxt-link>
        </label>
      </div>

      <br >
      <p
        v-if="error"
        class="error">

        {{ $t("booking.demand.error") }}
      </p>

      <div v-if="isClient">
        <button
          :disabled="loading"
          class="btn btn-agri-yellow finaly"
          type="submit">
          {{ loading ? "Réservation..." : $t("offer.buttons.book") }}
        </button>

        <br>

        <div
          v-if="!isManaged"
          class="chatroom">
          <nuxt-link
            :to="{
              name: 'ChatRoom',
              params: {
                id: getOffer.id
              }
            }"
            class="btn btn-agri-contact contactagri"
          >
            {{ $t("offer.buttons.contactAgri") }}
          </nuxt-link>
        </div>

        <div
          v-if="isManaged"
          class="chatroom">
          <nuxt-link
            :to="{
              name: 'ChatRoomTiny',
              params: {
                id: getOffer.id
              }
            }"
            class="btn btn-agri-contact"
          >
            {{ $t("offer.buttons.contactAgri") }}
          </nuxt-link>
        </div>

      </div>
      <div v-else>
        <button
          type="button"
          class="btn btn-agri-yellow"
          @click="showModal"
        >
          {{ $t('offer.buttons.requestReservation') }}
        </button>

      </div>

      <br>

    </fieldset>

    <div class="title-box">
      <p class="booking-title">{{ $t("booking.cancelling.conditions") }}</p>

      <img
        src="~assets/img/booking/arrow-down.svg"
        class="arrow-down"
        alt="arrow"
        @click="toggleShowCancel()"
      >
    </div>

    <div :class="{ active3: showCancel }">
      <div class="cancelling-box">
        <p>
          {{ $t("booking.cancelling.thirtyDays") }}<br >
          {{ $t("booking.cancelling.full") }}
        </p>

        <p>
          {{ $t("booking.cancelling.fiveteenDays") }}<br >
          {{ $t("booking.cancelling.half") }}
        </p>

        <p>
          {{ $t("booking.cancelling.days") }}<br >
          {{ $t("booking.cancelling.none") }}
        </p>

        <p>
          {{ $t("booking.cancelling.pandemia") }}<br >
          {{ $t("booking.cancelling.covid") }}
        </p>
      </div>
    </div>

    <div class="title-box">
      <p class="booking-title">{{ $t("booking.rules.settlement") }}</p>

      <img
        src="~assets/img/booking/arrow-down.svg"
        class="arrow-down"
        alt="arrow"
        @click="toggleShowSettlement()"
      >
    </div>

    <div :class="{ active: showSettlement }">
      <div class="settlement-box">
        <ul class="body-1">
          <li>
            {{ $t("booking.rules.babies")
            }}{{ getOffer.settlement.baby_suitable ? "Oui" : "Non" }}
          </li>
          <li>
            {{ $t("booking.rules.kids")
            }}{{ getOffer.settlement.child_suitable ? "Oui" : "Non" }}
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
              {{ $t("booking.rules.deposit") }}
              {{ getOffer.deposit | currency }}
            </div>
          </li>
        </ul>
      </div>
    </div>

    <div class="title-box">
      <p class="booking-title">{{ $t("booking.demand.location") }}</p>

      <img
        src="~assets/img/booking/arrow-down.svg"
        class="arrow-down"
        alt="arrow"
        @click="toggleShowMap()"
      >
    </div>

    <div :class="{ active2: showMap }">
      <div class="location-box">
        <div class="offer-farmer-location">
          <client-only>
            <l-map
              :zoom="zoom"
              :center="position"
              style="height: 100%; width: 100%;z-index: 1;"
            >
              <l-marker :lat-lng="position" />
              <l-tile-layer :url="url" />
            </l-map>
          </client-only>
        </div>
      </div>
    </div>

    <div class="body-1">
      <img
        id="booking-guide"
        src="~assets/img/booking/booking-guide.png"
        title="réservation"
        alt="réservation"
      >
    </div>

    <modal
      v-show="isModalVisible"
      @closeModal="closeModal"
    />

  </form>

</template>

<script>
import { mapGetters } from 'vuex'
import WiTextarea from '@/components/WiUI/Textarea'
import Modal from '@/components/Modal.vue'

export default {
  name: 'BookingForm',
  components: {
    WiTextarea,
    Modal
  },
  data () {
    return {
      showSettlement: false,
      showMap: false,
      showCancel: false,
      zoom: 8,
      url: process.env.MAPBOX_URL,
      loading: false,
      error: false,
      isModalVisible: false,
      tempData: {
        first_name: null,
        last_name: null,
        email: null,
        cellphone: null,
        message: null
      }
    }
  },

  computed: {
    ...mapGetters([
      'getOffer',
      'getBookingFromDate',
      'getBookingToDate',
      'getBookingPeopleCount',
      'getBookingPromocode',
      'getBookingId',
      'getBookingBreakfastOpt',
      'getBookingLinensOpt',
      'getBookingCleaningOpt',
      'isClient',
      'isManaged'
    ]),
    position () {
      return [this.getOffer.address.lat, this.getOffer.address.lng]
    },
    residenceTypeAdress () {
      // NOTE: Type de logement
      switch (this.getOffer.residence_type) {
        case 'entire_house':
          return 'LogementEntier'
        case 'private_room':
          return 'ChambrePrivee'
        case 'guest_room':
          return 'ChambreDHote'
        case 'unusual_room':
          return 'LogementInsolite'
        case 'tiny_house':
          return 'TinyHouse'
        case 'immersive_house':
          return 'LogementEnImmersion'
      }
    }
  },
  methods: {
    toggleShowSettlement () {
      this.showSettlement = !this.showSettlement
    },
    toggleShowMap () {
      this.showMap = !this.showMap
    },
    toggleShowCancel () {
      this.showCancel = !this.showCancel
    },
    showModal () {
      this.isModalVisible = true
    },
    closeModal (value) {
      this.isModalVisible = value
    },
    formSubmitted () {
      this.$validator.validateAll().then(result => {
        if (result) {
          /**
           * Set client
           */
          this.loading = false
          this.$axios
            .post('/clients', {
              client: {
                user: {
                  first_name: this.$auth.user.first_name,
                  last_name: this.$auth.user.last_name,
                  email: this.$auth.user.email,
                  cellphone: this.$auth.user.cellphone
                }
              }
            })
            .then(res => {
              if (
                res.status === 201
              ) {
                const data = {
                  offer_id: this.getOffer.id,
                  client_id: this.$auth.user.client.id,
                  people_count: this.getBookingPeopleCount,
                  arrival_date: this.getBookingFromDate,
                  departure_date: this.getBookingToDate,
                  promo_code: this.getBookingPromocode,
                  breakfast_opt: this.getBookingBreakfastOpt,
                  linens_opt: this.getBookingLinensOpt,
                  cleaning_opt: this.getBookingCleaningOpt,
                  message: this.tempData.message,
                  contact_number: this.tempData.cellphone,
                  status: 'pending'
                }

                /**
                 * Once the user is created, we can create a booking
                 */
                this.$axios
                  .post('/bookings', data)
                  .then(bookingRes => {
                    this.$router.push({
                      name: 'OfferBookingDone'
                    })
                  })
                  .catch(bookingErr => {
                    this.error = true
                    console.error('booking error', bookingErr)
                  })
                  .finally(() => {
                    this.loading = false
                  })
              } else {
                this.error = true
                console.error('Error occured', res)
              }
            })
            .catch(err => {
              console.log('erorr occured', err)
              this.loading = false
              this.error = true
            })
        }
      })
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.title-box {
  display: grid;
  grid-template-columns: 300px auto;
  text-transform: uppercase;
  @media only screen and (max-width: $breakpoint-mobile-l) {
    display: flex;
  }
}

.settlement-box {
  visibility: hidden;
  height: 0;
  transition: opacity 0.3s, height 0.3s 0.1s;
}

.active .settlement-box {
  visibility: visible;
  height: 230px;
  transition: opacity 0.3s 0.1s, height 0.3s;
}

.location-box {
  visibility: hidden;
  height: 0;
  transition: opacity 0.3s, height 0.3s 0.1s;
}

.active2 .location-box {
  visibility: visible;
  height: 230px;
  transition: opacity 0.3s 0.1s, height 0.3s;
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

.arrow-down {
  color: $agri-green-light;
  width: 100%;
  height: 30px;
  margin: auto;
  cursor: pointer;
}

.booking-title {
  font-weight: bold;
}

.offer-farmer-location {
  height: 100%;
  width: 260px;
  display: flex;
  flex-direction: column;
  align-items: center;
  align-self: center;
  justify-self: center;
  @media only screen and (max-width: $breakpoint-mobile-l) {
    width: 100%;
    padding: 20px;
  }
}

#booking-guide {
  width: 100%;
  margin-top: 40px;
}

.contactagri {
  @media only screen and (max-width: $breakpoint-mobile-l) {
    width: max-content;
  }
}

.finaly {
  width: max-content;
  @media only screen and (max-width: $breakpoint-tablet) {
    height: auto;
  }
  @media only screen and (max-width: $breakpoint-mobile-l) {
    line-height: normal;
    padding: 4%;
    width: auto;
  }
}

.booking-form {
  margin-top: 32px;
  width: 80%;
  margin-bottom: 50px;

  @media only screen and (max-width: $breakpoint-tablet) {
    width: 100%;
  }

  fieldset {
    padding: 0;
    border: none;

    legend {
      font-size: 22px;
      color: $primary-text;
      margin-bottom: 16px;
    }
  }

  .form-group {
    display: grid;
    grid-template-columns: 1fr;
  }

  .form-input {
    display: flex;
    flex-direction: column;

    label {
      font-size: 16px;
      margin-bottom: 8px;
    }
  }

  .checkbox {
    display: flex;

    input {
      appearance: none;
      width: 20px;
      height: 20px;
      border: 1px solid $agri-green-light;

      &:checked {
        background-color: $agri-green-light;
        border-color: $agri-green-light;
      }
    }

    label {
      color: $agri-green;
      margin-left: 8px;
    }
  }

  input[type="submit"] {
    margin-top: 32px;
  }
}
</style>
