<template>
  <div class="new-offer">
    <div class="wrap">
      <div class="side">
        <p class="title-side">
          Comment évalueriez-vous votre éxpérience ?
        </p>
      </div>

      <form @submit.prevent="submitted">
        <div class="offer-location side">
          <div class="offer-location__infos">
            <fieldset>

              <p>Propreté du logement à son départ </p>

              <star-rating
                v-model="data.cleanliness"
                active-color="#476458"/>

              <br>

              <p>Communication claire</p>

              <star-rating
                v-model="data.communication"
                active-color="#476458"/>

              <br>

              <p>Réspect du réglement inéterieur</p>

              <star-rating
                v-model="data.respect"
                active-color="#476458"/>

              <br>

              <p>Expérience générale</p>

              <star-rating
                v-model="data.experience"
                active-color="#476458"/>

              <br>

              <p>Souhaiteriez-vous accueillir ce vacancier à nouveau ? </p>

              <input
                id="ouiWelcome"
                v-model="data.welcome"
                type="radio"
                value="true">
              <label for="ouiWelcome">Oui</label>
              <input
                id="nonWelcome"
                v-model="data.welcome"
                type="radio"
                value="false">
              <label for="nonWelcome">Non</label>

              <br>

              <p>Donnez un commentaire général de la réservation</p>

              <wi-textarea
                v-validate="'max:1500'"
                id="comment"
                v-model="data.comment"
                :error="errors.first('comment')"
                data-vv-as="comment"
                name="comment"
                placeholder="Tapez ici"
                rows="5"
                word-count
              />

            </fieldset>
          </div>
        </div>

        <div class="side">
          <div class="buttons">
            <button
              :disabled="$wait.is('creating farmer review')"
              type="submit"
              class="btn btn-agri-yellow"
            >
              <span v-if="!$wait.is('creating farmer review')">
                Envoyer mon avis
              </span>
              <wi-spinner v-else />
            </button>
            <div
              v-if="errors.items.length"
              style="margin-left: 1em; color: red">
              {{ $t("offer.infos.check") }}
            </div>
          </div>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import { mapActions } from 'vuex'

import WiInput from '@/components/WiUI/Input'
import WiTextarea from '@/components/WiUI/Textarea'
import WiSpinner from '@/components/WiUI/Spinner'

export default {
  name: 'NewFarmerReview',
  components: {
    WiInput,
    WiSpinner,
    WiTextarea
  },
  head () {
    return {
      title: 'Déposer un avis sur votre client'
    }
  },
  data () {
    return {
      data: {
        comment: null,
        cleanliness: null,
        communication: null,
        respect: null,
        experience: null,
        welcome: null
      }
    }
  },
  methods: {
    ...mapActions(['setCurrentFarmerReview']),
    submitted () {
      this.$validator.validateAll().then(valid => {
        if (valid) {
          if (this.$wait.is('creating farmer review')) return

          /**
           * The form data is entirely valid
           */
          this.$wait.start('creating farmer review')
          this.$axios
            .post('/farmer_reviews', {
              farmer_review: {
                booking_id: this.$route.params.booking,
                comment: this.data.comment,
                cleanliness: this.data.cleanliness.toString(),
                communication: this.data.communication.toString(),
                respect: this.data.respect.toString(),
                experience: this.data.experience.toString(),
                welcome: Boolean(this.data.welcome)
              }
            })
            .then(response => {
              if (response.status === 201) {
                /**
                 * Everything went well
                 */
                this.setCurrentFarmerReview(response.data)
                this.$router.push({
                  name: 'DoneFarmerReview'
                })
              } else {
                /**
                 * Some error occured
                 */
                console.log('Some error occured...', response)
              }
            })
            .catch(err => {
              console.error('Error from the request', err)
            })
            .finally(() => this.$wait.end('creating review'))
        }
      })
    }
  }
}
</script>

<style lang="scss" scoped>
@import "@/assets/scss/_variables.scss";

.title-side {
  color: black;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.headline {
  padding-top: 20px;
  text-transform: uppercase;
  font-size: 18px;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
}

.side {
  background-color: white;
  margin: 0 auto;
  padding: 30px;
  width: 75%;
}

.body-1 em {
  font-size: 14px;
}

.housing-types__item label {
  font-size: 14px;
  color: #476458;
  font-family: "Avenir", -apple-system, BlinkMacSystemFont, "Segoe UI", Oxygen,
    Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif;
  font-weight: bold;
}

span.wi-textarea__label__wordcount {
  font-size: 12px;
}

.wi-input__caption {
  font-size: 14px !important;
}

.done {
  padding-top: 40px;
}

.housing-field {
  display: grid;
  grid-template-columns: 60% 20%;
}

.new-offer {
  padding-top: 0px;

  .side {
    width: 90%;
    @media only screen and (max-width: $breakpoint-tablet) {
      width: 100%;
    }
  }

  .offer-location {
    &__infos {
      &__fields {
        display: grid;
        grid-template-columns: 50% 50%;
        grid-gap: 30px;
        grid-column-gap: 77px;

        @media only screen and (max-width: $breakpoint-tablet) {
          display: block;
          grid-gap: 16px;
        }
      }
    }
  }

  .housing-types {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    grid-gap: 20px;
  }

  fieldset {
    border: none;
    margin: 0;
    padding-left: 0;
    padding-right: 0;
  }

  .buttons {
    display: flex;
    align-items: center;
  }

  .complement {
    &__fields {
      display: grid;
      grid-template-columns: repeat(2, calc(50% - 8px));
      grid-gap: 20px;
      grid-column-gap: 25px;

      @media only screen and (max-width: $breakpoint-tablet) {
        grid-template-columns: 1fr;
      }
    }
  }

  .time-label {
    &__fields {
      display: grid;
      grid-template-columns: repeat(2, calc(13%));
      grid-gap: 85px;

      @media only screen and (max-width: $breakpoint-tablet) {
        grid-template-columns: 1fr;
      }
    }
  }

  .time-field {
    &__fields {
      display: grid;
      grid-template-columns: repeat(4, calc(10% - 8px));
      grid-gap: 10px;

      @media only screen and (max-width: $breakpoint-tablet) {
        grid-template-columns: 1fr;
      }
    }
  }

  .rooms,
  .description,
  .complement {
    margin-top: 16px;

    > .body-1 {
      margin-top: 0;
    }
  }
}
</style>
