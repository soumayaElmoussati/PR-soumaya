<template>
  <div class="new-offer">
    <div class="wrap">

      <form @submit.prevent="submitted">
        <div class="offer-location side">
          <p class="title-side">
            🎁 Donnez-nous votre avis et recevez 15€ en carte cadeau à réutiliser ou à offrir !
          </p>
          <div class="offer-location__infos">
            <fieldset>

              <h4>
                Dans quel cadre êtes-vous partis ?
              </h4>

              <input
                id="famille"
                v-model="data.situation"
                type="radio"
                value="familly">
              <label for="famille">Famille</label>
              <input
                id="couple"
                v-model="data.situation"
                type="radio"
                value="couple">
              <label for="couple">Couple</label>
              <input
                id="amis"
                v-model="data.situation"
                type="radio"
                value="friends">
              <label for="amis">Amis</label>
              <input
                id="seul"
                v-model="data.situation"
                type="radio"
                value="alone">
              <label for="seul">Seul</label>

              <br>

              <h4>
                Votre séjour a t’il été à la hauteur de vos attentes ?
              </h4>

              <p>Le logement</p>

              <star-rating
                v-model="data.lodging"
                active-color="#476458"/>

              <br>

              <p>L’activité découverte</p>

              <star-rating
                v-model="data.activity"
                active-color="#476458"/>

              <br>

              <p>Les options choisies (petit déjeuner, spa, vélo...)</p>

              <star-rating
                v-model="data.services"
                active-color="#476458"/>

              <br>

              <p>Le contact avec vos hôtes</p>

              <star-rating
                v-model="data.contact"
                active-color="#476458"/>

              <br>

              <p>Le processus de réservation</p>

              <star-rating
                v-model="data.process"
                active-color="#476458"/>

              <br>

              <p>Quel conseil donneriez-vous à l’agriculteur pour améliorer son offre ? </p>

              <wi-textarea
                v-validate="'max:1500'"
                id="tripNote"
                v-model="data.trip_note"
                :error="errors.first('tripe_note')"
                data-vv-as="trip_note"
                name="tripNote"
                placeholder="Tapez ici si vous avez des renseignments supplémentaires"
                rows="5"
                word-count
              />

              <h4>
                Quelle note donneriez-vous à votre séjour ?
              </h4>

              <star-rating
                v-model="data.star"
                active-color="#476458"/>

              <h4>
                Recommanderiez-vous un séjour à la ferme à votre entourage ?
              </h4>

              <input
                id="ouiReference"
                v-model="data.reference"
                type="radio"
                value="oui">
              <label for="ouiReference">Oui</label>
              <input
                id="nonReference"
                v-model="data.reference"
                type="radio"
                value="non">
              <label for="nonReference">Non</label>

              <h4>
                Donnez un commentaire général de la réservation (celui-ci sera visible sur l’annonce) :
              </h4>

              <wi-textarea
                v-validate="'required|max:1500'"
                id="comment"
                v-model="data.comment"
                :error="errors.first('comment')"
                data-vv-as="comment"
                name="comment"
                label="Commentaire"
                rows="5"
                word-count
                required
              />

            </fieldset>
          </div>
        </div>

        <div class="side">
          <div class="buttons">
            <button
              :disabled="$wait.is('creating offer')"
              type="submit"
              class="btn btn-agri-yellow"
            >
              <span v-if="!$wait.is('creating offer')">
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
  name: 'NewReview',
  components: {
    WiInput,
    WiSpinner,
    WiTextarea
  },
  head () {
    return {
      title: 'Déposer un avis'
    }
  },
  data () {
    return {
      data: {
        star: 0,
        comment: null,
        situation: null,
        lodging: 0,
        activity: 0,
        services: 0,
        contact: 0,
        process: 0,
        reference: null,
        trip_note: null
      }
    }
  },
  methods: {
    ...mapActions(['setCurrentReview']),
    submitted () {
      this.$validator.validateAll().then(valid => {
        if (valid) {
          if (this.$wait.is('creating review')) return

          /**
           * The form data is entirely valid
           */
          this.$wait.start('creating review')
          this.$axios
            .post('/reviews', {
              review: {
                booking_id: this.$route.params.booking,
                star: this.data.star,
                comment: this.data.comment,
                situation: this.data.situation,
                lodging: this.data.lodging.toString(),
                activity: this.data.activity.toString(),
                services: this.data.services.toString(),
                contact: this.data.contact.toString(),
                process: this.data.process.toString(),
                reference: this.data.reference,
                trip_note: this.data.trip_note
              }
            })
            .then(response => {
              if (response.status === 201) {
                /**
                 * Everything went well
                 */
                this.setCurrentReview(response.data)
                this.$router.push({
                  name: 'DoneReview'
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
  font-size: 20px;
  text-transform: none;
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
