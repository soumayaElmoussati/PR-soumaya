<template>
  <form
    class="booking-form"
    @submit.prevent="formSubmitted"
  >
    <fieldset :disabled="loading">
      <legend>
        {{ $t("activity.legend.info") }}
      </legend>
      <div class="form-group">

        <div class="form-input">
          <label for="phone">
            {{ $t('offer.fields.phone') }}
          </label>
          <input
            v-validate="'required'"
            id="phone"
            v-model="tempData.cellphone"
            type="tel"
            class="input"
            name="phone"
            required
          >
        </div>
      </div>

      <p class="body-1">
        <em>{{ $t("activity.paragraphs.contact") }}</em>
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
          {{ $t("activity.legend.agree") }} <nuxt-link :to="{ name: 'Terms' , target: '_blank'}">{{ $t("activity.legend.conditions") }}</nuxt-link>
        </label>
      </div>

      <br>
      <p
        v-if="error"
        class="error"
      >
        {{ $t("activity.paragraphs.errors") }}
      </p>

      <button
        :disabled="loading"
        class="btn btn-primary"
        type="submit"
      >
        {{ loading ? 'Réservation...' : $t('activity.buttons.book') }}
      </button>
      <div class="body-1">
        <img
          id="booking-guide"
          src="~assets/img/booking/booking-guide.png"
          title="réservation"
          alt="réservation">
          <!-- <em>Le paiement sera demandé une fois la réservation acceptée par l'agriculteur</em> -->

      </div>

    </fieldset>
  </form>
</template>

<script>
  import { mapGetters } from 'vuex'

  export default {
    name: 'BookingForm',
    data () {
      return {
        loading: false,
        error: false,
        tempData: {
          first_name: this.$auth.user.first_name,
          last_name: this.$auth.user.last_name,
          email: this.$auth.user.email,
          cellphone: this.$auth.user.cellphone }
      }
    },

    computed: {
      ...mapGetters([
        'getActivity',
        'getBookingFromDate',
        'getBookingToDate',
        'getBookingPeopleCount',
        'getBookingPromocode'
      ])
    },
    methods: {
      formSubmitted () {
        this.$validator.validateAll()
          .then((result) => {
            if (result) {
              /**
               * Create client
               */
              this.loading = false
              this.$axios.post('/clients', {
                client: {
                  user: this.tempData
                }
              })
                .then((res) => {
                  if (res.status === 201) {
                    const data = {
                      activity_id: this.getActivity.id,
                      client_id: res.data.id,
                      people_count: this.getBookingPeopleCount,
                      arrival_date: this.getBookingFromDate,
                      departure_date: this.getBookingToDate,
                      promo_code: this.getBookingPromocode,
                      status: 'pending'
                    }

                    /**
                     * Once the user is created, we can create a booking
                     */
                    this.$axios.post('/activity_bookings', data)
                      .then((bookingRes) => {
                        this.$router.push({
                          name: 'ActivityBookingDone'
                        })
                      })
                      .catch((bookingErr) => {
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
                .catch((err) => {
                  console.log('erorr occured', err)
                  this.loading = false
                  this.error = true
                })
            } else {
              console.log('validation error')
            }
          })
      }
    }
  }
</script>

<style lang="scss" scoped>
  @import "@/assets/scss/_variables.scss";

  #booking-guide{
    width: 100%;
    margin-top: 40px;
  }

  .booking-form{
    margin-top: 32px;
    width: 80%;
    margin-bottom: 50px;

    @media only screen and (max-width: $breakpoint-tablet) {
      width: 100%;
    }

    fieldset{
      padding: 0;
      border: none;

      legend{
        font-size: 22px;
        color: $primary-text;
        margin-bottom: 16px;
      }
    }

    .form-group{
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      grid-gap: 16px;

      @media only screen and (max-width: $breakpoint-mobile-l) {
        grid-template-columns: 1fr;
      }
    }

    .form-input{
      display: flex;
      flex-direction: column;

      label{
        font-size: 16px;
        margin-bottom: 8px;
      }
    }

    .checkbox{
      display: flex;

      input{
        appearance: none;
        width: 20px;
        height: 20px;
        border: 1px solid $third-text;

        &:checked{
          background-color: $primary;
          border-color: $primary;
        }
      }

      label{
        color: $secondary-text;
        margin-left: 8px;
      }
    }

    input[type=submit] {
      margin-top: 32px;
    }
  }
</style>
